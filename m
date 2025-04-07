Return-Path: <cgroups+bounces-7416-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 990C8A7F16D
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 01:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097913B6B48
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80EF2309AD;
	Mon,  7 Apr 2025 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHiFXzgT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AA32550B1;
	Mon,  7 Apr 2025 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069357; cv=none; b=NMWOq4WdoyrM4r3ZJTbHwtArGHX20wdSXVqCJUQSUCEAh3VdNjFivilsRqDC3AjinofK3bXaBsWDsMy1oPXC7QggydPp8yRKn18vfYizZsO+qdEVo6FD+VWirz90+3VOLCQLy7WAFpOD6EbBp+/1vJNzrm4RYHfBL6go8yXTxuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069357; c=relaxed/simple;
	bh=/KVO6HxUbvvC18M1Uh6nCHrsy1iVhl8jXcH7rEccGCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JynVjuvAzTR4l3DZLlMXGAv3oiIzLmz1Y7azUWLZYmKgfd+uYNrNwlbNH/DUkGPa96MEYflJWVe7rHcq92iAz7zHukanFVuPHfFmiwgH87h5/b03GrFJ9r1RH8O1jIBKxWJcVb0v+b7699s6qTswisFO53eei1/2Zso2Hb6An2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHiFXzgT; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-703cd93820fso46073667b3.2;
        Mon, 07 Apr 2025 16:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069353; x=1744674153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4vHOJqfqkXMoPP1dZtjw+0/K3krKLrN4KxVkeSTfDE=;
        b=mHiFXzgTSCYW6A7EDErxZonxT84c3NMD3yQ/DH0sYksYhy6Bko1wL9YWvO3cwj0wj1
         kgUq/OCxtkl8Sbc1kvtTQ8HF7KG27xx9up6dSXMMgLzQasqHbRtkM87xhWT2yXmXgEfe
         DJQYErfxWXqeLsFm8ua89XAuWVf0/sbjqRmZEOY831kkp/lNr/8Y/iV+Qlgp0uZUjcmQ
         LgDInaPsWED19RDs2P2hTZptiYpLg6anINKOQyDJPCqGevHAcQCiu5VQ0VEYic2dyZ3y
         6ASMF5yy0NIIpkWipZr3PVRCBNR/Cu6i/VDgnE+8Nx+7/zVPH1MDBYdwVBMRAj1f9Wt5
         USRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069353; x=1744674153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4vHOJqfqkXMoPP1dZtjw+0/K3krKLrN4KxVkeSTfDE=;
        b=bXTFv5EEfQEP5oU4/zxf0elMFZ4YVsqKGaytvN9xLu/drQZbNisjV0OQCisBD1oAi3
         f96QadUsKdfJzpuq5ccG9fBfp0jHnFnTNhzg9qu67pYxGUhSyNRynZ6Tcnuyxrrd9sEY
         ny2CT/WTeOT6ZGJlyhPpNtLRtbOggXQoEXcfFiy+ltR4z+x8BoSMoQmBZGcbgQoOaMMK
         D6HlMnN+nekWQdPsRpuVf9n495IoO4Kak8kDP54Wkf6AjeqQ2qaUu9zSWFT+XlpXeLny
         X2O6Rigwr2bJdI9iFAKoal5kcfmzaBFkAQu2a8UmFRVNAB3IQ0C0aP7nX4YbaQ2cqW09
         g50g==
X-Forwarded-Encrypted: i=1; AJvYcCVl3rxxPune6Ii1TY7sXJDfWoPGBKP5As/OKr9Bigj/ivt1rtQv/gQHuBj5DJ7dSMZxyt2mQx76@vger.kernel.org, AJvYcCW6lo1NkLbJwkap4FVSEUaDxlPWXYw6iMTATbfMJD6Zf/0SE/wvf6nUqJlhrGPVFYYxaRb+MufPq00ZVRfm@vger.kernel.org, AJvYcCXcZjm7Z4c9P5tg4lqx6uSXDXuZ9yXLsMszPgFd0cMmbl+6mFvB2KJTfKUPzJYmkifBqtIkzjZ+O6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyflhac8ac6tPuTppORT/3RrZZj8dvru+LHq/Hlvro3xArZGLQg
	bo4BmulQ3WhyuogdaBbi161NDzGdKoRCYm50nuuNNg9aHCMvlc+D
