Return-Path: <cgroups+bounces-7921-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ADBAA3C97
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505631B66B3B
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1512E3379;
	Tue, 29 Apr 2025 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGVkBgQi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1BB2DFA28;
	Tue, 29 Apr 2025 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969941; cv=none; b=TjkBrP3Nqs0Ta1+LxXcfZhOY8PfDLUwxo8WRy0ngSJLdeyC2tEvjzvOpYLXEC0R8bgovjVYiuphZarZBeDYKSRY0PxN2X92YaTnqPMy3BK1wy8nvVszyyVJZ0y8huZ30Pm5DgrIa3drsODhLJ9v4oyIZccZk5trczlyIFb/hIug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969941; c=relaxed/simple;
	bh=N17zPWxBpUKFHgnUl5+5s6tRTrKYek0rO0KMwYvFWeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeXqZs481Ap422Z8rn+bT39GpeU91rb4rirRlBWflefcfBCloe+tbPEO7KIFvt0AJlXybtE4SdVF0ha218haaqRHMBtSZM7G3icFxyk5racqQK855Ns9IoOR2Ar7dx75NJLfD/3nQECZE3MhGao0/NLG1L1HcT981+ioSie3/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGVkBgQi; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7086dcab64bso31956427b3.1;
        Tue, 29 Apr 2025 16:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969937; x=1746574737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9RcEtV41DAfc6eUkH4NGp4ZSyS4pPlCziLaor8iU+o=;
        b=HGVkBgQi8oS+OLtA5DlQ/E/FWdWJ94y85OHo0DywzCWoXtVjqqx3TqMEdPZQg0zPK8
         hgeKMYaD+ONl3KTM/dneOybjl9uAhlZYiejvtMYgtPUDXC2JJJ0TbZEhkCecugK1kWca
         BH7oxfhfjMQ+2C5d4oDdt7sPhO2Q6mERsqR5hrwEFd8uqmdv49q0/PEDNNaMQkz9RVXU
         jzvVWX259Uv/2YVEPzb4KiU87tV+C4obh8RCIo2RjeZB1BvD7Wtlg20chV4zGjzHWeHA
         BlcmVZQ/deOvAd8cD5Rsie7Y/KqDjE3lVM5LUjlr/ZqJYBX/gP3g9jZz4/9mFzYWUfG0
         pglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969937; x=1746574737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9RcEtV41DAfc6eUkH4NGp4ZSyS4pPlCziLaor8iU+o=;
        b=nka6Vh6j0v+NFR/M+GEKvi+uCGtxfp4+lwOFeT34OqK9oQol6P5M6dNHSbQqVxCwBn
         ZxrG9duDH5pizM2GfM34Tbd0ACWPq28AdjqVRWBGt3tSKiFeWyTuTuG/lCcX9pVnofuQ
         K287Vbb/9HXzI220UOQgGEbPevR9H+QUB3Sgtf8bm0Z9hkDwKNuOQ2Sfc+PKDJB+yZke
         mHtJOJj5QlaeP6a0Iu+DA75xLwJnenj0N+ias2aoryv02h46OYf3NLeLQrVQhtgipeNV
         8Ab8GEQn5FLupMZz05lchXV+SE3h0GE7mtAruVVji0GA9xC8GaQyeKQ2YOn0oxJijQW8
         ZsHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtvLPR1jrwVEk3/nKzYntshBjZNdF6tAKbjYYxVXpAF6JQ80yr1QpuEbfB7kiL1mGxC8Gf8OhyHy4=@vger.kernel.org, AJvYcCW2OW03kBFc5WMcZqjqgNMdbBxBDEdHe5IlLluipri9RHb5vYTKfqRYcESN02972jiGa9fBlCUb@vger.kernel.org, AJvYcCWzwFQP2NRcjAIa/5pnddK72CTjFcbaz/Jk+BNeg317+pmvDw8Gwt0NX2cBHabraLYTV5kpmU6tuPOwPGPU@vger.kernel.org
