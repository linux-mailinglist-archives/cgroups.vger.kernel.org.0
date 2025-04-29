Return-Path: <cgroups+bounces-7925-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB58AA3CB9
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059841A8520C
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C774E231855;
	Tue, 29 Apr 2025 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEWjdksb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564FD2E62C2;
	Tue, 29 Apr 2025 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969945; cv=none; b=n78HJc9tSPcYxYVP22EAVCuYm363GGICrqxlY7D7DbD+LCMRxQBoek2IYanpM3I3Em9bY1Y6h5lxP0ulfXhRbUx4vMVeezU/LhlwsgqhMqnJJlU922wUOmsDmQ3hyw0ly9KRD/PoTb4O2PPGjUi4oKzIg37LNwDV2wyWjZz69FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969945; c=relaxed/simple;
	bh=jbqrUtYtzNa6LKzb9EuCsr+nQwCoCI6+ju1wQS/Q8fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BY9L+BC8TiQOJS2LVnsnwxtD5op2jZi529NQH0IZqTGSnKjRW55PGjmt2LakcZ0Or3AXU0vGt9w2qEH4hnuLxaAfI64yr5o6cujL+5i4u+K6Mqdye02NLolu8yBIcnNUaHBLPuzXekOYJ1ZJCwugBnQG6EjLwii+eA6WhkTX+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEWjdksb; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e6e1cd3f451so5410218276.2;
        Tue, 29 Apr 2025 16:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969942; x=1746574742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2S3fikh6wnFZd7wLpLwS9wxRlqN0WemSs8LsRqS7Hc=;
        b=UEWjdksbTZ4BDqDnlX4+ZtB5LYMSR0MYSefYxQOwx95jXPqPvGB0NxJlP086mKHWAr
         rs/g0VH0zsTQw1GhxA7jA2CRxQAMx04K9kXI8AUf/aTGqEzkBXo1YuRXivMZcSq5OoFY
         rK5INbn5rKpZieNZS37WTPnOgbK4S/wubMyO0lcmbVR7KlijdiIuafh+TAwoUmiRUtlL
         p74CA0Ps0+zpBqZ/B1KtdU/unTjJQyTSMpF049j9ctbapofKyhGwpGzyjw9rVp3boZRM
         jq64BeRZpi6ZVuR9DUusor9lib8xUUEUWPlix57c2vZpLXp+TRTX/PV+lD7qEGDmsOCO
         uvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969942; x=1746574742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2S3fikh6wnFZd7wLpLwS9wxRlqN0WemSs8LsRqS7Hc=;
        b=UshczbXPUyKx3hwmOClCslgZzckEIGijTBRwWVVGiYRwKtycpLQ2VP30tH38+jzG4e
         tRqXghg00B1amrlGqYGhVbmX2SdVzOrFqcuV+MRowNGvUwdhxh8Xu1VjyZls4oDMpCR7
         1oWDuexlq/wnEPejxueevc8JtwrywP2BATC3c9BhZX3yNgM7eoi02+FKqYfHgWoN61wT
         d8q89H4JjExMGQRNUSI1EGXihI7KfdIoVp76b7+tAo4V8wM5XOWhsK6hBFLiJ+y1PljQ
         XdaeVVwoCz1PEB7+xX2b6P7pWbGYg9E+AxlatbTYuWJe5WebGzKvBjN7wm2QUWmNZpf1
         NU/A==
X-Forwarded-Encrypted: i=1; AJvYcCULAHZ0wh2xqOiwjcMhElpvbXzBLZOqffyIqPss+sXh0YPj2jmzVLv5b1dKh+U9E32oswWhChl+/nM=@vger.kernel.org, AJvYcCUjDOfQv0T5qtnyr7p7f198hg4zVEqReDGXea7bAYgLSbvieDz27OsoSXpbhCRlPhwCJchPApxG@vger.kernel.org, AJvYcCXZkEkBYoA93K/85kKC5rcNyYRBd8EzKPM0i/di0g/ecPWaEXi6fnkSTEc9zN9CmzrL4VXgJCpyRsEcvDOW@vger.kernel.org
X-Gm-Message-State: AOJu0YzBDnOhrt4vkUC92abAaq1zbP7Dw6FG56x6wslOmQGgh+sX7Ykt
	N7cofr+Ye9qaiBBbPrPHvSrJapFFcGVHc/WXmhl6+988w+2nWXRt
