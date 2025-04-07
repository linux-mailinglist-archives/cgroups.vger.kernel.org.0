Return-Path: <cgroups+bounces-7412-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA463A7F155
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 01:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EA517A70E
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE342550A5;
	Mon,  7 Apr 2025 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjHysosq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9FE22D782;
	Mon,  7 Apr 2025 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069354; cv=none; b=rSI80x5t3M6nuMliGRxZFvk3LnRitmeAN9bhC6xPFvR8Lh14FJZY1EJTPYOqBhU+voJw3k5HlC6ShtGBJt0CrTDxfxUL4SbpdMmL1ptDibz/cDNZqewr4XSAnxx/IUrP/Mi7sD/nRvTSaxKdhbGvQTMas1IfFrjoavbLlgklqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069354; c=relaxed/simple;
	bh=VNV8V2TD8sJ+kBW7b5wms+zCH1ocOfgiZhE6eGWPQ58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIsSzrE5LXVVV/XEmaYE3cN2HpaQ2ZQnKNJIg7vbY7aXkqw8SpRIMDbDJpOQI+ojxfV1ZGp+EjC5SO6gOIlfBTmcsGwkWNnJzI8isH5kUO2vn6STuKqsdFh6kKpzYX03BJ0lw1SkDxpAhDQE3JrzGfL5SnAVPsZO86oAW1OPx84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjHysosq; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e694601f624so3075801276.1;
        Mon, 07 Apr 2025 16:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069349; x=1744674149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNVQHiku0n4XKZtgC76yPMy41UVumnRAWSS0zwzH74g=;
        b=XjHysosqKJnotn67XPb/5Uxi0c7WUR2rNI2Cgjt10F8VCPMp48P9VH0qBsMlfBMjUe
         4cbOBQU6cCiYv03rbRSyqOZEuJv6+qqmTY28fWR5XdijEpT0UbSD3acWqn98I0UttXQV
         KeDC/DVUAb+63mniY0EmW/RxsDDqsxSzCq4sZ9BaVauwW7PakXERjOAtNPaKtLNJIANT
         xWPSR3fvf1tSSb7qz2bYntuP1//PuNEvx6It+5h+ZZtNromhbhEs9l2OsNA1sJXtRvup
         Ndku0XDMi/+KMFOX6N873aNVVWQqAaaXAXuyIXS3OTYEaWS+Zi0+ipJz0iLeN8PatYuo
         M1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069349; x=1744674149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNVQHiku0n4XKZtgC76yPMy41UVumnRAWSS0zwzH74g=;
        b=ZTc3ybvXZaWODaL0ssp4cDl596YSmAyGfmJeBcgMuGxmKex4jKDvK9RuxftuC8h9QC
         TnXHj2+MHNuLarsTXTyRfZ1Kgn/tll10AWQnqo4Ebu0T/6axjsM1MpHZuUAUxS7vZTRl
         JT+5VD3fBe66mBc6iqAEjtMcx0YdfNTmN72pQEDXeCtfIlpDARgOgQMqZo686egU/H/M
         gq8wJgBtXdXef6AToNcdibaSUT8NkVrVKgwCvybGQLYQGVhR8XnHCUpqgtMxxhEz4ORW
         NKXJsisynHV1xE2JT0hoi7a6VrFxL+g4lUa3ORiAAjwOYa3eQMAnicajDBWW7PFhpnXg
         Sjpg==
X-Forwarded-Encrypted: i=1; AJvYcCU/RQK6AhkFHWxqj2EXjBnA0k7AivpVaor8TKluoZ5Xq9NDUNkR6e7TmTF5P1wT2REKNIFNC2oin3A=@vger.kernel.org, AJvYcCUQj1zcey9a3VKgnBFFbWSiUjcYeaFuotF1sg35VPMLGPWGuqX2tplw5QyQGK9gfqZqc4wfVMsH3LxEC1Jm@vger.kernel.org, AJvYcCWaXjfeJF4ePgQ6U1WA6YVuLm/oKlwrZIjHUJn+bwfPPSk60tMOAacUhKtQP488yvkz50DQnacT@vger.kernel.org
X-Gm-Message-State: AOJu0YylmghasntV6jormuIxsVh2bxmdGiYiWnatYygP6Ulpkq4+lqGd
	IXkdP9PlacoM7DR/I3Fn8bckYC0otI+bpA/xXPiv4ddKP2+N3u7F