X-Gm-Message-State: AOJu0YyoZayl1h8wif1l7YTUDIypmjyPefrfgdK+8qNlYpm0ShriNSIL
	rb77VQQjyZn/ZsI3KTG2Ga6+O+/be4u+hTC7pTgGRi9JnextDj2U
X-Gm-Gg: ASbGncu5EVDtTHih5qCbxovBpS68P3XcIhvuQtInPMC8ZFM0Qpdw0CNy6Bdx+AUsthE
	lwEMGFXzTESyeKNTiYEUm/zEe/gkeyr5tch63jP61ijkpff27RfC06dtrn85Qd+zwcutIBse2KE
	ypSjZxFIPNHF23yujLLr2D3W1/1kJ6qU9LGiv3yR+Jh+8YCdj1/11WWhDjp81E8i+XAVGvBSooL
	U27trwMcq49xiGcabFbRPHq4u3ZCEBY9M2Xy9nPi/QId+oDtzo6uTRo4qPAstMjvZlhwP+jp6o8
	4s6c8KYnW2zmPe2IAQco+bT1UUb6uWmoujDW45EycA==
X-Google-Smtp-Source: AGHT+IEb1Ey1Nq8Ab4XTF5BmPCiPuZk0L2rm7yz3tl5C2edecMV7a5dw3WhNKFiVpWUW5HnWyR+qPw==
X-Received: by 2002:a05:690c:c93:b0:703:c3ed:1f61 with SMTP id 00721157ae682-708abdabe08mr21680937b3.20.1745969937413;
        Tue, 29 Apr 2025 16:38:57 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708ae0695f4sm755667b3.61.2025.04.29.16.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:38:56 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/18] mm: swap: allocate a virtual swap slot for each swapped out page
Date: Tue, 29 Apr 2025 16:38:36 -0700
Message-ID: <20250429233848.3093350-9-nphamcs@gmail.com>
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

For the new virtual swap space design, dynamically allocate a virtual
slot (as well as an associated metadata structure) for each swapped out
page, and associate it to the (physical) swap slot on the swapfile/swap
partition.

For now, there is always a physical slot in the swapfile associated for
each virtual swap slot (except those about to be freed). The virtual
swap slot's lifetime is still tied to the lifetime of its physical swap
slot.

We also maintain a backward map to look up the virtual swap slot from
its associated physical swap slot on swapfile. This is used in cluster
readahead, as well as several swapfile operations, such as the swap slot
reclamation that happens when the swapfile is almost full.  It will also
be used in a future patch that simplifies swapoff.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h    |  17 +-
 include/linux/swapops.h |  12 ++
 mm/internal.h           |  43 ++++-
 mm/shmem.c              |  10 +-
 mm/swap.h               |   2 +
 mm/swap_state.c         |  29 +++-
 mm/swapfile.c           |  24 ++-
 mm/vswap.c              | 342 +++++++++++++++++++++++++++++++++++++++-
 8 files changed, 457 insertions(+), 22 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 328f6aec9313..0f1337431e27 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -456,7 +456,6 @@ extern void __meminit kswapd_stop(int nid);
 /* Lifetime swap API (mm/swapfile.c) */
 swp_entry_t folio_alloc_swap(struct folio *folio);
 bool folio_free_swap(struct folio *folio);
-void put_swap_folio(struct folio *folio, swp_entry_t entry);
 void swap_shmem_alloc(swp_entry_t, int);
 int swap_duplicate(swp_entry_t);
 int swapcache_prepare(swp_entry_t entry, int nr);
@@ -504,6 +503,7 @@ static inline long get_nr_swap_pages(void)
 }
 
 void si_swapinfo(struct sysinfo *);
+void swap_slot_put_folio(swp_slot_t slot, struct folio *folio);
 swp_slot_t swap_slot_alloc_of_type(int);
 int swap_slot_alloc(int n, swp_slot_t swp_slots[], int order);
 void swap_slot_free_nr(swp_slot_t slot, int nr_pages);