X-Gm-Gg: ASbGncuHWMhe7VORFH/YxHOeOjc9O7b9AHv6TCsgqPfX9wMQKGLCJFFDwOq8wM51tKY
	jCEp7tc+FfOm4fCkoRNjagib/Y6nZ+v8nTD69Oe6AFPYc1JH/dx6mGpfV7NjHYDah08rnmE7gFP
	+KHE8+Sz7VkmHyP5cpCWTLm1LUNR7BQ4gjldLVJ9T2SI/qdTz3YhLlZwqdPI5VR049yLK7A57/p
	F9wVPrMDb+7TIA7QsNvF31NrN6GHxuKZlkUS9SfNx1oURnaSv0FfGRpf2Uv5cU1H9hrLQ3g+X2G
	Sre/GNi0Q6Mb2CnggwnPFTGjbOgMcWt+
X-Google-Smtp-Source: AGHT+IFU9ZEHTZiihNXiiX7ZqSu0t5gcjbUJ3ndqu9lphvRCw+DJM5mi2qAtWYKs7OOSvIaNJnNGuw==
X-Received: by 2002:a05:6902:e04:b0:e73:192b:2963 with SMTP id 3f1490d57ef6-e73eaadb162mr1580318276.14.1745969942215;
        Tue, 29 Apr 2025 16:39:02 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7412a39697sm64520276.8.2025.04.29.16.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:39:01 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	yosry.ahmed@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	len.brown@intel.com,
	chengming.zhou@linux.dev,
	kasong@tencent.com,
	chrisl@kernel.org,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com
Subject: [RFC PATCH v2 14/18] memcg: swap: only charge physical swap slots
Date: Tue, 29 Apr 2025 16:38:42 -0700
Message-ID: <20250429233848.3093350-15-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429233848.3093350-1-nphamcs@gmail.com>
References: <20250429233848.3093350-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that zswap and the zero-filled swap page optimization no longer
takes up any physical swap space, we should not charge towards the swap
usage and limits of the memcg in these case. We will only record the
memcg id on virtual swap slot allocation, and defer physical swap
charging (i.e towards memory.swap.current) until the virtual swap slot
is backed by an actual physical swap slot (on zswap store failure
fallback or zswap writeback).

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  17 ++++++++
 mm/memcontrol.c      | 102 ++++++++++++++++++++++++++++++++++---------
 mm/vswap.c           |  43 ++++++++----------
 3 files changed, 118 insertions(+), 44 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 9c92a982d546..a65b22de4cdd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -690,6 +690,23 @@ static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
 void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry);
+
+void __mem_cgroup_record_swap(struct folio *folio, swp_entry_t entry);
+static inline void mem_cgroup_record_swap(struct folio *folio,
+		swp_entry_t entry)
+{
+	if (!mem_cgroup_disabled())
+		__mem_cgroup_record_swap(folio, entry);
+}
+
+void __mem_cgroup_unrecord_swap(swp_entry_t entry, unsigned int nr_pages);
+static inline void mem_cgroup_unrecord_swap(swp_entry_t entry,
+		unsigned int nr_pages)
+{
+	if (!mem_cgroup_disabled())
+		__mem_cgroup_unrecord_swap(entry, nr_pages);
+}
+
 int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry);
 static inline int mem_cgroup_try_charge_swap(struct folio *folio,
 		swp_entry_t entry)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 126b2d0e6aaa..c6bee12f2016 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5020,6 +5020,46 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	css_put(&memcg->css);
 }
 