X-Gm-Gg: ASbGncssQWFZ3dNN47gRvDtL1QzR0jGh9HwSuxwYwrVy/jtFtPiNzDfeDPHa1jYjjfx
	UBX5k3liAqj3J9JeI+MtazAfbtblnABynxVBNrDJeSYnEWjS9+GD21CKSbPv0Hqr7QwEct4F/V2
	9RaPlmMPC/XRglznrGakNevSbI2WVqlovs6MvTx6AIL85/xgAXQHCv+W3pvxv9EgFMfqxNXFZi1
	XGtji1l/PhR6e9JxkiIJg3YwdKXkn2euRbAzkvk4Aj+TPP21rLFMJ48OOShkAdHfeBSLdOLVj5P
	rkKsmvwGbhXaMsp4dTxMaj+98gjRUFh/oYQ=
X-Google-Smtp-Source: AGHT+IHbZnYiY/BuJoWRHHRQ6L5BtEhuC3x+eZrXL9ezJSr88dEBvO1rKsdBYHgZC7piIso+1awHyQ==
X-Received: by 2002:a05:690c:48c5:b0:6fb:9b8c:4b50 with SMTP id 00721157ae682-703e154ea64mr257126007b3.13.1744069353085;
        Mon, 07 Apr 2025 16:42:33 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1e57c4csm27969137b3.49.2025.04.07.16.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:42:32 -0700 (PDT)
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
Subject: [RFC PATCH 13/14] swap: simplify swapoff using virtual swap
Date: Mon,  7 Apr 2025 16:42:14 -0700
Message-ID: <20250407234223.1059191-14-nphamcs@gmail.com>
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

This patch presents the second applications of virtual swap design -
simplifying and optimizing swapoff.

With virtual swap slots stored at page table entries and used as indices
to various swap-related data structures, we no longer have to perform a
page table walk in swapoff. Simply iterate through all the allocated
swap slots on the swapfile, invoke the backward map and fault them in.

This is significantly cleaner, as well as slightly more performant,
especially when there are a lot of unrelated VMAs (since the old swapoff
code would have to traverse through all of them).

In a simple benchmark, in which we swapoff a 32 GB swapfile that is 50%
full, and in which there is a process that maps a 128GB file into
memory:

Baseline:
real: 25.54s
user: 0.00s
sys: 11.48s

New Design:
real: 11.69s
user: 0.00s
sys: 9.96s

Disregarding the real time reduction (which is mostly due to more IO
asynchrony), the new design reduces the kernel CPU time by about 13%.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/shmem_fs.h |   3 +
 include/linux/swap.h     |   1 +
 mm/shmem.c               |   2 +
 mm/swapfile.c            | 189 ++++++++++++++++++++++++++++++++-------
 mm/vswap.c               |  61 +++++++++++++
 5 files changed, 225 insertions(+), 31 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 0b273a7b9f01..668b6add3b8f 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -108,7 +108,10 @@ extern void shmem_unlock_mapping(struct address_space *mapping);
 extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 					pgoff_t index, gfp_t gfp_mask);
 extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
+
+#ifndef CONFIG_VIRTUAL_SWAP
 int shmem_unuse(unsigned int type);
+#endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 unsigned long shmem_allowable_huge_orders(struct inode *inode,
diff --git a/include/linux/swap.h b/include/linux/swap.h
index c3a10c952116..177f6640a026 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -764,6 +764,7 @@ void vswap_store_folio(swp_entry_t entry, struct folio *folio);
 void swap_zeromap_folio_set(struct folio *folio);
 void vswap_assoc_zswap(swp_entry_t entry, struct zswap_entry *zswap_entry);
 bool vswap_can_swapin_thp(swp_entry_t entry, int nr);