@@ -728,12 +728,19 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 
 #ifdef CONFIG_VIRTUAL_SWAP
 int vswap_init(void);
+void vswap_exit(void);
+void vswap_free(swp_entry_t entry);
+swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry);
+swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot);
 #else /* CONFIG_VIRTUAL_SWAP */
 static inline int vswap_init(void)
 {
 	return 0;
 }
-#endif /* CONFIG_VIRTUAL_SWAP */
+
+static inline void vswap_exit(void)
+{
+}
 
 /**
  * swp_entry_to_swp_slot - look up the physical swap slot corresponding to a
@@ -758,6 +765,12 @@ static inline swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
 {
 	return (swp_entry_t) { slot.val };
 }
+#endif /* CONFIG_VIRTUAL_SWAP */
+
+static inline void put_swap_folio(struct folio *folio, swp_entry_t entry)
+{
+	swap_slot_put_folio(swp_entry_to_swp_slot(entry), folio);
+}
 
 static inline bool trylock_swapoff(swp_entry_t entry,
 				struct swap_info_struct **si)
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 2a4101c9bba4..ba7364e1400a 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -27,6 +27,18 @@
 #define SWP_TYPE_SHIFT	(BITS_PER_XA_VALUE - MAX_SWAPFILES_SHIFT)
 #define SWP_OFFSET_MASK	((1UL << SWP_TYPE_SHIFT) - 1)
 
+#ifdef CONFIG_VIRTUAL_SWAP
+#if SWP_TYPE_SHIFT > 32
+#define MAX_VSWAP	U32_MAX
+#else
+/*
+ * The range of virtual swap slots is the same as the range of physical swap
+ * slots.
+ */
+#define MAX_VSWAP	(((MAX_SWAPFILES - 1) << SWP_TYPE_SHIFT) | SWP_OFFSET_MASK)
+#endif
+#endif
+
 /*
  * Definitions only for PFN swap entries (see is_pfn_swap_entry()).  To
  * store PFN, we only need SWP_PFN_BITS bits.  Each of the pfn swap entries
diff --git a/mm/internal.h b/mm/internal.h
index 2d63f6537e35..ca28729f822a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -262,6 +262,40 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 	return min(ptep - start_ptep, max_nr);
 }
 
+#ifdef CONFIG_VIRTUAL_SWAP
+static inline swp_entry_t swap_nth(swp_entry_t entry, long n)
+{
+	return (swp_entry_t) { entry.val + n };
+}
+
+/* similar to swap_nth, but check the backing physical slots as well. */
+static inline swp_entry_t swap_move(swp_entry_t entry, long delta)
+{
+	swp_slot_t slot = swp_entry_to_swp_slot(entry), next_slot;
+	swp_entry_t next_entry = swap_nth(entry, delta);
+
+	next_slot = swp_entry_to_swp_slot(next_entry);
+	if (swp_slot_type(slot) != swp_slot_type(next_slot) ||
+			swp_slot_offset(slot) + delta != swp_slot_offset(next_slot))
+		next_entry.val = 0;
+
+	return next_entry;
+}
+#else
+static inline swp_entry_t swap_nth(swp_entry_t entry, long n)
+{
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+
+	return swp_slot_to_swp_entry(swp_slot(swp_slot_type(slot),
+			swp_slot_offset(slot) + n));
+}
+
+static inline swp_entry_t swap_move(swp_entry_t entry, long delta)
+{
+	return swap_nth(entry, delta);
+}
+#endif
+
 /**
  * pte_move_swp_offset - Move the swap entry offset field of a swap pte
  *	 forward or backward by delta
@@ -275,13 +309,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
  */
 static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 {
-	swp_entry_t entry = pte_to_swp_entry(pte), new_entry;
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	pte_t new;
-
-	new_entry = swp_slot_to_swp_entry(swp_slot(swp_slot_type(slot),
-			swp_slot_offset(slot) + delta));
-	new = swp_entry_to_pte(new_entry);
+	swp_entry_t entry = pte_to_swp_entry(pte);
+	pte_t new = swp_entry_to_pte(swap_move(entry, delta));
 
 	if (pte_swp_soft_dirty(pte))
 		new = pte_swp_mksoft_dirty(new);
diff --git a/mm/shmem.c b/mm/shmem.c
index f8efa49eb499..4c00b4673468 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2166,7 +2166,6 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
 	void *alloced_shadow = NULL;
 	int alloced_order = 0, i;
-	swp_slot_t slot = swp_entry_to_swp_slot(swap);
 
 	/* Convert user data gfp flags to xarray node gfp flags */
 	gfp &= GFP_RECLAIM_MASK;
@@ -2205,12 +2204,8 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 			 */
 			for (i = 0; i < 1 << order; i++) {
 				pgoff_t aligned_index = round_down(index, 1 << order);
-				swp_entry_t tmp_entry;
-				swp_slot_t tmp_slot;
+				swp_entry_t tmp_entry = swap_nth(swap, i);
 
-				tmp_slot =
-					swp_slot(swp_slot_type(slot), swp_slot_offset(slot) + i);
-				tmp_entry = swp_slot_to_swp_entry(tmp_slot);
 				__xa_store(&mapping->i_pages, aligned_index + i,
 					   swp_to_radix_entry(tmp_entry), 0);
 			}
@@ -2336,8 +2331,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		if (split_order > 0) {
 			pgoff_t offset = index - round_down(index, 1 << split_order);
 
-			swap = swp_slot_to_swp_entry(swp_slot(
-					swp_slot_type(slot), swp_slot_offset(slot) + offset));
+			swap = swap_nth(swap, offset);
 		}
 
 		/* Here we actually start the io */
diff --git a/mm/swap.h b/mm/swap.h
index 06e20b1d79c4..31c94671cb44 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -36,6 +36,8 @@ static inline loff_t swap_slot_pos(swp_slot_t slot)
 #ifdef CONFIG_VIRTUAL_SWAP
 extern struct address_space *swap_address_space(swp_entry_t entry);
 #define swap_cache_index(entry) entry.val
+
+void virt_clear_shadow_from_swap_cache(swp_entry_t entry);
 #else
 /* One swap address space for each 64M swap space */
 extern struct address_space *swapper_spaces[];
diff --git a/mm/swap_state.c b/mm/swap_state.c
index f677ebf9c5d0..16abdb5ce07a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -177,6 +177,7 @@ void __delete_from_swap_cache(struct folio *folio,
 	__lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr);
 }
 
