Return-Path: <cgroups+bounces-7923-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CB1AA3CAC
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFDA1B66F0C
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77296270543;
	Tue, 29 Apr 2025 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf7BqvpR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8E2DFA52;
	Tue, 29 Apr 2025 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969943; cv=none; b=S7bIHTisJ/KG/VX05LTv4JQ549ncYP5TYINkF9qU1O+Ql+D4r9nfJYMptkQdRAPF7jVBsuRP1JKtcH7tXInG4SUdGHtoB4UEVQTsl3yutpLKe/sF6wNeWpDOug5S16swG503u2AYdLbLeVIeVVXtl4c0RDRrDWl8C1c6CsOg4co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969943; c=relaxed/simple;
	bh=LgSSKcvtWhAwwMo7zfBcbVUMCWodnoh/8zd5F+o6Inw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjR669i4YDIiuF1Fbj6VOljQ80u8clofktVn3RZZ8foGHpabz92LNqCaYs+iPTWOI+uPzqdMSHJ89dFE8rRJVRa9b+9LFZxzGxhuBAEAeTfHhLgD5LRVNwmCHp2r23+8X4iLrTDIj0ArzqUd2kQF/dxa3rVbIyAetH3PnKIx7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf7BqvpR; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ff27ad48beso58158047b3.0;
        Tue, 29 Apr 2025 16:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969939; x=1746574739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qt9MdATHI4093PTxGb0CivsGVYmaPcz42OJvHHv98GY=;
        b=Sf7BqvpR4Dal2DYsqx3IISjXZ2CkzMvK4SNcFfE5Sm9oqbwCneI+d6tzSDY2UfFAlM
         J5SRT7BXnHrq4rd2mDUIwFIzck2OUG9FyNOhuZ4rUqJDxEhCeRSvzK7D/uUz4mHI/hEH
         cS6jGWwj5SEWCZvDqdpH07qPk+u6HkfcYfqBkqGP7eq4BTuntMspCLF42ISGT/FtVkbU
         yGk/NvbxmLiEehha13bCxSfigT+xJUiV9Eb1kuOT3j0sbcQoqLnYiSdFZvQZ84w/3tgj
         LUV2NuJh2fEQ+RX7e/OfQd57l02aZ092tZnykE0vqEDgb1U/KiDTe9uzYzxkyV7Y7uzZ
         pmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969939; x=1746574739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qt9MdATHI4093PTxGb0CivsGVYmaPcz42OJvHHv98GY=;
        b=xJ71BK1AXBGt+r+iUxX/T3/iRCxO3738g2bdecWPOAbarUrfh20mv/PDUNScF3Kvvl
         vSKz0rLm52AdeOQu8PDIM7GdAWiZ3IlI9HndLqhMRKUnLAzqAkwApnP1eIviA+fV7ub/
         XWrZZnquCZdxeEp9k2zKXqx1NWwP44ByxYKMmauJ1YcyQLyksSQTVHsrStmQEWtAJa4j
         NhR4jwuuQVct26ff3/eWjgsxNEaWj/ruYTU6wYgBxySyR3pbScxd/0i/u8dxqYyvd0cV
         FUZrMpDUnWTbLQ7eq49D0ONrSb3t4LsqJgmFMHmvFhzx4drjLV+QzmevkgQbJ9PLV/S9
         ug+w==
X-Forwarded-Encrypted: i=1; AJvYcCU9Ny/ZT/wOw/L1Bg0yEv+bk5vKE962d7fc9ylmzhvdNKu3KahSEo6IHoLRS0/0SIb5Xvxit0rapWdKMKdd@vger.kernel.org, AJvYcCUEnpZOIJ2eVzAO2n/ippUMUTXHvAnlQlx9T3SmQhPBvzF0zH1dHNgx1Jiw2s38CB/dJ29zle1E@vger.kernel.org, AJvYcCWzAG3vNGwkJnGmtE5AVY1Jd9ynYDot97Ae5WG7VG//WvSE7xzuIQx8zgBRjE/oH8ZQALox29DLnUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQfLD/zbWJR/Ng4U+F72vURCga/mqmetShThOVvXvkHug1O4e
	+8KSUcE9Raa8GbYDVD05ipN8a55a5kf3MEfqmVb2ekkxTKEWJKtv
X-Gm-Gg: ASbGncuF/Y4mTvk3bb/ISgkRUYW9gwb4uRmtbU4mpW0K9qhUjs4hK2RsXNTfZE2HaU5
	ZYJMT5NnMEGiT2a5QTY1rcXFUQmODm9ZtwDYn3cLAns49gT7tqYBDAYq/EnY1RHur8l990cpwHm
	s7Dx0izbGsFfldM9w+Zj3JLR1VwdAqNPzvVn3dffAWldqRqhS945dt5wA+TodnbrYVENNNYk4dm
	lgmb88ihuNkqkBfoswYrKnK8Swk1DhqxLO5jpifacxoqe9WaPcvhvQexzi1rVvdpvI68dCPJUbb
	D8hJRsG0UoiH2wKjXQQ/E7kjggBtX0IojnGScv3qVg==