+/**
+ * __mem_cgroup_record_swap - record the folio's cgroup for the swap entries.
+ * @folio: folio being swapped out.
+ * @entry: the first swap entry in the range.
+ *
+ * In the virtual swap implementation, we only record the folio's cgroup
+ * for the virtual swap slots on their allocation. We will only charge
+ * physical swap slots towards the cgroup's swap usage, i.e when physical swap
+ * slots are allocated for zswap writeback or fallback from zswap store
+ * failure.
+ */
+void __mem_cgroup_record_swap(struct folio *folio, swp_entry_t entry)
+{
+	unsigned int nr_pages = folio_nr_pages(folio);
+	struct mem_cgroup *memcg;
+
+	memcg = folio_memcg(folio);
+
+	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
+	if (!memcg)
+		return;
+
+	memcg = mem_cgroup_id_get_online(memcg);
+	if (nr_pages > 1)
+		mem_cgroup_id_get_many(memcg, nr_pages - 1);
+	swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
+}
+
+void __mem_cgroup_unrecord_swap(swp_entry_t entry, unsigned int nr_pages)
+{
+	unsigned short id = swap_cgroup_clear(entry, nr_pages);
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_id(id);
+	if (memcg)
+		mem_cgroup_id_put_many(memcg, nr_pages);
+	rcu_read_unlock();
+}
+
 /**
  * __mem_cgroup_try_charge_swap - try charging swap space for a folio
  * @folio: folio being added to swap
@@ -5038,34 +5078,47 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 	if (do_memsw_account())
 		return 0;
 
-	memcg = folio_memcg(folio);
+	if (IS_ENABLED(CONFIG_VIRTUAL_SWAP)) {
+		/*
+		 * In the virtual swap implementation, we already record the cgroup
+		 * on virtual swap allocation. Note that the virtual swap slot holds
+		 * a reference to memcg, so this lookup should be safe.
+		 */
+		rcu_read_lock();
+		memcg = mem_cgroup_from_id(lookup_swap_cgroup_id(entry));
+		rcu_read_unlock();
+	} else {
+		memcg = folio_memcg(folio);
 
-	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
-	if (!memcg)
-		return 0;
+		VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
+		if (!memcg)
+			return 0;
 
-	if (!entry.val) {
-		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
-		return 0;
-	}
+		if (!entry.val) {
+			memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
+			return 0;
+		}
 
-	memcg = mem_cgroup_id_get_online(memcg);
+		memcg = mem_cgroup_id_get_online(memcg);
+	}
 
 	if (!mem_cgroup_is_root(memcg) &&
 	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
-		mem_cgroup_id_put(memcg);
+		if (!IS_ENABLED(CONFIG_VIRTUAL_SWAP))
+			mem_cgroup_id_put(memcg);
 		return -ENOMEM;
 	}
 
-	/* Get references for the tail pages, too */
-	if (nr_pages > 1)
-		mem_cgroup_id_get_many(memcg, nr_pages - 1);
+	if (!IS_ENABLED(CONFIG_VIRTUAL_SWAP)) {
+		/* Get references for the tail pages, too */
+		if (nr_pages > 1)
+			mem_cgroup_id_get_many(memcg, nr_pages - 1);
+		swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
+	}
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
 
-	swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
-
 	return 0;
 }
 
@@ -5079,7 +5132,11 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	struct mem_cgroup *memcg;
 	unsigned short id;
 
-	id = swap_cgroup_clear(entry, nr_pages);
+	if (IS_ENABLED(CONFIG_VIRTUAL_SWAP))
+		id = lookup_swap_cgroup_id(entry);
+	else
+		id = swap_cgroup_clear(entry, nr_pages);
+
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(id);
 	if (memcg) {
@@ -5090,7 +5147,8 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 				page_counter_uncharge(&memcg->swap, nr_pages);
 		}
 		mod_memcg_state(memcg, MEMCG_SWAP, -nr_pages);
-		mem_cgroup_id_put_many(memcg, nr_pages);
+		if (!IS_ENABLED(CONFIG_VIRTUAL_SWAP))
+			mem_cgroup_id_put_many(memcg, nr_pages);
 	}
 	rcu_read_unlock();
 }
@@ -5099,7 +5157,7 @@ static bool mem_cgroup_may_zswap(struct mem_cgroup *original_memcg);
 
 long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