+#ifndef CONFIG_VIRTUAL_SWAP
 swp_entry_t folio_alloc_swap(struct folio *folio)
 {
 	swp_slot_t slot = folio_alloc_swap_slot(folio);
@@ -189,6 +190,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 
 	return entry;
 }
+#endif
 
 /**
  * add_to_swap - allocate swap space for a folio
@@ -270,6 +272,27 @@ void delete_from_swap_cache(struct folio *folio)
 	folio_ref_sub(folio, folio_nr_pages(folio));
 }
 
+#ifdef CONFIG_VIRTUAL_SWAP
+/*
+ * In the virtual swap implementation, we index the swap cache by virtual swap
+ * slots rather than physical ones. As a result, we only clear the shadow when
+ * the virtual swap slot is freed (via virt_clear_shadow_from_swap_cache()),
+ * not when the physical swap slot is freed (via clear_shadow_from_swap_cache()
+ * in the old implementation).
+ */
+void virt_clear_shadow_from_swap_cache(swp_entry_t entry)
+{
+	struct address_space *address_space = swap_address_space(entry);
+	pgoff_t index = swap_cache_index(entry);
+	XA_STATE(xas, &address_space->i_pages, index);
+
+	xas_set_update(&xas, workingset_update_node);
+	xa_lock_irq(&address_space->i_pages);
+	if (xa_is_value(xas_load(&xas)))
+		xas_store(&xas, NULL);
+	xa_unlock_irq(&address_space->i_pages);
+}
+#else
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				unsigned long end)
 {
@@ -300,6 +323,7 @@ void clear_shadow_from_swap_cache(int type, unsigned long begin,
 			break;
 	}
 }