+void vswap_swapoff(swp_entry_t entry, struct folio *folio, swp_slot_t slot);
 
 static inline bool trylock_swapoff(swp_entry_t entry,
 				struct swap_info_struct **si)
diff --git a/mm/shmem.c b/mm/shmem.c
index 609971a2b365..fa792769e422 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1380,6 +1380,7 @@ static void shmem_evict_inode(struct inode *inode)
 #endif
 }
 
+#ifndef CONFIG_VIRTUAL_SWAP
 static int shmem_find_swap_entries(struct address_space *mapping,
 				   pgoff_t start, struct folio_batch *fbatch,
 				   pgoff_t *indices, unsigned int type)
@@ -1525,6 +1526,7 @@ int shmem_unuse(unsigned int type)
 
 	return error;
 }
+#endif /* CONFIG_VIRTUAL_SWAP */
 
 /*
  * Move the page from the page cache to the swap cache.
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 59b34d51b16b..d1251a9264fa 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2053,6 +2053,163 @@ unsigned int count_swap_pages(int type, int free)
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
+#ifdef CONFIG_VIRTUAL_SWAP
+#define	for_each_allocated_offset(si, offset)	\
+	while (swap_usage_in_pages(si) && \
+		!signal_pending(current) && \
+		(offset = find_next_to_unuse(si, offset)) != 0)
+
+static struct folio *pagein(swp_entry_t entry, struct swap_iocb **splug,
+		struct mempolicy *mpol)
+{
+	bool folio_was_allocated;
+	struct folio *folio = __read_swap_cache_async(entry, GFP_KERNEL, mpol,
+			NO_INTERLEAVE_INDEX, &folio_was_allocated, false);
+
+	if (folio_was_allocated)
+		swap_read_folio(folio, splug);
+	return folio;
+}
+
+static int try_to_unuse(unsigned int type)
+{
+	struct swap_info_struct *si = swap_info[type];
+	struct swap_iocb *splug = NULL;
+	struct mempolicy *mpol;
+	struct blk_plug plug;
+	unsigned long offset;
+	struct folio *folio;
+	swp_entry_t entry;
+	swp_slot_t slot;
+	int ret = 0;
+
+	if (!atomic_long_read(&si->inuse_pages))
+		goto success;
+
+	mpol = get_task_policy(current);
+	blk_start_plug(&plug);
+
+	/* first round - submit the reads */
+	offset = 0;
+	for_each_allocated_offset(si, offset) {
+		slot = swp_slot(type, offset);
+		entry = swp_slot_to_swp_entry(slot);
+		if (!entry.val)
+			continue;
+
+		folio = pagein(entry, &splug, mpol);
+		if (folio)
+			folio_put(folio);
+	}
+	blk_finish_plug(&plug);
+	swap_read_unplug(splug);
+	lru_add_drain();
+
+	/* second round - updating the virtual swap slots' backing state */
+	offset = 0;
+	for_each_allocated_offset(si, offset) {
+		slot = swp_slot(type, offset);
+retry:
+		entry = swp_slot_to_swp_entry(slot);
+		if (!entry.val)
+			continue;
+
+		/* try to allocate swap cache folio */
+		folio = pagein(entry, &splug, mpol);
+		if (!folio) {
+			if (!swp_slot_to_swp_entry(swp_slot(type, offset)).val)
+				continue;
+
+			ret = -ENOMEM;
+			pr_err("swapoff: unable to allocate swap cache folio for %lu\n",
+						entry.val);
+			goto finish;
+		}
+
+		folio_lock(folio);
+		/*
+		 * We need to check if the folio is still in swap cache. We can, for
+		 * instance, race with zswap writeback, obtaining the temporary folio
+		 * it allocated for decompression and writeback, which would be
+		 * promply deleted from swap cache. By the time we lock that folio,
+		 * it might have already contained stale data.
+		 *
+		 * Concurrent swap operations might have also come in before we
+		 * reobtain the lock, deleting the folio from swap cache, invalidating
+		 * the virtual swap slot, then swapping out the folio again.
+		 *
+		 * In all of these cases, we must retry the physical -> virtual lookup.
+		 *
+		 * Note that if everything is still valid, then virtual swap slot must
+		 * corresponds to the head page (since all previous swap slots are
+		 * freed).
+		 */
+		if (!folio_test_swapcache(folio) || folio->swap.val != entry.val) {
+			folio_unlock(folio);
+			folio_put(folio);
+			if (signal_pending(current))
+				break;
+			schedule_timeout_uninterruptible(1);
+			goto retry;
+		}
+
+		folio_wait_writeback(folio);
+		vswap_swapoff(entry, folio, slot);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
+finish:
+	if (ret == -ENOMEM)
+		return ret;
+
+	/* concurrent swappers might still be releasing physical swap slots... */
+	while (swap_usage_in_pages(si)) {
+		if (signal_pending(current))
+			return -EINTR;
+		schedule_timeout_uninterruptible(1);
+	}
+
+success:
+	/*
+	 * Make sure that further cleanups after try_to_unuse() returns happen
+	 * after swap_range_free() reduces si->inuse_pages to 0.
+	 */
+	smp_mb();
+	return 0;
+}
+#else
 static inline int pte_same_as_swp(pte_t pte, pte_t swp_pte)
 {
 	return pte_same(pte_swp_clear_flags(pte), swp_pte);
@@ -2340,37 +2497,6 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
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
@@ -2474,6 +2600,7 @@ static int try_to_unuse(unsigned int type)
 	smp_mb();
 	return 0;
 }
