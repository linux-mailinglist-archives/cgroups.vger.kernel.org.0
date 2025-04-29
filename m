Return-Path: <cgroups+bounces-7914-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2259AA3C62
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A389A1D09
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E379B2DDCEB;
	Tue, 29 Apr 2025 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0sg9pwf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5EF2DCB41;
	Tue, 29 Apr 2025 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969934; cv=none; b=XZYsdunsvXFpLClEk50Y/7c2uoh6JaTVNBe/O9d4qsjHIxYDs6MVZyLRcvv5erXvuxNKIJTswa1He8laOrLJ9OQ1mQCs2JA3tNsWpn+EtJKy7OXHVhcXWEuiO6hzasRLR3S1EXyOdRA9gI/RMJkdcGCakbIi4xIzaoLz/PZ+aik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969934; c=relaxed/simple;
	bh=K+fE1tEOojfiAdRs+JtbTz/Ixc47rZypB0NeTTCr0xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrRdMb5nj1TYPJ7IGQNQ+ZYz23iaO53wZPC/P7XhPMLa/CTFuwOo+2jtn+Bcu8hdprdLKZkZb3uebXB6pxokB+agj3fuFXKb3ITVwl3HPzmG1zoFGkMsiRmjT5MNRmHx4OMzs35eds4bDF6wCvYHg40aJe5yaZn4H3ijiH6TCf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0sg9pwf; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fead015247so61557837b3.2;
        Tue, 29 Apr 2025 16:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969931; x=1746574731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKPYMi9z2u+pylu9elX+HeHi2VBZ+HlSHJvjFWP/QJA=;
        b=J0sg9pwfRsJ7csNyKGKLuey8bbgtZ6jtTBZGdBUhYWHS5sJl/AKcfQzwxCYFOM4pdD
         zP+vVIK6q6p93paoXTAbmHfX0R9GiIcNViBGSYjq3kxbPNkoTkqWZqphW0wvFLL8v9Tv
         SMaDVnQfNxFxCaKFwqN6Z66NuoqZhRC7y9ogaa36UTn9+CsVxhjyenq5QmgWC0BqTo4A
         5+hH7ZmtukBVRErBWBGBplA2I1t++0YV24aJjJUQSU+qetuRulh8H2jtp2FypKnMlEmr
         Yb9vCuqLHyt53WGzbQdBGM+cer8Jkmuw4F1L+WeIuSTmK5eNae0k9SwjosrddGu1plr9
         VaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969931; x=1746574731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKPYMi9z2u+pylu9elX+HeHi2VBZ+HlSHJvjFWP/QJA=;
        b=m4AQgoQP0pxtrFMj6XlBoqo8d+CyA8IVkvdjAT9VDKsn40xOQNvuaJZ/7ZZcWXQ1Rc
         0bS3zMXpwkJ3xT2QZt0WSlcm/PUpk1Wdr23JrEg4gZPz4Zb5x4L2h6NXZ0ocJwaPOh2u
         jppYvNgNOixB2fTUlb6dgHCBP4ERV/39dqTCtWi8drut183gN8cDZQXUZ5Ptff0VciaA
         Ubf2W0mZyeYrbprobf0R5FcF4XLhq/HZm2IWqdnLgLuCttyxFIh5SgT3R+Rxb1e+ma/K
         IZINmjHpVLtzsDapfsZORKgeULxSga2DyuDQoY3KvgHhVvdhhA408P3SFhN/241Q9LnL
         7CGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKmkISwj0vGt2IftnRFGlFTCtBeBsVIy1hMSQofqP4JKlVlYjqg04KuT5a8FWpDNP1CEhZBWHu@vger.kernel.org, AJvYcCUzGTIFZkmL2Rm70imC8XYRmf/Zh080j5wFqO7Kk+rhn8mxa7MOR1bvsmJJDcy7uIbwetuOsfjovl0=@vger.kernel.org, AJvYcCVMuDRd5fjyWPtRvE9lsfdcX/C4NNZplJgjbrISFXY9aTdm5KGMuLSwsV/4odbxy3W+0Ul+o7iWUr0BTOCv@vger.kernel.org