+#endif
 
 /*
  * If we are the only user, then try to free up the swap cache.
@@ -965,7 +989,8 @@ static int __init swap_init_sysfs(void)
 	swap_kobj = kobject_create_and_add("swap", mm_kobj);
 	if (!swap_kobj) {
 		pr_err("failed to create swap kobject\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto vswap_exit;
 	}
 	err = sysfs_create_group(swap_kobj, &swap_attr_group);
 	if (err) {
@@ -976,6 +1001,8 @@ static int __init swap_init_sysfs(void)
 
 delete_obj:
 	kobject_put(swap_kobj);
+vswap_exit:
+	vswap_exit();
 	return err;
 }
 subsys_initcall(swap_init_sysfs);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 17cbf14bac72..849525810bbe 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1126,12 +1126,18 @@ static void swap_range_alloc(struct swap_info_struct *si,
 static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			    unsigned int nr_entries)
 {
-	unsigned long begin = offset;
 	unsigned long end = offset + nr_entries - 1;
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
 	unsigned int i;
+#ifndef CONFIG_VIRTUAL_SWAP
+	unsigned long begin = offset;
 
+	/*
+	 * In the virtual swap design, the swap cache is indexed by virtual swap
+	 * slots. We will clear the shadow when the virtual swap slots are freed.
+	 */
 	clear_shadow_from_swap_cache(si->type, begin, end);
+#endif
 
 	/*
 	 * Use atomic clear_bit operations only on zeromap instead of non-atomic
@@ -1506,8 +1512,21 @@ static void swap_slot_range_free(struct swap_info_struct *si,
 	unsigned char *map = si->swap_map + offset;
 	unsigned char *map_end = map + nr_pages;
 	swp_entry_t entry = swp_slot_to_swp_entry(slot);
+#ifdef CONFIG_VIRTUAL_SWAP
+	int i;
 
+	/* release all the associated (virtual) swap slots */
+	for (i = 0; i < nr_pages; i++) {
+		vswap_free(entry);
+		entry.val++;
+	}
+#else
+	/*
+	 * In the new (i.e virtual swap) implementation, we will let the virtual
+	 * swap layer handle the cgroup swap accounting and charging.
+	 */
 	mem_cgroup_uncharge_swap(entry, nr_pages);
+#endif
 
 	/* It should never free entries across different clusters */
 	VM_BUG_ON(ci != offset_to_cluster(si, offset + nr_pages - 1));
@@ -1573,9 +1592,8 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
 /*
  * Called after dropping swapcache to decrease refcnt to swap entries.
  */