X-Gm-Gg: ASbGncsKUcm+77B4HOviz5oYm/TMi1r9yz6e4NESxV61oYOxLB8EvhTigdHAj1QX8XN
	XCTwD8I+8JpB6B4eRBnIS7Ie2CyGHvsFv3Ff+Aipd5w1PGAxTeBO6kuyP0NqvITW6M9lPsfCyU2
	bR1IXRnJgaU8NqXDsR7aJN8FGvLYaZ5oZdLcmAY4+lRAMJjvxITp6TjjcNp/lDcbsiEM8bWyavM
	wx/0zh9qxKMT6e/jktTU9ev3lpQYLNBaR7m6sEzG4cYatNeLTg+mnpd6ogQGVufgsAwHGoDpl7l
	mQO2NNfm15X92prh9nv3RLigYY1NZERsQKM=
X-Google-Smtp-Source: AGHT+IE+lbdLl8MqQcRcXE001XWwyvAzkYyhe/+Zkj12tCYH8oWKsSx+lBTqIB8/ocetOa6JVsIIzQ==
X-Received: by 2002:a05:690c:9a0e:b0:6fe:bfb9:549c with SMTP id 00721157ae682-703f41257b5mr197667807b3.1.1744069349294;
        Mon, 07 Apr 2025 16:42:29 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1e6034fsm27730647b3.48.2025.04.07.16.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:42:29 -0700 (PDT)
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
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 08/14] swap: manage swap entry lifetime at the virtual swap layer
Date: Mon,  7 Apr 2025 16:42:09 -0700
Message-ID: <20250407234223.1059191-9-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250407234223.1059191-1-nphamcs@gmail.com>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves the swap entry lifetime to the virtual swap layer (if
we enable swap virtualization), by adding the following fields to the
swap descriptor:

1. Whether the swap entry is in swap cache (or about to be added).
2. The swap count of the swap entry, which counts the number of page
   table entries at which the swap entry is inserted.
3. The reference count of the swap entry, which is the swap count of the
   swap entry, added one if the entry has been added to the swap cache.

We also re-implement all of the swap entry lifetime API
(swap_duplicate(), swap_free_nr(), swapcache_prepare(), etc.) in the
virtual swap layer.

Note that the swapfile's swap map can be now be reduced under the virtual swap
implementation, as each slot can now only have 3 states: unallocated,
allocated, and bad slot. However, I leave this simplification to future work,
to minimize the amount of code change for review in this series of work.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  33 ++--
 mm/memory.c          |   2 +
 mm/swapfile.c        | 128 +++++++++++---
 mm/vswap.c           | 400 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 522 insertions(+), 41 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index d32a2c300924..1d8679bd57f3 100644
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
@@ -455,7 +461,6 @@ extern void __meminit kswapd_stop(int nid);
 /* Virtual swap API */
 swp_entry_t folio_alloc_swap(struct folio *folio);
 bool folio_free_swap(struct folio *folio);
-int add_swap_count_continuation(swp_entry_t, gfp_t);
 void swap_shmem_alloc(swp_entry_t, int);
 int swap_duplicate(swp_entry_t);
 int swapcache_prepare(swp_entry_t entry, int nr);
@@ -559,11 +564,6 @@ static inline void free_swap_cache(struct folio *folio)
 {
 }
 
-static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
-{
-	return 0;
-}
-
 static inline void swap_shmem_alloc(swp_entry_t swp, int nr)
 {
 }
@@ -728,9 +728,13 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 #ifdef CONFIG_VIRTUAL_SWAP
 int vswap_init(void);
 void vswap_exit(void);
-void vswap_free(swp_entry_t entry);
 swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry);
 swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot);
