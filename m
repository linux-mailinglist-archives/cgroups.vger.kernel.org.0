Return-Path: <cgroups+bounces-7928-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF08FAA3CC6
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720574E1FED
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C875E2DCB6E;
	Tue, 29 Apr 2025 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc9cd7oW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A28231841;
	Tue, 29 Apr 2025 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969947; cv=none; b=klwOT3QvLSxLED42mmHx2+3U8fegDpOvhzkIPEQEWfx7ikwV8Uv3jZzklw24XB1bQmtgzM6Lpa5PnLVLy32vY3l1lypyZPTymtZg9orBDZnayckbkhzJxe/wYSEwVz/3zFae7hk/fQV8tLHxdHRUe85VNkdzbixLSKc02b9maY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969947; c=relaxed/simple;
	bh=D+juSeb9xcE/sRXQik3RBgvKgnBuFTBq66GM8WioyWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtUyS9w09Fwm+9G1Skx9a08s/cxPKb869NvVZrpD1zHslZOclAPKuaueOnq4OfzublSYQTm7+euO6jexohrxK6JFNo2XXBCkBLApapo6rsCMj9832mw+EzOXU3WEJQBdBF7lDjtT6QTrFtap08YRqHrGLuxn4P/4Pz+xYAurgsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dc9cd7oW; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-707d3c12574so3207877b3.1;
        Tue, 29 Apr 2025 16:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969944; x=1746574744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJ/RbZZlo/UkCDv1xusfLlmapZEwEXtY5fDz/xwPMAE=;
        b=dc9cd7oW0SQS4KZa3Br5P6gX169mY+UtxLIPiz0bQvRP1Ngy/FPlkbyDJj3NGpXbl4
         XweKWXbw/wNgLqzBJUsZpvnFJNuMaRdbo8piM8fFCH5xO9kZooJz2DHTq/4/SBAcwet9
         Z5o5RVNla9oSD8StoFK15Yd5dSkff1NFMhu7IV72Wu1Gs/EiPnTRE7AG6N935r6whKjp
         sd0cOQIGBKUfalZWMQj5BeDerXe0ByCwHVC3Fq2jEselEQlGOfikLACnwj5ytm6yg0W/
         i6kzAE0uYJkzQD63Ns5LZBJpxasRIRsbyK1oI49iYDAXc/26iVfnxYqtyVgSo1yS8VqF
         dMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969944; x=1746574744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJ/RbZZlo/UkCDv1xusfLlmapZEwEXtY5fDz/xwPMAE=;
        b=NQdGF5BxZse6UlWPX7Ei5/H8VFRfSQIMjOuu8p7Vzi12YhVRgldumMVBfnra/BOaco
         6tyRaHjSNLLBecsARenJwWU1ppLLjBeQ1LprRYawNXrXTPRFDyWSSEmqsxKt2MrXyu8s
         pnqDpmyPiLAtUCu72wuv+28F9PuN37H0CM9dhJDqChX1WsjselXeG1zK6Q8b9auaH0rJ
         ZCOCOtqZlSVO0o5Asv9eRl+y2jaxlrt+9jV12OJSv452v7npHgC2WU2v+5BwNOOMBNwG
         AnvrfJOcDqYY5MZhpCqpQ5+U2ZbdCY53ITA06j53bqEx3wSst7vz3kWOYoyV3/AVWFtq
         y5yg==
X-Forwarded-Encrypted: i=1; AJvYcCU2bPxTW09HYvfGadsyQQwgVnPX+r9zOae6uzocIJTyNjKSOp1dj3hGa/FJIHtLuM3OqGOzKNMf4EYOK941@vger.kernel.org, AJvYcCUNaNMJjtYGfo7zDnSYHI7cO7FFX3a7FkDGMDLjElx7LzpYOTajPI6KE3rrsiqFyXzzg/a/G/VP@vger.kernel.org, AJvYcCXPO7zBYFIJIqVHgTUjZ/u7751CCJR4jYhwF4SDB20TYg7dVpsBXRXw/1EZB4wZKsBODSBRSx4bjG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJACnyMmje75jYYnT7w/Dp9SCDcE4IYkULOGIT4srtSR6lyxL
	Q0J3ekUYRLx/epGRN4eQwI7Xs7rSMvo9xl70Wfl3X58iyWJuoixX
X-Gm-Gg: ASbGncuA6w0pL9kjEWk6eJD9ByLdHNrdv7WApC79rhJbd2G8K7UjWpPjys4dJqbTFM4
	/JhmU2cHvtdTJQfAmk2F9QiuBjSPpIyZTGcO72igYnd7LvGJW6bB0pFXLnJ4tvdVA7p3qcHyBS8
	jw+ggZ6Vz1xiCtSPZdbb70aHMihyPE0tcCDNr3fPV9x2OW4C1dW6oXHuR3wu/X4BPza00YQNu4Y
	eRRYYIruKOOjs/2Ng8TydJdfA+hqbb8xmBBcz8xT+/2Jd9qsWgO7ALmEY7ZEva/AEiShbHmauQr
	KjQmXYz871Aoi0CQ7D5hqa9jMi8wWiZKLhV3u61Srwo=
X-Google-Smtp-Source: AGHT+IEHV428ZSbiu1+j7VMUxhVNZCUuk+j6iHkhzjjso97SHfk0dHLLiY+/9yco0G/qMlrTow3Phg==
X-Received: by 2002:a05:690c:7a1:b0:6ea:8901:dad8 with SMTP id 00721157ae682-708ad07cabamr9860267b3.3.1745969944028;
        Tue, 29 Apr 2025 16:39:04 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708adfc3eadsm768377b3.12.2025.04.29.16.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:39:03 -0700 (PDT)
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
Subject: [RFC PATCH v2 16/18] swap: simplify swapoff using virtual swap
Date: Tue, 29 Apr 2025 16:38:44 -0700
Message-ID: <20250429233848.3093350-17-nphamcs@gmail.com>
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
 mm/swapfile.c            | 127 +++++++++++++++++++++++++++++++++++++++
 mm/vswap.c               |  61 +++++++++++++++++++
 5 files changed, 194 insertions(+)

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
index c5a16f1ca376..0c585103d228 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -774,6 +774,7 @@ void vswap_store_folio(swp_entry_t entry, struct folio *folio);
 void swap_zeromap_folio_set(struct folio *folio);
 void vswap_assoc_zswap(swp_entry_t entry, struct zswap_entry *zswap_entry);
 bool vswap_can_swapin_thp(swp_entry_t entry, int nr);
+void vswap_swapoff(swp_entry_t entry, struct folio *folio, swp_slot_t slot);
 #else /* CONFIG_VIRTUAL_SWAP */
 static inline int vswap_init(void)
 {
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
index 83016d86eb1c..3aa3df10c3be 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2089,6 +2089,132 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 	return i;
 }
 
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
@@ -2479,6 +2605,7 @@ static int try_to_unuse(unsigned int type)
 	smp_mb();
 	return 0;
 }
+#endif /* CONFIG_VIRTUAL_SWAP */
 
 /*
  * After a successful try_to_unuse, if no swap is now in use, we know
diff --git a/mm/vswap.c b/mm/vswap.c
index 4aeb144921b8..35261b5664ee 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -1252,6 +1252,67 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
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