+#endif /* CONFIG_VIRTUAL_SWAP */
 
 /*
  * After a successful try_to_unuse, if no swap is now in use, we know
diff --git a/mm/vswap.c b/mm/vswap.c
index c09a7efc2aeb..c0da71d5d592 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -1289,6 +1289,67 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	swapcache_clear(NULL, entry, nr);
 }
 
+/**
+ * vswap_swapoff - unlink a range of virtual swap slots from their backing
+ *                 physical swap slots on a swapfile that is being swapped off,
+ *                 and associate them with the swapped in folio.
+ * @entry: the first virtual swap slot in the range.
+ * @folio: the folio swapped in and loaded into swap cache.
+ * @slot: the first physical swap slot in the range.
+ */
+void vswap_swapoff(swp_entry_t entry, struct folio *folio, swp_slot_t slot)
+{
+	int i = 0, nr = folio_nr_pages(folio);
+	struct swp_desc *desc;
+	unsigned int type = swp_slot_type(slot);
+	unsigned int offset = swp_slot_offset(slot);
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		write_lock(&desc->lock);
+		/*
+		 * There might be concurrent swap operations that might invalidate the
+		 * originally obtained virtual swap slot, allowing it to be
+		 * re-allocated, or change its backing state.
+		 *
+		 * We must re-check here to make sure we are not performing bogus backing
+		 * store changes.
+		 */
+		if (desc->type != VSWAP_SWAPFILE ||
+				swp_slot_type(desc->slot) != type) {
+			/* there should not be mixed backing states among the subpages */
+			VM_WARN_ON(i);
+			write_unlock(&desc->lock);
+			break;
+		}
+
+		VM_WARN_ON(swp_slot_offset(desc->slot) != offset + i);
+
+		xa_erase(&vswap_rmap, desc->slot.val);
+		desc->type = VSWAP_FOLIO;
+		desc->folio = folio;
+		write_unlock(&desc->lock);
+		i++;
+	}
+	rcu_read_unlock();
+
+	if (i) {
+		/*
+		 * If we update the virtual swap slots' backing, mark the folio as
+		 * dirty so that reclaimers will try to page it out again.
+		 */
+		folio_mark_dirty(folio);
+		swap_slot_free_nr(slot, nr);
+		/* folio is in swap cache, so entries are guaranteed to be valid */
+		mem_cgroup_uncharge_swap(entry, nr);
+	}
+}
+
 #ifdef CONFIG_MEMCG
 static unsigned short vswap_cgroup_record(swp_entry_t entry,
 				unsigned short memcgid, unsigned int nr_ents)
-- 
2.47.1