X-Google-Smtp-Source: AGHT+IEdY8qlHZe7orsNoht9Bsh11CwLM53lwWeatZV+reMxRxwpbzZxutRcb4G6ECMFbiqKGfQNLQ==
X-Received: by 2002:a05:690c:d1f:b0:708:4d42:1a13 with SMTP id 00721157ae682-708abd7da80mr21320087b3.12.1745969938843;
        Tue, 29 Apr 2025 16:38:58 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708adfc3d2bsm769387b3.5.2025.04.29.16.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:38:58 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/18] swap: manage swap entry lifetime at the virtual swap layer
Date: Tue, 29 Apr 2025 16:38:38 -0700
Message-ID: <20250429233848.3093350-11-nphamcs@gmail.com>
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

This patch moves the swap entry lifetime to the virtual swap layer (if
we enable swap virtualization), by adding to the swap descriptor an
atomic field named "swap_refs" that takes into account:

1. Whether the swap entry is in swap cache (or about to be added). This
   is indicated by the last bit of the field.
2. The swap count of the swap entry, which counts the number of page
   table entries at which the swap entry is inserted. This is given by
   the remaining bits of the field.

We also re-implement all of the swap entry lifetime API
(swap_duplicate(), swap_free_nr(), swapcache_prepare(), etc.) in the
virtual swap layer.

For now, we do not implement swap count continuation - the swap_count
field in the swap descriptor is big enough to hold the maximum number of
swap counts. This vastly simplifies the logic.