-	long nr_swap_pages, nr_zswap_pages = 0;
+	long nr_swap_pages;
 
 	/*
 	 * If swap is virtualized and zswap is enabled, we can still use zswap even
@@ -5108,10 +5166,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 	if (IS_ENABLED(CONFIG_VIRTUAL_SWAP) && zswap_is_enabled() &&
 			(mem_cgroup_disabled() || do_memsw_account() ||
 				mem_cgroup_may_zswap(memcg))) {
-		nr_zswap_pages = PAGE_COUNTER_MAX;
+		/*
+		 * No need to check swap cgroup limits, since zswap is not charged
+		 * towards swap consumption.
+		 */
+		return PAGE_COUNTER_MAX;
 	}
 
-	nr_swap_pages = max_t(long, nr_zswap_pages, get_nr_swap_pages());
+	nr_swap_pages = get_nr_swap_pages();
 	if (mem_cgroup_disabled() || do_memsw_account())
 		return nr_swap_pages;
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
diff --git a/mm/vswap.c b/mm/vswap.c
index a42d346b7e93..c51ff5c54480 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -341,6 +341,7 @@ static inline void release_backing(swp_entry_t entry, int nr)
 			swap_slot_free_nr(slot, nr);
 			swap_slot_put_swap_info(si);
 		}
+		mem_cgroup_uncharge_swap(entry, nr);
 	}
 }
 
@@ -360,7 +361,7 @@ static void vswap_free(swp_entry_t entry)
 
 	virt_clear_shadow_from_swap_cache(entry);
 	release_backing(entry, 1);
-	mem_cgroup_uncharge_swap(entry, 1);
+	mem_cgroup_unrecord_swap(entry, 1);
 	/* erase forward mapping and release the virtual slot for reallocation */
 	release_vswap_slot(entry.val);
 	kfree_rcu(desc, rcu);
@@ -378,27 +379,13 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 {
 	swp_entry_t entry;
 	struct swp_desc *desc;
-	int i, nr = folio_nr_pages(folio);
+	int nr = folio_nr_pages(folio);
 
 	entry = vswap_alloc(nr);
 	if (!entry.val)
 		return entry;
 
-	/*
-	 * XXX: for now, we charge towards the memory cgroup's swap limit on virtual
-	 * swap slots allocation. This will be changed soon - we will only charge on
-	 * physical swap slots allocation.
-	 */
-	if (mem_cgroup_try_charge_swap(folio, entry)) {
-		for (i = 0; i < nr; i++) {
-			vswap_free(entry);
-			entry.val++;
-		}
-		atomic_add(nr, &vswap_alloc_reject);
-		entry.val = 0;
-		return entry;
-	}
-
+	mem_cgroup_record_swap(folio, entry);
 	XA_STATE(xas, &vswap_map, entry.val);
 
 	rcu_read_lock();
@@ -440,6 +427,9 @@ swp_slot_t vswap_alloc_swap_slot(struct folio *folio)
 	if (!slot.val)
 		return slot;
 
+	if (mem_cgroup_try_charge_swap(folio, entry))
+		goto free_phys_swap;
+
 	/* establish the vrtual <-> physical swap slots linkages. */
 	for (i = 0; i < nr; i++) {
 		err = xa_insert(&vswap_rmap, slot.val + i,
@@ -448,13 +438,7 @@ swp_slot_t vswap_alloc_swap_slot(struct folio *folio)
 		if (err) {
 			while (--i >= 0)
 				xa_erase(&vswap_rmap, slot.val + i);
-			/*
-			 * We have not updated the backing type of the virtual swap slot.
-			 * Simply free up the physical swap slots here!
-			 */
-			swap_slot_free_nr(slot, nr);
-			slot.val = 0;
-			return slot;
+			goto uncharge;
 		}
 	}
 
@@ -491,6 +475,17 @@ swp_slot_t vswap_alloc_swap_slot(struct folio *folio)
 	}
 	rcu_read_unlock();
 	return slot;
+
+uncharge:
+	mem_cgroup_uncharge_swap(entry, nr);
+free_phys_swap:
+	/*
+	 * We have not updated the backing type of the virtual swap slot.
+	 * Simply free up the physical swap slots here!
+	 */
+	swap_slot_free_nr(slot, nr);
+	slot.val = 0;
+	return slot;
 }
 
 /**
-- 
2.47.1