X-Gm-Message-State: AOJu0YwiM3wWzxeeaNKU8TeRynAu897CV7SWGC2cWwP6OqjYvMhrF+NX
	GDi1w00HHYgE/LWgM83AvDg6xB0CwE6yMCJNCDCsMRkUEBGuFWj6
X-Gm-Gg: ASbGnculB5siLtFTscp57um30AOLdWtidaC/t/3qVK1plOjQnp5e8hfCG2pGWFmQ5D6
	3lEtLSOJmLLlCu9u7OM2QYiP5Yd46KHLDHVfqDoZpwi1wO1tMM6GRnWBVSV7iKfak8NiqZvHTiD
	hDN0dI4z/k931yoxXdvlGbhq0ANFxOJlsyiGtM9zJ7fOE1BWrfpR0tLS26FRCun95bQ5JDoGbEX
	UoOwYJ8jLWGNMDjjSALAAdC1oAvR2KS1YqLQlBL28YW4c0lcZIMswTsRnJOy0vMztyqEM1w+7u9
	Fzp9yOLv+ZTAdWnTBSMojV0ArVtwKRpX
X-Google-Smtp-Source: AGHT+IEbVsUwWm1vJ8cPgyEKm/U3mnCYlKZjFZzkCwn0NZV9arn5fKzWNi2sdzUswsF0UpfObKyaeA==
X-Received: by 2002:a05:690c:3509:b0:6fb:9429:83c5 with SMTP id 00721157ae682-708ad623882mr10923457b3.19.1745969931462;
        Tue, 29 Apr 2025 16:38:51 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708ae06befesm761997b3.55.2025.04.29.16.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:38:51 -0700 (PDT)
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
Subject: [RFC PATCH v2 02/18] swapfile: rearrange functions
Date: Tue, 29 Apr 2025 16:38:30 -0700
Message-ID: <20250429233848.3093350-3-nphamcs@gmail.com>
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

Rearrange some functions in preparation for the rest of the series. No
functional change intended.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swapfile.c | 332 +++++++++++++++++++++++++-------------------------
 1 file changed, 166 insertions(+), 166 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index df7c4e8b089c..426674d35983 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -124,11 +124,6 @@ static struct swap_info_struct *swap_type_to_swap_info(int type)
 	return READ_ONCE(swap_info[type]); /* rcu_dereference() */
 }
 
-static inline unsigned char swap_count(unsigned char ent)
-{
-	return ent & ~SWAP_HAS_CACHE;	/* may include COUNT_CONTINUED flag */
-}
-
 /*
  * Use the second highest bit of inuse_pages counter as the indicator
  * if one swap device is on the available plist, so the atomic can
@@ -161,6 +156,11 @@ static long swap_usage_in_pages(struct swap_info_struct *si)
 /* Reclaim directly, bypass the slot cache and don't touch device lock */
 #define TTRS_DIRECT		0x8
 
+static inline unsigned char swap_count(unsigned char ent)
+{
+	return ent & ~SWAP_HAS_CACHE;	/* may include COUNT_CONTINUED flag */
+}
+
 static bool swap_is_has_cache(struct swap_info_struct *si,
 			      unsigned long offset, int nr_pages)
 {
@@ -1326,46 +1326,6 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 	return NULL;
 }
 