+bool folio_swapped(struct folio *folio);
+bool vswap_swapcache_only(swp_entry_t entry, int nr);
+int non_swapcache_batch(swp_entry_t entry, int nr);
+bool swap_free_nr_any_cache_only(swp_entry_t entry, int nr);
+void put_swap_folio(struct folio *folio, swp_entry_t entry);
 #else
 static inline int vswap_init(void)
 {
@@ -741,10 +745,6 @@ static inline void vswap_exit(void)
 {
 }
 
-static inline void vswap_free(swp_entry_t entry)
-{
-}
-
 /**
  * swp_entry_to_swp_slot - look up the physical swap slot corresponding to a
  *                         virtual swap slot.
@@ -768,12 +768,12 @@ static inline swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
 {
 	return (swp_entry_t) { slot.val };
 }
-#endif
 
 static inline void put_swap_folio(struct folio *folio, swp_entry_t entry)
 {
 	swap_slot_put_folio(swp_entry_to_swp_slot(entry), folio);
 }
+#endif
 
 static inline bool trylock_swapoff(swp_entry_t entry,
 				struct swap_info_struct **si)
@@ -790,5 +790,14 @@ static inline void unlock_swapoff(swp_entry_t entry,
 	swap_slot_put_swap_info(si);
 }
 
+#if defined(CONFIG_SWAP) && !defined(CONFIG_VIRTUAL_SWAP)
+int add_swap_count_continuation(swp_entry_t, gfp_t);
+#else
+static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
+{
+	return 0;
+}
+#endif
+
 #endif /* __KERNEL__*/
 #endif /* _LINUX_SWAP_H */
diff --git a/mm/memory.c b/mm/memory.c
index c44e845b5320..a1d3631ad85f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4123,6 +4123,7 @@ static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifndef CONFIG_VIRTUAL_SWAP
 static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 {
 	swp_slot_t slot = swp_entry_to_swp_slot(entry);
@@ -4143,6 +4144,7 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 
 	return i;
 }
+#endif
 
 /*
  * Check if the PTEs within a range are contiguous swap entries
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 533011c97e03..babb545acffd 100644
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
@@ -1168,6 +1204,10 @@ static int cluster_alloc_swap(struct swap_info_struct *si,
 {
 	int n_ret = 0;
 
+#ifdef CONFIG_VIRTUAL_SWAP
+	VM_WARN_ON(usage != SWAP_MAP_ALLOCATED);
+#endif
+
 	while (n_ret < nr) {
 		unsigned long offset = cluster_alloc_swap_slot(si, order, usage);
 
@@ -1185,6 +1225,10 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 {
 	unsigned int nr_pages = 1 << order;
 
+#ifdef CONFIG_VIRTUAL_SWAP
+	VM_WARN_ON(usage != SWAP_MAP_ALLOCATED);
+#endif
+
 	/*
 	 * We try to cluster swap pages by allocating them sequentially
 	 * in swap.  Once we've allocated SWAPFILE_CLUSTER pages this
@@ -1241,7 +1285,13 @@ int swap_slot_alloc(int n_goal, swp_slot_t swp_slots[], int entry_order)
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
@@ -1261,8 +1311,7 @@ int swap_slot_alloc(int n_goal, swp_slot_t swp_slots[], int entry_order)
 		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
 		spin_unlock(&swap_avail_lock);
 		if (get_swap_device_info(si)) {
-			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
-					n_goal, swp_slots, order);
+			n_ret = scan_swap_map_slots(si, usage, n_goal, swp_slots, order);
 			swap_slot_put_swap_info(si);
 			if (n_ret || size > 1)
 				goto check_out;
@@ -1395,6 +1444,17 @@ struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot)
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
@@ -1492,6 +1552,7 @@ static bool __swap_slots_free(struct swap_info_struct *si,
 	}
 	return has_cache;
 }
+#endif /* CONFIG_VIRTUAL_SWAP */
 
 /*
  * Drop the last HAS_CACHE flag of swap entries, caller have to
@@ -1504,21 +1565,18 @@ static void swap_slot_range_free(struct swap_info_struct *si,
 	unsigned long offset = swp_slot_offset(slot);
 	unsigned char *map = si->swap_map + offset;
 	unsigned char *map_end = map + nr_pages;
-	swp_entry_t entry = swp_slot_to_swp_entry(slot);
-	int i;
+	unsigned char usage;
 
-#ifndef CONFIG_VIRTUAL_SWAP
+#ifdef CONFIG_VIRTUAL_SWAP
+	usage = SWAP_MAP_ALLOCATED;
+#else
 	/*
 	 * In the new (i.e virtual swap) implementation, we will let the virtual
 	 * swap layer handle the cgroup swap accounting and charging.
 	 */
-	mem_cgroup_uncharge_swap(entry, nr_pages);
+	mem_cgroup_uncharge_swap(swp_slot_to_swp_entry(slot), nr_pages);
+	usage = SWAP_HAS_CACHE;
 #endif
-	/* release all the associated (virtual) swap slots */
-	for (i = 0; i < nr_pages; i++) {
-		vswap_free(entry);
-		entry.val++;
-	}
 
 	/* It should never free entries across different clusters */
 	VM_BUG_ON(ci != offset_to_cluster(si, offset + nr_pages - 1));
@@ -1527,7 +1585,7 @@ static void swap_slot_range_free(struct swap_info_struct *si,
 
 	ci->count -= nr_pages;
 	do {
-		VM_BUG_ON(*map != SWAP_HAS_CACHE);
+		VM_BUG_ON(*map != usage);
 		*map = 0;
 	} while (++map < map_end);
 
@@ -1572,6 +1630,7 @@ void swap_slot_free_nr(swp_slot_t slot, int nr_pages)
 	}
 }
 