-void put_swap_folio(struct folio *folio, swp_entry_t entry)
+void swap_slot_put_folio(swp_slot_t slot, struct folio *folio)
 {
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
 	unsigned long offset = swp_slot_offset(slot);
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
diff --git a/mm/vswap.c b/mm/vswap.c
index b9c28e819cca..23a05c3393d8 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -4,7 +4,75 @@
  *
  * Copyright (C) 2024 Meta Platforms, Inc., Nhat Pham
  */
- #include <linux/swap.h>
+#include <linux/mm.h>
+#include <linux/gfp.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/swap_cgroup.h>
+#include "swap.h"
+
+/*
+ * Virtual Swap Space
+ *
+ * We associate with each swapped out page a virtual swap slot. This will allow
+ * us to change the backing state of a swapped out page without having to
+ * update every single page table entries referring to it.
+ *
+ * For now, there is a one-to-one correspondence between a virtual swap slot
+ * and its associated physical swap slot.
+ */
+
+/**
+ * Swap descriptor - metadata of a swapped out page.
+ *
+ * @slot: The handle to the physical swap slot backing this page.
+ * @rcu: The RCU head to free the descriptor with an RCU grace period.
+ */
+struct swp_desc {
+	swp_slot_t slot;
+	struct rcu_head rcu;
+};
+
+/* Virtual swap space - swp_entry_t -> struct swp_desc */
+static DEFINE_XARRAY_FLAGS(vswap_map, XA_FLAGS_TRACK_FREE);
+
+static const struct xa_limit vswap_map_limit = {
+	.max = MAX_VSWAP,
+	/* reserve the 0 virtual swap slot to indicate errors */
+	.min = 1,
+};
+
+/* Physical (swp_slot_t) to virtual (swp_entry_t) swap slots. */
+static DEFINE_XARRAY(vswap_rmap);
+
+/*
+ * For swapping large folio of size n, we reserve an empty PMD-sized cluster
+ * of contiguous and aligned virtual swap slots, then allocate the first n
+ * virtual swap slots from the cluster.
+ */
+#define VSWAP_CLUSTER_SHIFT HPAGE_PMD_ORDER
+#define VSWAP_CLUSTER_SIZE (1UL << VSWAP_CLUSTER_SHIFT)
+
+/*
+ * Map from a cluster id to the number of allocated virtual swap slots in the
+ * (PMD-sized) cluster. This allows us to quickly allocate an empty cluster
+ * for a large folio being swapped out.
+ */
+static DEFINE_XARRAY_FLAGS(vswap_cluster_map, XA_FLAGS_TRACK_FREE);
+
+static const struct xa_limit vswap_cluster_map_limit = {
+	/* Do not allocate from the last cluster if it does not have enough slots. */
+	.max = (((MAX_VSWAP + 1) >> (VSWAP_CLUSTER_SHIFT)) - 1),
+	/*
+	 * First cluster is never handed out for large folios, since the 0 virtual
+	 * swap slot is reserved for errors.
+	 */
+	.min = 1,
+};
+
+static struct kmem_cache *swp_desc_cache;
+static atomic_t vswap_alloc_reject;
+static atomic_t vswap_used;
 
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
@@ -17,6 +85,10 @@ static int vswap_debug_fs_init(void)
 		return -ENODEV;
 
 	vswap_debugfs_root = debugfs_create_dir("vswap", NULL);
+	debugfs_create_atomic_t("alloc_reject", 0444,
+		vswap_debugfs_root, &vswap_alloc_reject);
+	debugfs_create_atomic_t("used", 0444, vswap_debugfs_root, &vswap_used);
+
 	return 0;
 }
 #else
@@ -26,10 +98,278 @@ static int vswap_debug_fs_init(void)
 }
 #endif
 