-static unsigned char __swap_entry_free_locked(struct swap_info_struct *si,
-					      unsigned long offset,
-					      unsigned char usage)
-{
-	unsigned char count;
-	unsigned char has_cache;
-
-	count = si->swap_map[offset];
-
-	has_cache = count & SWAP_HAS_CACHE;
-	count &= ~SWAP_HAS_CACHE;
-
-	if (usage == SWAP_HAS_CACHE) {
-		VM_BUG_ON(!has_cache);
-		has_cache = 0;
-	} else if (count == SWAP_MAP_SHMEM) {
-		/*
-		 * Or we could insist on shmem.c using a special
-		 * swap_shmem_free() and free_shmem_swap_and_cache()...
-		 */
-		count = 0;
-	} else if ((count & ~COUNT_CONTINUED) <= SWAP_MAP_MAX) {
-		if (count == COUNT_CONTINUED) {
-			if (swap_count_continued(si, offset, count))
-				count = SWAP_MAP_MAX | COUNT_CONTINUED;
-			else
-				count = SWAP_MAP_MAX;
-		} else
-			count--;
-	}
-
-	usage = count | has_cache;
-	if (usage)
-		WRITE_ONCE(si->swap_map[offset], usage);
-	else
-		WRITE_ONCE(si->swap_map[offset], SWAP_HAS_CACHE);
-
-	return usage;
-}
-
 /*
  * When we get a swap entry, if there aren't some other ways to
  * prevent swapoff, such as the folio in swap cache is locked, RCU
@@ -1432,6 +1392,46 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	return NULL;
 }
 
+static unsigned char __swap_entry_free_locked(struct swap_info_struct *si,
+					      unsigned long offset,
+					      unsigned char usage)
+{
+	unsigned char count;
+	unsigned char has_cache;
+
+	count = si->swap_map[offset];
+
+	has_cache = count & SWAP_HAS_CACHE;
+	count &= ~SWAP_HAS_CACHE;
+
+	if (usage == SWAP_HAS_CACHE) {
+		VM_BUG_ON(!has_cache);
+		has_cache = 0;
+	} else if (count == SWAP_MAP_SHMEM) {
+		/*
+		 * Or we could insist on shmem.c using a special
+		 * swap_shmem_free() and free_shmem_swap_and_cache()...
+		 */
+		count = 0;
+	} else if ((count & ~COUNT_CONTINUED) <= SWAP_MAP_MAX) {
+		if (count == COUNT_CONTINUED) {
+			if (swap_count_continued(si, offset, count))
+				count = SWAP_MAP_MAX | COUNT_CONTINUED;
+			else
+				count = SWAP_MAP_MAX;
+		} else
+			count--;
+	}
+
+	usage = count | has_cache;
+	if (usage)
+		WRITE_ONCE(si->swap_map[offset], usage);
+	else
+		WRITE_ONCE(si->swap_map[offset], SWAP_HAS_CACHE);
+
+	return usage;
+}
+
 static unsigned char __swap_entry_free(struct swap_info_struct *si,
 				       swp_entry_t entry)
 {
@@ -1585,25 +1585,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	unlock_cluster(ci);
 }
 
-void swapcache_free_entries(swp_entry_t *entries, int n)
-{
-	int i;
-	struct swap_cluster_info *ci;
-	struct swap_info_struct *si = NULL;
-
-	if (n <= 0)
-		return;
-
-	for (i = 0; i < n; ++i) {
-		si = _swap_info_get(entries[i]);
-		if (si) {
-			ci = lock_cluster(si, swp_offset(entries[i]));
-			swap_entry_range_free(si, ci, entries[i], 1);
-			unlock_cluster(ci);
-		}
-	}
-}
-
 int __swap_count(swp_entry_t entry)
 {
 	struct swap_info_struct *si = swp_swap_info(entry);
@@ -1717,57 +1698,6 @@ static bool folio_swapped(struct folio *folio)
 	return swap_page_trans_huge_swapped(si, entry, folio_order(folio));
 }
 