Note that the swapfile's swap map can be now be reduced under the virtual swap
implementation, as each slot can now only have 3 states: unallocated,
allocated, and bad slot. However, I leave this simplification to future work,
to minimize the amount of code change for review here.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  40 ++++-
 mm/memory.c          |   6 +
 mm/swapfile.c        | 124 +++++++++++---
 mm/vswap.c           | 400 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 536 insertions(+), 34 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0f1337431e27..798adfbd43cb 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -225,6 +225,11 @@ enum {
 #define SWAP_CLUSTER_MAX_SKIPPED (SWAP_CLUSTER_MAX << 10)
 #define COMPACT_CLUSTER_MAX SWAP_CLUSTER_MAX
 
+#ifdef CONFIG_VIRTUAL_SWAP
+/* Swapfile's swap map state*/
+#define SWAP_MAP_ALLOCATED	0x01	/* Page is allocated */
+#define SWAP_MAP_BAD	0x02	/* Page is bad */
+#else
 /* Bit flag in swap_map */
 #define SWAP_HAS_CACHE	0x40	/* Flag page is cached, in first swap_map */
 #define COUNT_CONTINUED	0x80	/* Flag swap_map continuation for full count */
@@ -236,6 +241,7 @@ enum {
 
 /* Special value in each swap_map continuation */
 #define SWAP_CONT_MAX	0x7f	/* Max count */
+#endif /* CONFIG_VIRTUAL_SWAP */
 
 /*
  * We use this to track usage of a cluster. A cluster is a block of swap disk
@@ -453,7 +459,7 @@ extern void __meminit kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
 
-/* Lifetime swap API (mm/swapfile.c) */
+/* Lifetime swap API (mm/swapfile.c or mm/vswap.c) */
 swp_entry_t folio_alloc_swap(struct folio *folio);
 bool folio_free_swap(struct folio *folio);
 void swap_shmem_alloc(swp_entry_t, int);
@@ -507,7 +513,9 @@ void swap_slot_put_folio(swp_slot_t slot, struct folio *folio);
 swp_slot_t swap_slot_alloc_of_type(int);
 int swap_slot_alloc(int n, swp_slot_t swp_slots[], int order);
 void swap_slot_free_nr(swp_slot_t slot, int nr_pages);
+#ifndef CONFIG_VIRTUAL_SWAP
 int add_swap_count_continuation(swp_entry_t, gfp_t);
+#endif
 void swap_slot_cache_free_slots(swp_slot_t *slots, int n);
 int swap_type_of(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
@@ -560,10 +568,12 @@ static inline void free_swap_cache(struct folio *folio)
 {
 }
 
+#ifndef CONFIG_VIRTUAL_SWAP
 static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
 {
 	return 0;
 }
+#endif
 
 static inline void swap_shmem_alloc(swp_entry_t swp, int nr)
 {
@@ -729,9 +739,14 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 #ifdef CONFIG_VIRTUAL_SWAP
 int vswap_init(void);
 void vswap_exit(void);
-void vswap_free(swp_entry_t entry);
 swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry);
 swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot);
+bool vswap_tryget(swp_entry_t entry);
+void vswap_put(swp_entry_t entry);
+bool folio_swapped(struct folio *folio);
+bool vswap_swapcache_only(swp_entry_t entry, int nr);
+int non_swapcache_batch(swp_entry_t entry, int nr);
+void put_swap_folio(struct folio *folio, swp_entry_t entry);
 #else /* CONFIG_VIRTUAL_SWAP */
 static inline int vswap_init(void)
 {
@@ -765,26 +780,41 @@ static inline swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
 {
 	return (swp_entry_t) { slot.val };
 }
-#endif /* CONFIG_VIRTUAL_SWAP */
 
 static inline void put_swap_folio(struct folio *folio, swp_entry_t entry)
 {
 	swap_slot_put_folio(swp_entry_to_swp_slot(entry), folio);
 }
+#endif /* CONFIG_VIRTUAL_SWAP */
 
 static inline bool trylock_swapoff(swp_entry_t entry,
 				struct swap_info_struct **si)
 {
 	swp_slot_t slot = swp_entry_to_swp_slot(entry);
 
+	/*
+	 * Note that in the virtual swap implementation, we do not need to do anything
+	 * to guard against concurrent swapoff for the swap entry's metadata:
+	 *
+	 * 1. The swap descriptor (struct swp_desc) has its existence guaranteed by
+	 *    RCU + its reference count.
+	 *
+	 * 2. Swap cache, zswap trees, etc. are all statically declared, and never
+	 *    freed.
+	 *
+	 * We do, however, need a reference to the swap device itself, because we
+	 * need swap device's metadata in certain scenarios, for example when we
+	 * need to inspect the swap device flag in do_swap_page().
+	 */
 	*si = swap_slot_tryget_swap_info(slot);
-	return *si;
+	return IS_ENABLED(CONFIG_VIRTUAL_SWAP) || *si;
 }
 
 static inline void unlock_swapoff(swp_entry_t entry,
 				struct swap_info_struct *si)
 {
-	swap_slot_put_swap_info(si);
+	if (si)
+		swap_slot_put_swap_info(si);
 }
 
 #endif /* __KERNEL__*/
diff --git a/mm/memory.c b/mm/memory.c
index c44e845b5320..a8c418104f28 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1202,10 +1202,14 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 
 	if (ret == -EIO) {
 		VM_WARN_ON_ONCE(!entry.val);
+		/* virtual swap implementation does not have swap count continuation */
+		VM_WARN_ON_ONCE(IS_ENABLED(CONFIG_VIRTUAL_SWAP));
+#ifndef CONFIG_VIRTUAL_SWAP
 		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0) {
 			ret = -ENOMEM;
 			goto out;
 		}
+#endif
 		entry.val = 0;
 	} else if (ret == -EBUSY || unlikely(ret == -EHWPOISON)) {
 		goto out;
@@ -4123,6 +4127,7 @@ static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifndef CONFIG_VIRTUAL_SWAP
 static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 {
 	swp_slot_t slot = swp_entry_to_swp_slot(entry);
@@ -4143,6 +4148,7 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 
 	return i;
 }
+#endif
 
 /*
  * Check if the PTEs within a range are contiguous swap entries
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 849525810bbe..c09011867263 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -50,8 +50,10 @@
 #include "internal.h"
 #include "swap.h"
 
+#ifndef CONFIG_VIRTUAL_SWAP
 static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 				 unsigned char);
+#endif
 static void free_swap_count_continuations(struct swap_info_struct *);
 static void swap_slot_range_free(struct swap_info_struct *si,
 				  struct swap_cluster_info *ci,
@@ -156,6 +158,25 @@ static long swap_usage_in_pages(struct swap_info_struct *si)
 /* Reclaim directly, bypass the slot cache and don't touch device lock */
 #define TTRS_DIRECT		0x8
 
+#ifdef CONFIG_VIRTUAL_SWAP
+static inline unsigned char swap_count(unsigned char ent)
+{
+	return ent;
+}
+
+static bool swap_is_has_cache(struct swap_info_struct *si,
+			      unsigned long offset, int nr_pages)
+{
+	swp_entry_t entry = swp_slot_to_swp_entry(swp_slot(si->type, offset));
+
+	return vswap_swapcache_only(entry, nr_pages);
+}
+
+static bool swap_cache_only(struct swap_info_struct *si, unsigned long offset)
+{
+	return swap_is_has_cache(si, offset, 1);
+}
+#else
 static inline unsigned char swap_count(unsigned char ent)
 {
 	return ent & ~SWAP_HAS_CACHE;	/* may include COUNT_CONTINUED flag */
@@ -176,6 +197,11 @@ static bool swap_is_has_cache(struct swap_info_struct *si,
 	return true;
 }
 
+static bool swap_cache_only(struct swap_info_struct *si, unsigned long offset)
+{
+	return READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE;
+}
+
 static bool swap_is_last_map(struct swap_info_struct *si,
 		unsigned long offset, int nr_pages, bool *has_cache)
 {
@@ -194,6 +220,7 @@ static bool swap_is_last_map(struct swap_info_struct *si,
 	*has_cache = !!(count & SWAP_HAS_CACHE);
 	return true;
 }
+#endif
 
 /*
  * returns number of pages in the folio that backs the swap entry. If positive,
@@ -250,7 +277,11 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	if (!need_reclaim)
 		goto out_unlock;
 
-	if (!(flags & TTRS_DIRECT)) {
+	/*
+	 * For now, virtual swap implementation only supports freeing through the
+	 * swap slot cache...
+	 */
+	if (!(flags & TTRS_DIRECT) || IS_ENABLED(CONFIG_VIRTUAL_SWAP)) {
 		/* Free through slot cache */
 		delete_from_swap_cache(folio);
 		folio_set_dirty(folio);
@@ -700,7 +731,12 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 		case 0:
 			offset++;
 			break;
+#ifdef CONFIG_VIRTUAL_SWAP
+		/* __try_to_reclaim_swap() checks if the slot is in-cache only */
+		case SWAP_MAP_ALLOCATED:
+#else
 		case SWAP_HAS_CACHE:
+#endif
 			nr_reclaim = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY | TTRS_DIRECT);
 			if (nr_reclaim > 0)
 				offset += nr_reclaim;
@@ -731,19 +767,20 @@ static bool cluster_scan_range(struct swap_info_struct *si,
 {
 	unsigned long offset, end = start + nr_pages;
 	unsigned char *map = si->swap_map;
+	unsigned char count;
 
 	for (offset = start; offset < end; offset++) {
-		switch (READ_ONCE(map[offset])) {
-		case 0:
+		count = READ_ONCE(map[offset]);
+		if (!count)
 			continue;
-		case SWAP_HAS_CACHE:
+
+		if (swap_cache_only(si, offset)) {
 			if (!vm_swap_full())
 				return false;
 			*need_reclaim = true;
 			continue;
-		default:
-			return false;
 		}
+		return false;
 	}
 
 	return true;
@@ -836,7 +873,6 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 	long to_scan = 1;
 	unsigned long offset, end;
 	struct swap_cluster_info *ci;
-	unsigned char *map = si->swap_map;
 	int nr_reclaim;
 
 	if (force)
@@ -848,7 +884,7 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 		to_scan--;
 
 		while (offset < end) {
-			if (READ_ONCE(map[offset]) == SWAP_HAS_CACHE) {
+			if (swap_cache_only(si, offset)) {
 				spin_unlock(&ci->lock);
 				nr_reclaim = __try_to_reclaim_swap(si, offset,
 								   TTRS_ANYWAY | TTRS_DIRECT);
@@ -1175,6 +1211,10 @@ static int cluster_alloc_swap(struct swap_info_struct *si,
 {
 	int n_ret = 0;
 
+#ifdef CONFIG_VIRTUAL_SWAP
+	VM_WARN_ON(usage != SWAP_MAP_ALLOCATED);
+#endif
+
 	while (n_ret < nr) {
 		unsigned long offset = cluster_alloc_swap_slot(si, order, usage);
 
@@ -1192,6 +1232,10 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 {
 	unsigned int nr_pages = 1 << order;
 
+#ifdef CONFIG_VIRTUAL_SWAP
+	VM_WARN_ON(usage != SWAP_MAP_ALLOCATED);
+#endif
+
 	/*
 	 * We try to cluster swap pages by allocating them sequentially
 	 * in swap.  Once we've allocated SWAPFILE_CLUSTER pages this
@@ -1248,7 +1292,13 @@ int swap_slot_alloc(int n_goal, swp_slot_t swp_slots[], int entry_order)
 	long avail_pgs;
 	int n_ret = 0;
 	int node;
+	unsigned char usage;
 
+#ifdef CONFIG_VIRTUAL_SWAP
+	usage = SWAP_MAP_ALLOCATED;
+#else
+	usage = SWAP_HAS_CACHE;
+#endif
 	spin_lock(&swap_avail_lock);
 
 	avail_pgs = atomic_long_read(&nr_swap_pages) / size;
@@ -1268,8 +1318,7 @@ int swap_slot_alloc(int n_goal, swp_slot_t swp_slots[], int entry_order)
 		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
 		spin_unlock(&swap_avail_lock);
 		if (get_swap_device_info(si)) {
-			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
-					n_goal, swp_slots, order);
+			n_ret = scan_swap_map_slots(si, usage, n_goal, swp_slots, order);
 			swap_slot_put_swap_info(si);
 			if (n_ret || size > 1)
 				goto check_out;
@@ -1402,6 +1451,17 @@ struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot)
 	return NULL;
 }
 
+#ifdef CONFIG_VIRTUAL_SWAP
+static unsigned char __swap_slot_free_locked(struct swap_info_struct *si,
+					      unsigned long offset,
+					      unsigned char usage)
+{
+	VM_WARN_ON(usage != 1);
+	VM_WARN_ON(si->swap_map[offset] != SWAP_MAP_ALLOCATED);
+
+	return 0;
+}
+#else
 static unsigned char __swap_slot_free_locked(struct swap_info_struct *si,
 					      unsigned long offset,
 					      unsigned char usage)
@@ -1499,6 +1559,7 @@ static bool __swap_slots_free(struct swap_info_struct *si,
 	}
 	return has_cache;
 }
+#endif /* CONFIG_VIRTUAL_SWAP */
 
 /*
  * Drop the last HAS_CACHE flag of swap entries, caller have to
@@ -1511,21 +1572,17 @@ static void swap_slot_range_free(struct swap_info_struct *si,
 	unsigned long offset = swp_slot_offset(slot);
 	unsigned char *map = si->swap_map + offset;
 	unsigned char *map_end = map + nr_pages;
-	swp_entry_t entry = swp_slot_to_swp_entry(slot);
-#ifdef CONFIG_VIRTUAL_SWAP
-	int i;
+	unsigned char usage;
 
-	/* release all the associated (virtual) swap slots */
-	for (i = 0; i < nr_pages; i++) {
-		vswap_free(entry);
-		entry.val++;
-	}
+#ifdef CONFIG_VIRTUAL_SWAP
+	usage = SWAP_MAP_ALLOCATED;
 #else
 	/*
 	 * In the new (i.e virtual swap) implementation, we will let the virtual
 	 * swap layer handle the cgroup swap accounting and charging.
 	 */
-	mem_cgroup_uncharge_swap(entry, nr_pages);
+	mem_cgroup_uncharge_swap(swp_slot_to_swp_entry(slot), nr_pages);
+	usage = SWAP_HAS_CACHE;
 #endif
 
 	/* It should never free entries across different clusters */
@@ -1535,7 +1592,7 @@ static void swap_slot_range_free(struct swap_info_struct *si,
 
 	ci->count -= nr_pages;
 	do {
-		VM_BUG_ON(*map != SWAP_HAS_CACHE);
+		VM_BUG_ON(*map != usage);
 		*map = 0;
 	} while (++map < map_end);
 
@@ -1580,6 +1637,7 @@ void swap_slot_free_nr(swp_slot_t slot, int nr_pages)
 	}
 }
 
+#ifndef CONFIG_VIRTUAL_SWAP
 /*
  * Caller has made sure that the swap device corresponding to entry
  * is still around or has not been recycled.
@@ -1588,9 +1646,11 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
 {
 	swap_slot_free_nr(swp_entry_to_swp_slot(entry), nr_pages);
 }
+#endif
 
 /*
- * Called after dropping swapcache to decrease refcnt to swap entries.
+ * This should only be called in contexts in which the slot has
+ * been allocated but not associated with any swap entries.
  */
 void swap_slot_put_folio(swp_slot_t slot, struct folio *folio)
 {
@@ -1598,23 +1658,31 @@ void swap_slot_put_folio(swp_slot_t slot, struct folio *folio)
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
 	int size = 1 << swap_slot_order(folio_order(folio));
+	unsigned char usage;
 
 	si = _swap_info_get(slot);
 	if (!si)
 		return;
 
+#ifdef CONFIG_VIRTUAL_SWAP
+	usage = SWAP_MAP_ALLOCATED;
+#else
+	usage = SWAP_HAS_CACHE;
+#endif
+
 	ci = lock_cluster(si, offset);
 	if (swap_is_has_cache(si, offset, size))
 		swap_slot_range_free(si, ci, slot, size);
 	else {
 		for (int i = 0; i < size; i++, slot.val++) {
-			if (!__swap_slot_free_locked(si, offset + i, SWAP_HAS_CACHE))
+			if (!__swap_slot_free_locked(si, offset + i, usage))
 				swap_slot_range_free(si, ci, slot, 1);
 		}
 	}
 	unlock_cluster(ci);
 }
 
+#ifndef CONFIG_VIRTUAL_SWAP
 int __swap_count(swp_entry_t entry)
 {
 	swp_slot_t slot = swp_entry_to_swp_slot(entry);
@@ -1785,7 +1853,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	 */
 	for (offset = start_offset; offset < end_offset; offset += nr) {
 		nr = 1;
-		if (READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
+		if (swap_cache_only(si, offset)) {
 			/*
 			 * Folios are always naturally aligned in swap so
 			 * advance forward to the next boundary. Zero means no
@@ -1807,6 +1875,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 out:
 	swap_slot_put_swap_info(si);
 }
+#endif /* CONFIG_VIRTUAL_SWAP */
 
 void swap_slot_cache_free_slots(swp_slot_t *slots, int n)
 {
@@ -3587,6 +3656,14 @@ pgoff_t __folio_swap_cache_index(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(__folio_swap_cache_index);
 
+#ifdef CONFIG_VIRTUAL_SWAP
+/*
+ * We do not use continuation in virtual swap implementation.
+ */
+static void free_swap_count_continuations(struct swap_info_struct *si)
+{
+}
+#else /* CONFIG_VIRTUAL_SWAP */
 /*
  * Verify that nr swap entries are valid and increment their swap map counts.
  *
@@ -3944,6 +4021,7 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
 		}
 	}
 }
+#endif /* CONFIG_VIRTUAL_SWAP */
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
 void __folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
diff --git a/mm/vswap.c b/mm/vswap.c
index 3792fa7f766b..513d000a134c 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -18,8 +18,23 @@
  * us to change the backing state of a swapped out page without having to
  * update every single page table entries referring to it.
  *
- * For now, there is a one-to-one correspondence between a virtual swap slot
- * and its associated physical swap slot.
+ *
+ * I. Swap Entry Lifetime
+ *
+ * The swap entry's lifetime is now managed at the virtual swap layer. We
+ * assign each virtual swap slot a reference count, which includes:
+ *
+ * 1. The number of page table entries that refer to the virtual swap slot, i.e
+ *    its swap count.
+ *
+ * 2. Whether the virtual swap slot has been added to the swap cache - if so,
+ *    its reference count is incremented by 1.
+ *
+ * Each virtual swap slot starts out with a reference count of 1 (since it is
+ * about to be added to the swap cache). Its reference count is incremented or
+ * decremented every time it is mapped to or unmapped from a PTE, as well as
+ * when it is added to or removed from the swap cache. Finally, when its
+ * reference count reaches 0, the virtual swap slot is freed.
  */
 
 /**
@@ -27,14 +42,24 @@
  *
  * @slot: The handle to the physical swap slot backing this page.
  * @rcu: The RCU head to free the descriptor with an RCU grace period.
+ * @lock: The lock protecting the swap slot backing field.
  * @memcgid: The memcg id of the owning memcg, if any.
+ * @swap_refs: This field stores all the references to the swap entry. The
+ *             least significant bit indicates whether the swap entry is (about
+ *             to be) pinned in swap cache. The remaining bits tell us the
+ *             number of page table entries that refer to the swap entry.
  */
 struct swp_desc {
 	swp_slot_t slot;
 	struct rcu_head rcu;
+
+	rwlock_t lock;
+
 #ifdef CONFIG_MEMCG
 	atomic_t memcgid;
 #endif
+
+	atomic_t swap_refs;
 };
 
 /* Virtual swap space - swp_entry_t -> struct swp_desc */
@@ -78,6 +103,11 @@ static struct kmem_cache *swp_desc_cache;
 static atomic_t vswap_alloc_reject;
 static atomic_t vswap_used;
 
+/* least significant bit is for swap cache pin, the rest is for swap count. */
+#define SWAP_CACHE_SHIFT 1
+#define SWAP_CACHE_INC 1
+#define SWAP_COUNT_INC 2
+
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 
@@ -129,6 +159,9 @@ static swp_entry_t vswap_alloc(int nr)
 	for (i = 0; i < nr; i++) {
 		descs[i]->slot.val = 0;
 		atomic_set(&descs[i]->memcgid, 0);
+		/* swap entry is about to be added to the swap cache */
+		atomic_set(&descs[i]->swap_refs, 1);
+		rwlock_init(&descs[i]->lock);
 	}
 
 	xa_lock(&vswap_map);
@@ -215,7 +248,7 @@ static inline void release_vswap_slot(unsigned long index)
  * vswap_free - free a virtual swap slot.
  * @id: the virtual swap slot to free
  */
-void vswap_free(swp_entry_t entry)
+static void vswap_free(swp_entry_t entry)
 {
 	struct swp_desc *desc;
 
@@ -233,6 +266,7 @@ void vswap_free(swp_entry_t entry)
 		/* we only charge after linkage was established */
 		mem_cgroup_uncharge_swap(entry, 1);
 		xa_erase(&vswap_rmap, desc->slot.val);
+		swap_slot_free_nr(desc->slot, 1);
 	}
 
 	/* erase forward mapping and release the virtual slot for reallocation */
@@ -332,12 +366,24 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
 {
 	struct swp_desc *desc;
+	swp_slot_t slot;
 
 	if (!entry.val)
 		return (swp_slot_t){0};
 
+	rcu_read_lock();
 	desc = xa_load(&vswap_map, entry.val);
-	return desc ? desc->slot : (swp_slot_t){0};
+	if (!desc) {
+		rcu_read_unlock();
+		return (swp_slot_t){0};
+	}
+
+	read_lock(&desc->lock);
+	slot = desc->slot;
+	read_unlock(&desc->lock);
+	rcu_read_unlock();
+
+	return slot;
 }
 
 /**
@@ -349,13 +395,355 @@ swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
  */
 swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
 {
-	void *entry = xa_load(&vswap_rmap, slot.val);
+	swp_entry_t ret;
+	void *entry;
 
+	rcu_read_lock();
 	/*
 	 * entry can be NULL if we fail to link the virtual and physical swap slot
 	 * during the swap slot allocation process.
 	 */
-	return entry ? (swp_entry_t){xa_to_value(entry)} : (swp_entry_t){0};
+	entry = xa_load(&vswap_rmap, slot.val);
+	if (!entry)
+		ret.val = 0;
+	else
+		ret = (swp_entry_t){xa_to_value(entry)};
+	rcu_read_unlock();
+	return ret;
+}
+
+/*
+ * Decrease the swap count of nr contiguous swap entries by 1 (when the swap
+ * entries are removed from a range of PTEs), and check if any of the swap
+ * entries are in swap cache only after its swap count is decreased.
+ *
+ * The check is racy, but it is OK because free_swap_and_cache_nr() only use
+ * the result as a hint.
+ */
+static bool vswap_free_nr_any_cache_only(swp_entry_t entry, int nr)
+{
+	struct swp_desc *desc;
+	bool ret = false;
+	int end = entry.val + nr - 1;
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, end) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		/* 1 page table entry ref + 1 swap cache ref == 11 (binary) */
+		ret |= (atomic_read(&desc->swap_refs) == 3);
+		if (atomic_sub_and_test(SWAP_COUNT_INC, &desc->swap_refs))
+			vswap_free(entry);
+		entry.val++;
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+/**
+ * swap_free_nr - decrease the swap count of nr contiguous swap entries by 1
+ *                (when the swap entries are removed from a range of PTEs).
+ * @entry: the first entry in the range.
+ * @nr: the number of entries in the range.
+ */
+void swap_free_nr(swp_entry_t entry, int nr)
+{
+	vswap_free_nr_any_cache_only(entry, nr);
+}
+
+static int swap_duplicate_nr(swp_entry_t entry, int nr)
+{
+	struct swp_desc *desc;
+	int i = 0;
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		if (!desc || !atomic_add_unless(&desc->swap_refs, SWAP_COUNT_INC, 0))
+			goto done;
+		i++;
+	}
+done:
+	rcu_read_unlock();
+	if (i && i < nr)
+		swap_free_nr(entry, i);
+
+	return i == nr ? 0 : -ENOENT;
+}
+
+/**
+ * swap_duplicate - increase the swap count of the swap entry by 1 (i.e when
+ *                  the swap entry is stored at a new PTE).
+ * @entry: the swap entry.
+ *
+ * Return: 0 (always).
+ *
+ * Note that according to the existing API, we ALWAYS returns 0 unless a swap
+ * continuation is required (which is no longer the case in the new design).
+ */
+int swap_duplicate(swp_entry_t entry)
+{
+	swap_duplicate_nr(entry, 1);
+	return 0;
+}
+
+static int vswap_swap_count(atomic_t *swap_refs)
+{
+	return atomic_read(swap_refs) >> SWAP_CACHE_SHIFT;
+}
+
+bool folio_swapped(struct folio *folio)
+{
+	swp_entry_t entry = folio->swap;
+	int nr = folio_nr_pages(folio);
+	struct swp_desc *desc;
+	bool swapped = false;
+
+	if (!entry.val)
+		return false;
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		if (desc && vswap_swap_count(&desc->swap_refs)) {
+			swapped = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return swapped;
+}
+
+/**
+ * swp_swapcount - return the swap count of the swap entry.
+ * @id: the swap entry.
+ *
+ * Note that all the swap count functions are identical in the new design,
+ * since we no longer need swap count continuation.
+ *
+ * Return: the swap count of the swap entry.
+ */
+int swp_swapcount(swp_entry_t entry)
+{
+	struct swp_desc *desc;
+	unsigned int ret;
+
+	rcu_read_lock();
+	desc = xa_load(&vswap_map, entry.val);
+	ret = desc ? vswap_swap_count(&desc->swap_refs) : 0;
+	rcu_read_unlock();
+
+	return ret;
+}
+
+int __swap_count(swp_entry_t entry)
+{
+	return swp_swapcount(entry);
+}
+
+int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
+{
+	return swp_swapcount(entry);
+}
+
+void swap_shmem_alloc(swp_entry_t entry, int nr)
+{
+	swap_duplicate_nr(entry, nr);
+}
+
+void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
+{
+	struct swp_desc *desc;
+	int end = entry.val + nr - 1;
+
+	if (!nr)
+		return;
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, end) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		if (atomic_dec_and_test(&desc->swap_refs))
+			vswap_free(entry);
+		entry.val++;
+	}
+	rcu_read_unlock();
+}
+
+int swapcache_prepare(swp_entry_t entry, int nr)
+{
+	struct swp_desc *desc;
+	int old, new, i = 0, ret = 0;
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		if (!desc) {
+			ret = -ENOENT;
+			goto done;
+		}
+
+		old = atomic_read(&desc->swap_refs);
+		do {
+			new = old;
+			ret = 0;
+
+			if (!old)
+				ret = -ENOENT;
+			else if (old & SWAP_CACHE_INC)
+				ret = -EEXIST;
+			else
+				new += SWAP_CACHE_INC;
+		} while (!atomic_try_cmpxchg(&desc->swap_refs, &old, new));
+
+		if (ret)
+			goto done;
+
+		i++;
+	}
+done:
+	rcu_read_unlock();
+	if (i && i < nr)
+		swapcache_clear(NULL, entry, i);
+	if (i < nr && !ret)
+		ret = -ENOENT;
+	return ret;
+}
+
+/**
+ * vswap_swapcache_only - check if all the slots in the range are still valid,
+ *                        and are in swap cache only (i.e not stored in any
+ *                        PTEs).
+ * @entry: the first slot in the range.
+ * @nr: the number of slots in the range.
+ *
+ * Return: true if all the slots in the range are still valid, and are in swap
+ * cache only, or false otherwise.
+ */
+bool vswap_swapcache_only(swp_entry_t entry, int nr)
+{
+	struct swp_desc *desc;
+	int i = 0;
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		if (!desc || atomic_read(&desc->swap_refs) != SWAP_CACHE_INC)
+			goto done;
+		i++;
+	}
+done:
+	rcu_read_unlock();
+	return i == nr;
+}
+
+/**
+ * non_swapcache_batch - count the longest range starting from a particular
+ *                       swap slot that are stil valid, but not in swap cache.
+ * @entry: the first slot to check.
+ * @max_nr: the maximum number of slots to check.
+ *
+ * Return: the number of slots in the longest range that are still valid, but
+ * not in swap cache.
+ */
+int non_swapcache_batch(swp_entry_t entry, int max_nr)
+{
+	struct swp_desc *desc;
+	int swap_refs, i = 0;
+
+	if (!entry.val)
+		return 0;
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + max_nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		swap_refs = atomic_read(&desc->swap_refs);
+		if (!(swap_refs & SWAP_CACHE_INC) && (swap_refs >> SWAP_CACHE_SHIFT))
+			goto done;
+		i++;
+	}
+done:
+	rcu_read_unlock();
+	return i;
+}
+
+/**
+ * free_swap_and_cache_nr() - Release a swap count on range of swap entries and
+ *                            reclaim their cache if no more references remain.
+ * @entry: First entry of range.
+ * @nr: Number of entries in range.
+ *
+ * For each swap entry in the contiguous range, release a swap count. If any
+ * swap entries have their swap count decremented to zero, try to reclaim their
+ * associated swap cache pages.
+ */
+void free_swap_and_cache_nr(swp_entry_t entry, int nr)
+{
+	int i = 0, incr = 1;
+	struct folio *folio;
+
+	if (non_swap_entry(entry))
+		return;
+
+	if (vswap_free_nr_any_cache_only(entry, nr)) {
+		while (i < nr) {
+			incr = 1;
+			if (vswap_swapcache_only(entry, 1)) {
+				folio = filemap_get_folio(swap_address_space(entry),
+							swap_cache_index(entry));
+				if (IS_ERR(folio))
+					goto next;
+				if (!folio_trylock(folio)) {
+					folio_put(folio);
+					goto next;
+				}
+				incr = folio_nr_pages(folio);
+				folio_free_swap(folio);
+				folio_unlock(folio);
+				folio_put(folio);
+			}
+next:
+			i += incr;
+			entry.val += incr;
+		}
+	}
+}
+
+/*
+ * Called after dropping swapcache to decrease refcnt to swap entries.
+ */
+void put_swap_folio(struct folio *folio, swp_entry_t entry)
+{
+	int nr = folio_nr_pages(folio);
+
+	VM_WARN_ON(!folio_test_locked(folio));
+	swapcache_clear(NULL, entry, nr);
 }
 
 #ifdef CONFIG_MEMCG
-- 
2.47.1