+#ifndef CONFIG_VIRTUAL_SWAP
 /*
  * Caller has made sure that the swap device corresponding to entry
  * is still around or has not been recycled.
@@ -1580,9 +1639,11 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
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
@@ -1590,23 +1651,31 @@ void swap_slot_put_folio(swp_slot_t slot, struct folio *folio)
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
@@ -1777,7 +1846,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	 */
 	for (offset = start_offset; offset < end_offset; offset += nr) {
 		nr = 1;
-		if (READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
+		if (swap_cache_only(si, offset)) {
 			/*
 			 * Folios are always naturally aligned in swap so
 			 * advance forward to the next boundary. Zero means no
@@ -1799,6 +1868,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 out:
 	swap_slot_put_swap_info(si);
 }
+#endif /* CONFIG_VIRTUAL_SWAP */
 
 void swap_slot_cache_free_slots(swp_slot_t *slots, int n)
 {
@@ -3558,6 +3628,7 @@ void si_swapinfo(struct sysinfo *val)
 	spin_unlock(&swap_lock);
 }
 
+#ifndef CONFIG_VIRTUAL_SWAP
 /*
  * Verify that nr swap entries are valid and increment their swap map counts.
  *
@@ -3692,6 +3763,7 @@ void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
 
 	cluster_swap_free_nr(si, offset, nr, SWAP_HAS_CACHE);
 }
+#endif  /* CONFIG_VIRTUAL_SWAP */
 
 struct swap_info_struct *swap_slot_swap_info(swp_slot_t slot)
 {
@@ -3714,6 +3786,15 @@ pgoff_t __folio_swap_cache_index(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(__folio_swap_cache_index);
 
+/*
+ * Swap count continuations helpers. Note that we do not use continuation in
+ * virtual swap implementation.
+ */
+#ifdef CONFIG_VIRTUAL_SWAP
+static void free_swap_count_continuations(struct swap_info_struct *si)
+{
+}
+#else
 /*
  * add_swap_count_continuation - called when a swap count is duplicated
  * beyond SWAP_MAP_MAX, it allocates a new page and links that to the entry's
@@ -3936,6 +4017,7 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
 		}
 	}
 }
+#endif
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
 void __folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
diff --git a/mm/vswap.c b/mm/vswap.c
index 3792fa7f766b..1b8cf894390c 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -18,23 +18,55 @@
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
  * Swap descriptor - metadata of a swapped out page.
  *
+ * @vswap: The virtual swap slot of the swap entry.
  * @slot: The handle to the physical swap slot backing this page.
  * @rcu: The RCU head to free the descriptor with an RCU grace period.
+ * @lock: The lock protecting the swap slot backing field.
  * @memcgid: The memcg id of the owning memcg, if any.
+ * @in_swapcache: whether the swapped out page is currently in swap cache.
+ *                This flag is also used to establish the primary owner of
+ *                the swap page in many cases.
+ * @refcnt: The number of references to this swap descriptor. This includes the
+ *          reference from the swap cache (in_swapcache), and references from
+ *          the page table entries (i.e swap_count).
+ * @swap_count: The number of page table entries referring to this swap entry.
  */
 struct swp_desc {
+	swp_entry_t vswap;
 	swp_slot_t slot;
 	struct rcu_head rcu;
+
+	rwlock_t lock;
+
 #ifdef CONFIG_MEMCG
 	atomic_t memcgid;
 #endif
+
+	atomic_t in_swapcache;
+	struct kref refcnt;
+	atomic_t swap_count;
 };
 
 /* Virtual swap space - swp_entry_t -> struct swp_desc */
@@ -129,6 +161,11 @@ static swp_entry_t vswap_alloc(int nr)
 	for (i = 0; i < nr; i++) {
 		descs[i]->slot.val = 0;
 		atomic_set(&descs[i]->memcgid, 0);
+		atomic_set(&descs[i]->swap_count, 0);
+		/* swap entity is about to be added to the swap cache */
+		atomic_set(&descs[i]->in_swapcache, 1);
+		kref_init(&descs[i]->refcnt);
+		rwlock_init(&descs[i]->lock);
 	}
 
 	xa_lock(&vswap_map);
@@ -142,6 +179,7 @@ static swp_entry_t vswap_alloc(int nr)
 			 * allocated virtual swap slot belongs to.
 			 */
 			cluster_id = index >> VSWAP_CLUSTER_SHIFT;
+			descs[0]->vswap.val = index;
 			cluster_entry = xa_load(&vswap_cluster_map, cluster_id);
 			cluster_count = cluster_entry ? xa_to_value(cluster_entry) : 0;
 			cluster_count++;
@@ -171,6 +209,7 @@ static swp_entry_t vswap_alloc(int nr)
 				xa_erase(&vswap_cluster_map, cluster_id);
 				goto unlock;
 			}
+			descs[i]->vswap.val = index + i;
 		}
 	}
 
@@ -215,7 +254,7 @@ static inline void release_vswap_slot(unsigned long index)
  * vswap_free - free a virtual swap slot.
  * @id: the virtual swap slot to free
  */
-void vswap_free(swp_entry_t entry)
+static void vswap_free(swp_entry_t entry)
 {
 	struct swp_desc *desc;
 
@@ -233,6 +272,7 @@ void vswap_free(swp_entry_t entry)
 		/* we only charge after linkage was established */
 		mem_cgroup_uncharge_swap(entry, 1);
 		xa_erase(&vswap_rmap, desc->slot.val);
+		swap_slot_free_nr(desc->slot, 1);
 	}
 
 	/* erase forward mapping and release the virtual slot for reallocation */
@@ -240,6 +280,13 @@ void vswap_free(swp_entry_t entry)
 	kfree_rcu(desc, rcu);
 }
 
+static void vswap_ref_release(struct kref *refcnt)
+{
+	struct swp_desc *desc = container_of(refcnt, struct swp_desc, refcnt);
+
+	vswap_free(desc->vswap);
+}
+
 /**
  * folio_alloc_swap - allocate virtual swap slots for a folio.
  * @folio: the folio.
@@ -332,12 +379,24 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
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
@@ -349,13 +408,342 @@ swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
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
+/**
+ * swap_free_nr_any_cache_only - decrease the swap count of nr contiguous swap
+ *                               entries by 1 (when the swap entries are removed
+ *                               from a range of PTEs), and check if any of the
+ *                               swap entries are in swap cache only after the
+ *                               its swap count is decreased.
+ * @entry: the first entry in the range.
+ * @nr: the number of entries in the range.
+ *
+ * Return: true if any of the swap entries are in swap cache only, or false
+ *         otherwise, after the swap counts are decreased.
+ */
+bool swap_free_nr_any_cache_only(swp_entry_t entry, int nr)
+{
+	struct swp_desc *desc;
+	bool ret = false;
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		if (atomic_read(&desc->swap_count) == 1 &&
+				atomic_read(&desc->in_swapcache))
+			ret = true;
+		atomic_dec(&desc->swap_count);
+		kref_put(&desc->refcnt, vswap_ref_release);
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
+	swap_free_nr_any_cache_only(entry, nr);
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
+		if (!desc || !kref_get_unless_zero(&desc->refcnt))
+			goto done;
+		atomic_inc(&desc->swap_count);
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
+		if (desc && atomic_read(&desc->swap_count)) {
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
+	ret = desc ? atomic_read(&desc->swap_count) : 0;
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
+
+	if (!nr)
+		return;
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		atomic_dec(&desc->in_swapcache);
+		kref_put(&desc->refcnt, vswap_ref_release);
+	}
+	rcu_read_unlock();
+}
+
+int swapcache_prepare(swp_entry_t entry, int nr)
+{
+	struct swp_desc *desc;
+	int i = 0, ret = 0;
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		if (!desc || !kref_get_unless_zero(&desc->refcnt)) {
+			ret = -ENOENT;
+			goto done;
+		}
+
+		if (atomic_cmpxchg(&desc->in_swapcache, 0, 1)) {
+			ret = -EEXIST;
+			kref_put(&desc->refcnt, vswap_ref_release);
+			goto done;
+		}
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
+		if (!desc || atomic_read(&desc->swap_count) ||
+						!atomic_read(&desc->in_swapcache))
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
+	int i = 0;
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
+		if (!atomic_read(&desc->swap_count) ||
+				atomic_read(&desc->in_swapcache))
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
+	if (swap_free_nr_any_cache_only(entry, nr)) {
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