-static bool folio_swapcache_freeable(struct folio *folio)
-{
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-
-	if (!folio_test_swapcache(folio))
-		return false;
-	if (folio_test_writeback(folio))
-		return false;
-
-	/*
-	 * Once hibernation has begun to create its image of memory,
-	 * there's a danger that one of the calls to folio_free_swap()
-	 * - most probably a call from __try_to_reclaim_swap() while
-	 * hibernation is allocating its own swap pages for the image,
-	 * but conceivably even a call from memory reclaim - will free
-	 * the swap from a folio which has already been recorded in the
-	 * image as a clean swapcache folio, and then reuse its swap for
-	 * another page of the image.  On waking from hibernation, the
-	 * original folio might be freed under memory pressure, then
-	 * later read back in from swap, now with the wrong data.
-	 *
-	 * Hibernation suspends storage while it is writing the image
-	 * to disk so check that here.
-	 */
-	if (pm_suspended_storage())
-		return false;
-
-	return true;
-}
-
-/**
- * folio_free_swap() - Free the swap space used for this folio.
- * @folio: The folio to remove.
- *
- * If swap is getting full, or if there are no more mappings of this folio,
- * then call folio_free_swap to free its swap space.
- *
- * Return: true if we were able to release the swap space.
- */
-bool folio_free_swap(struct folio *folio)
-{
-	if (!folio_swapcache_freeable(folio))
-		return false;
-	if (folio_swapped(folio))
-		return false;
-
-	delete_from_swap_cache(folio);
-	folio_set_dirty(folio);
-	return true;
-}
-
 /**
  * free_swap_and_cache_nr() - Release reference on range of swap entries and
  *                            reclaim their cache if no more references remain.
@@ -1842,6 +1772,76 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	put_swap_device(si);
 }
 
+void swapcache_free_entries(swp_entry_t *entries, int n)
+{
+	int i;
+	struct swap_cluster_info *ci;
+	struct swap_info_struct *si = NULL;
+
+	if (n <= 0)
+		return;
+
+	for (i = 0; i < n; ++i) {
+		si = _swap_info_get(entries[i]);
+		if (si) {
+			ci = lock_cluster(si, swp_offset(entries[i]));
+			swap_entry_range_free(si, ci, entries[i], 1);
+			unlock_cluster(ci);
+		}
+	}
+}
+
+static bool folio_swapcache_freeable(struct folio *folio)
+{
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
+	if (!folio_test_swapcache(folio))
+		return false;
+	if (folio_test_writeback(folio))
+		return false;
+
+	/*
+	 * Once hibernation has begun to create its image of memory,
+	 * there's a danger that one of the calls to folio_free_swap()
+	 * - most probably a call from __try_to_reclaim_swap() while
+	 * hibernation is allocating its own swap pages for the image,
+	 * but conceivably even a call from memory reclaim - will free
+	 * the swap from a folio which has already been recorded in the
+	 * image as a clean swapcache folio, and then reuse its swap for
+	 * another page of the image.  On waking from hibernation, the
+	 * original folio might be freed under memory pressure, then
+	 * later read back in from swap, now with the wrong data.
+	 *
+	 * Hibernation suspends storage while it is writing the image
+	 * to disk so check that here.
+	 */
+	if (pm_suspended_storage())
+		return false;
+
+	return true;
+}
+
+/**
+ * folio_free_swap() - Free the swap space used for this folio.
+ * @folio: The folio to remove.
+ *
+ * If swap is getting full, or if there are no more mappings of this folio,
+ * then call folio_free_swap to free its swap space.
+ *
+ * Return: true if we were able to release the swap space.
+ */
+bool folio_free_swap(struct folio *folio)
+{
+	if (!folio_swapcache_freeable(folio))
+		return false;
+	if (folio_swapped(folio))
+		return false;
+
+	delete_from_swap_cache(folio);
+	folio_set_dirty(folio);
+	return true;
+}
+
 #ifdef CONFIG_HIBERNATION
 
 swp_entry_t get_swap_page_of_type(int type)
@@ -1957,6 +1957,37 @@ unsigned int count_swap_pages(int type, int free)
 }
 #endif /* CONFIG_HIBERNATION */
 