+/* Allolcate a contiguous range of virtual swap slots */
+static swp_entry_t vswap_alloc(int nr)
+{
+	struct swp_desc **descs;
+	swp_entry_t entry;
+	u32 index, cluster_id;
+	void *cluster_entry;
+	unsigned long cluster_count;
+	int i, err;
+
+	entry.val = 0;
+	descs = kcalloc(nr, sizeof(*descs), GFP_KERNEL);
+	if (!descs) {
+		atomic_add(nr, &vswap_alloc_reject);
+		return (swp_entry_t){0};
+	}
+
+	if (unlikely(!kmem_cache_alloc_bulk(
+					swp_desc_cache, GFP_KERNEL, nr, (void **)descs))) {
+		atomic_add(nr, &vswap_alloc_reject);
+		kfree(descs);
+		return (swp_entry_t){0};
+	}
+
+	for (i = 0; i < nr; i++)
+		descs[i]->slot.val = 0;
+
+	xa_lock(&vswap_map);
+	if (nr == 1) {
+		if (__xa_alloc(&vswap_map, &index, descs[0], vswap_map_limit,
+				GFP_KERNEL))
+			goto unlock;
+		else {
+			/*
+			 * Increment the allocation count of the cluster which the
+			 * allocated virtual swap slot belongs to.
+			 */
+			cluster_id = index >> VSWAP_CLUSTER_SHIFT;
+			cluster_entry = xa_load(&vswap_cluster_map, cluster_id);
+			cluster_count = cluster_entry ? xa_to_value(cluster_entry) : 0;
+			cluster_count++;
+			VM_WARN_ON(cluster_count > VSWAP_CLUSTER_SIZE);
+
+			if (xa_err(xa_store(&vswap_cluster_map, cluster_id,
+					xa_mk_value(cluster_count), GFP_KERNEL))) {
+				__xa_erase(&vswap_map, index);
+				goto unlock;
+			}
+		}
+	} else {
+		/* allocate an unused cluster */
+		cluster_entry = xa_mk_value(nr);
+		if (xa_alloc(&vswap_cluster_map, &cluster_id, cluster_entry,
+				vswap_cluster_map_limit, GFP_KERNEL))
+			goto unlock;
+
+		index = cluster_id << VSWAP_CLUSTER_SHIFT;
+
+		for (i = 0; i < nr; i++) {
+			err = __xa_insert(&vswap_map, index + i, descs[i], GFP_KERNEL);
+			VM_WARN_ON(err == -EBUSY);
+			if (err) {
+				while (--i >= 0)
+					__xa_erase(&vswap_map, index + i);
+				xa_erase(&vswap_cluster_map, cluster_id);
+				goto unlock;
+			}
+		}
+	}
+
+	VM_WARN_ON(!index);
+	VM_WARN_ON(index + nr - 1 > MAX_VSWAP);
+	entry.val = index;
+	atomic_add(nr, &vswap_used);
+unlock:
+	xa_unlock(&vswap_map);
+	if (!entry.val) {
+		atomic_add(nr, &vswap_alloc_reject);
+		kmem_cache_free_bulk(swp_desc_cache, nr, (void **)descs);
+	}
+	kfree(descs);
+	return entry;
+}
+
+static inline void release_vswap_slot(unsigned long index)
+{
+	unsigned long cluster_id = index >> VSWAP_CLUSTER_SHIFT, cluster_count;
+	void *cluster_entry;
+
+	xa_lock(&vswap_map);
+	__xa_erase(&vswap_map, index);
+	cluster_entry = xa_load(&vswap_cluster_map, cluster_id);
+	VM_WARN_ON(!cluster_entry);
+	cluster_count = xa_to_value(cluster_entry);
+	cluster_count--;
+
+	VM_WARN_ON(cluster_count < 0);
+
+	if (cluster_count)
+		xa_store(&vswap_cluster_map, cluster_id,
+			xa_mk_value(cluster_count), GFP_KERNEL);
+	else
+		xa_erase(&vswap_cluster_map, cluster_id);
+	xa_unlock(&vswap_map);
+	atomic_dec(&vswap_used);
+}
+
+/**
+ * vswap_free - free a virtual swap slot.
+ * @id: the virtual swap slot to free
+ */
+void vswap_free(swp_entry_t entry)
+{
+	struct swp_desc *desc;
+
+	if (!entry.val)
+		return;
+
+	/* do not immediately erase the virtual slot to prevent its reuse */
+	desc = xa_load(&vswap_map, entry.val);
+	if (!desc)
+		return;
+
+	virt_clear_shadow_from_swap_cache(entry);
+
+	if (desc->slot.val) {
+		/* we only charge after linkage was established */
+		mem_cgroup_uncharge_swap(entry, 1);
+		xa_erase(&vswap_rmap, desc->slot.val);
+	}
+
+	/* erase forward mapping and release the virtual slot for reallocation */
+	release_vswap_slot(entry.val);
+	kfree_rcu(desc, rcu);
+}
+
+/**
+ * folio_alloc_swap - allocate virtual swap slots for a folio.
+ * @folio: the folio.
+ *
+ * Return: the first allocated slot if success, or the zero virtuals swap slot
+ * on failure.
+ */
+swp_entry_t folio_alloc_swap(struct folio *folio)
+{
+	int i, err, nr = folio_nr_pages(folio);
+	bool manual_freeing = true;
+	struct swp_desc *desc;
+	swp_entry_t entry;
+	swp_slot_t slot;
+
+	entry = vswap_alloc(nr);
+	if (!entry.val)
+		return entry;
+
+	/*
+	 * XXX: for now, we always allocate a physical swap slot for each virtual
+	 * swap slot, and their lifetime are coupled. This will change once we
+	 * decouple virtual swap slots from their backing states, and only allocate
+	 * physical swap slots for them on demand (i.e on zswap writeback, or
+	 * fallback from zswap store failure).
+	 */
+	slot = folio_alloc_swap_slot(folio);
+	if (!slot.val)
+		goto vswap_free;
+
+	/* establish the vrtual <-> physical swap slots linkages. */
+	for (i = 0; i < nr; i++) {
+		err = xa_insert(&vswap_rmap, slot.val + i,
+				xa_mk_value(entry.val + i), GFP_KERNEL);
+		VM_WARN_ON(err == -EBUSY);
+		if (err) {
+			while (--i >= 0)
+				xa_erase(&vswap_rmap, slot.val + i);
+			goto put_physical_swap;
+		}
+	}
+
+	i = 0;
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		desc->slot.val = slot.val + i;
+		i++;
+	}
+	rcu_read_unlock();
+
+	manual_freeing = false;
+	/*
+	 * XXX: for now, we charge towards the memory cgroup's swap limit on virtual
+	 * swap slots allocation. This is acceptable because as noted above, each
+	 * virtual swap slot corresponds to a physical swap slot. Once we have
+	 * decoupled virtual and physical swap slots, we will only charge when we
+	 * actually allocate a physical swap slot.
+	 */
+	if (!mem_cgroup_try_charge_swap(folio, entry))
+		return entry;
+
+put_physical_swap:
+	/*
+	 * There is no any linkage between virtual and physical swap slots yet. We
+	 * have to manually and separately free the allocated virtual and physical
+	 * swap slots.
+	 */
+	swap_slot_put_folio(slot, folio);
+vswap_free:
+	if (manual_freeing) {
+		for (i = 0; i < nr; i++)
+			vswap_free((swp_entry_t){entry.val + i});
+	}
+	entry.val = 0;
+	return entry;
+}
+
+/**
+ * swp_entry_to_swp_slot - look up the physical swap slot corresponding to a
+ *                         virtual swap slot.
+ * @entry: the virtual swap slot.
+ *
+ * Return: the physical swap slot corresponding to the virtual swap slot.
+ */
+swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
+{
+	struct swp_desc *desc;
+
+	if (!entry.val)
+		return (swp_slot_t){0};
+
+	desc = xa_load(&vswap_map, entry.val);
+	return desc ? desc->slot : (swp_slot_t){0};
+}
+
+/**
+ * swp_slot_to_swp_entry - look up the virtual swap slot corresponding to a
+ *                         physical swap slot.
+ * @slot: the physical swap slot.
+ *
+ * Return: the virtual swap slot corresponding to the physical swap slot.
+ */
+swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
+{
+	void *entry = xa_load(&vswap_rmap, slot.val);
+
+	/*
+	 * entry can be NULL if we fail to link the virtual and physical swap slot
+	 * during the swap slot allocation process.
+	 */
+	return entry ? (swp_entry_t){xa_to_value(entry)} : (swp_entry_t){0};
+}
+
 int vswap_init(void)
 {
+	swp_desc_cache = KMEM_CACHE(swp_desc, 0);
+	if (!swp_desc_cache)
+		return -ENOMEM;
+
+	if (xa_insert(&vswap_cluster_map, 0, xa_mk_value(1), GFP_KERNEL)) {
+		kmem_cache_destroy(swp_desc_cache);
+		return -ENOMEM;
+	}
+
 	if (vswap_debug_fs_init())
 		pr_warn("Failed to initialize vswap debugfs\n");
 
 	return 0;
 }
+
+void vswap_exit(void)
+{
+	kmem_cache_destroy(swp_desc_cache);
+}
-- 
2.47.1