+/*
+ * Scan swap_map from current position to next entry still in use.
+ * Return 0 if there are no inuse entries after prev till end of
+ * the map.
+ */
+static unsigned int find_next_to_unuse(struct swap_info_struct *si,
+					unsigned int prev)
+{
+	unsigned int i;
+	unsigned char count;
+
+	/*
+	 * No need for swap_lock here: we're just looking
+	 * for whether an entry is in use, not modifying it; false
+	 * hits are okay, and sys_swapoff() has already prevented new
+	 * allocations from this area (while holding swap_lock).
+	 */
+	for (i = prev + 1; i < si->max; i++) {
+		count = READ_ONCE(si->swap_map[i]);
+		if (count && swap_count(count) != SWAP_MAP_BAD)
+			break;
+		if ((i % LATENCY_LIMIT) == 0)
+			cond_resched();
+	}
+
+	if (i == si->max)
+		i = 0;
+
+	return i;
+}
+
 static inline int pte_same_as_swp(pte_t pte, pte_t swp_pte)
 {
 	return pte_same(pte_swp_clear_flags(pte), swp_pte);
@@ -2241,37 +2272,6 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
 	return ret;
 }
 
-/*
- * Scan swap_map from current position to next entry still in use.
- * Return 0 if there are no inuse entries after prev till end of
- * the map.
- */
-static unsigned int find_next_to_unuse(struct swap_info_struct *si,
-					unsigned int prev)
-{
-	unsigned int i;
-	unsigned char count;
-
-	/*
-	 * No need for swap_lock here: we're just looking
-	 * for whether an entry is in use, not modifying it; false
-	 * hits are okay, and sys_swapoff() has already prevented new
-	 * allocations from this area (while holding swap_lock).
-	 */
-	for (i = prev + 1; i < si->max; i++) {
-		count = READ_ONCE(si->swap_map[i]);
-		if (count && swap_count(count) != SWAP_MAP_BAD)
-			break;
-		if ((i % LATENCY_LIMIT) == 0)
-			cond_resched();
-	}
-
-	if (i == si->max)
-		i = 0;
-
-	return i;
-}
-
 static int try_to_unuse(unsigned int type)
 {
 	struct mm_struct *prev_mm;
@@ -3525,6 +3525,26 @@ void si_swapinfo(struct sysinfo *val)
 	spin_unlock(&swap_lock);
 }
 
+struct swap_info_struct *swp_swap_info(swp_entry_t entry)
+{
+	return swap_type_to_swap_info(swp_type(entry));
+}
+
+/*
+ * out-of-line methods to avoid include hell.
+ */
+struct address_space *swapcache_mapping(struct folio *folio)
+{
+	return swp_swap_info(folio->swap)->swap_file->f_mapping;
+}
+EXPORT_SYMBOL_GPL(swapcache_mapping);
+
+pgoff_t __folio_swap_cache_index(struct folio *folio)
+{
+	return swap_cache_index(folio->swap);
+}
+EXPORT_SYMBOL_GPL(__folio_swap_cache_index);
+
 /*
  * Verify that nr swap entries are valid and increment their swap map counts.
  *
@@ -3658,26 +3678,6 @@ void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
 	cluster_swap_free_nr(si, offset, nr, SWAP_HAS_CACHE);
 }
 
-struct swap_info_struct *swp_swap_info(swp_entry_t entry)
-{
-	return swap_type_to_swap_info(swp_type(entry));
-}
-
-/*
- * out-of-line methods to avoid include hell.
- */
-struct address_space *swapcache_mapping(struct folio *folio)
-{
-	return swp_swap_info(folio->swap)->swap_file->f_mapping;
-}
-EXPORT_SYMBOL_GPL(swapcache_mapping);
-
-pgoff_t __folio_swap_cache_index(struct folio *folio)
-{
-	return swap_cache_index(folio->swap);
-}
-EXPORT_SYMBOL_GPL(__folio_swap_cache_index);
-
 /*
  * add_swap_count_continuation - called when a swap count is duplicated
  * beyond SWAP_MAP_MAX, it allocates a new page and links that to the entry's
-- 
2.47.1


