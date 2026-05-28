Return-Path: <cgroups+bounces-16405-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJdRMj20GGr9mAgAu9opvQ
	(envelope-from <cgroups+bounces-16405-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 23:31:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B06E5FA71D
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 23:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D9AF30AA74D
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 21:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5B35F5F3;
	Thu, 28 May 2026 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpWarCxU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDBD35E1A7
	for <cgroups@vger.kernel.org>; Thu, 28 May 2026 21:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003809; cv=none; b=YuhRojNTWUGW+Z9a4tOp94VrlfufGO4RaO2IrOTOpEhyIvd9xC14kX2dJAm3NA/vIC7y8USFOaCHOLzqfLX7Aw4f77CbKencvZ7wUjc1pWhRFTZmU/kFB0OLAYUWpdH8RxMkk+BuvA0FrOEyeG6ODlOG52kNYlOiqoicW+6kIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003809; c=relaxed/simple;
	bh=ijtfpGhvoQRsJnoGRa0oEXn+l26zwg/AT4EH+qzD3I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPq+n3WllySwCuPx6nucOfsmUDrzF5cAScrvHAcpTijMUDIJkaGLxknVgW5W6foA9xoRepSZyT/Xf6LOjQJOfyooeGHt2pnHtaeHiwi4BxQTxfJac42BCAeWnIc9Uhq6MZqpy8xdrBxeLmnEsw/Vq8bhLxBIRp90ed7B70gH4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpWarCxU; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-485433a6889so2280792b6e.0
        for <cgroups@vger.kernel.org>; Thu, 28 May 2026 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780003801; x=1780608601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+w7YHMnEfkdAU/3dh9LHpeWm/MSowGtlw156d5IW3s=;
        b=LpWarCxUmkviAqjcPJDI0LnJz0NdiJm+NYTEFPJYPzxNSDWQYQDRLBz2ohaDsX4yhu
         jVjMxGZLbGqPrdNr86if+fidKGLkORuv+VkVfNDNVOD5SG4b0j36nxznpm7Ie47qHacK
         wwsYvq14NoipoDpV9Vbm5zq8aYG8akli46PbWNHUa+JTCkz8pjUYhMF2M79ngwbsgj6v
         jM0hunMyplQQZcWl+bPlTksDe3OgLZg88oE0p0s7Eo39lR+/yTC4WL5DbKv49NuFPlNz
         B3snQeREFIYYEhbf44TJAlOgHmrFPBSoohQ7R4ZdcKdbw1793vP/u0CXJTbnJFpOTA16
         idUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003801; x=1780608601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q+w7YHMnEfkdAU/3dh9LHpeWm/MSowGtlw156d5IW3s=;
        b=EesHwOmnNBLAcDIIM3KukGendodR79OJzeYgufB8nDcxP8HCTZeqMl+tsnr0Oo39l/
         E3P7OsROqgPTJFeeKGaF4/UvvehsgDo8+g121q/f6sxIO0uzuEkrBjiIEITinX0M+GPf
         /zYwgZphySDvb6JfRY0yfitOe7jAoFvy7CiKThHvbIU2YFC2O8bZ10xpLkhEDaw/5kcy
         DRpEdmyWndG/hzT8erSbqLE2+gDLToZfuXY7msC0HhnK/vMyrxVWp83YMiSReERm/XYa
         QXXAkUhnfTS2NM7/pM6LJO8XRYnxoNXdc5NlDxpD3T8a2qIc/AqRzQ0t6doFrc/P0LK7
         cTUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bUhO3PAeoijFE1jE+b4Io5zs5ttDXtl4UWAXd+xuFHAfqnJBNuizS3DfE8/K8G2NDd/8O17V5@vger.kernel.org
X-Gm-Message-State: AOJu0YycDdXyRKKXNR+o+EoDWVIihr3/2DTm4w4H5tM96/J65tWHcqiG
	5X7/cpLJh1eCrj/eWx7gDnh/O4O4HF7LzA/8dsZZ9RQJKDCGzNbS8Dsb
X-Gm-Gg: Acq92OG1AbTSqXMEi70sP1vMa8ywjxdlcjE83i4Qx9m+QN19AtKjCIQUlYSplZ5VZUv
	JT+gaZLpCBh9jDRaUspxTX4FdROCkzxHJExCrKO2lUmlnBdpaZVs4UAGNlGHKUxz+S2Dd07w307
	wt8NXz8JdpyzK6oo07dH0aBnwj1VnKrxlWbpJdZyGaywUaQ6QYp7cNszTqgUre+MN1csPI4wKqF
	rmfhgjYcCHo8Y2sOtNOBoH3Kvbnli0ylQV6KzhVk02jXzjV1mmG6/bSHK5q9bid00GcqiYmLV8t
	AhUOdDvEJLr2V0uXOlf4bZ/Wa8BLEomg13CNWkt6LCvZv2dwzliOVVHxUOl6ujbrjMG1nGoo2VQ
	nXjf1Ga87JJA8MUCWin7wL69I1JSZSyMkYgIBeWJtvna2bJwrfvyA8p88rDBy1sMZi7IWm9lY8F
	PUMv+EIzeGqQBsXINZ24ICBCBHFuhc2ZIVmPKi8Erw+pJvmWVRqypdR68=
X-Received: by 2002:a05:6808:c40b:b0:479:ed26:fbc9 with SMTP id 5614622812f47-485e6c32c4bmr187637b6e.32.1780003800998;
        Thu, 28 May 2026 14:30:00 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48554538d1bsm9781024b6e.8.2026.05.28.14.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:29:59 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: kasong@tencent.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	nphamcs@gmail.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	kernel-team@meta.com,
	riel@surriel.com,
	haowenchao22@gmail.com
Subject: [RFC PATCH 2/5] mm, swap: support zswap and zeroswap as vswap backends
Date: Thu, 28 May 2026 14:29:26 -0700
Message-ID: <20260528212955.1912856-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528212955.1912856-1-nphamcs@gmail.com>
References: <20260528212955.1912856-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TAGGED_FROM(0.00)[bounces-16405-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[55];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 6B06E5FA71D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Build the virtual swap layer on top of the swap-table infrastructure.
Virtual swap entries decouple PTE swap entries from physical backing,
allowing pages to be compressed by zswap (or detected as zero-filled)
without pre-allocating a physical swap slot.

This patch only supports zswap and zero-page backends. If zswap_store
fails, the page stays dirty in the swap cache (AOP_WRITEPAGE_ACTIVATE)
— physical disk backing fallback comes in the next patch. Zswap
writeback of vswap-backed entries is also disabled — the shrinker
skips when no physical swap pages are available.

Suggested-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/zswap.h |   3 +
 mm/internal.h         |  20 ++-
 mm/madvise.c          |   2 +-
 mm/memcontrol.c       |   8 +-
 mm/memory.c           |  20 ++-
 mm/page_io.c          |  61 +++++--
 mm/swap.h             |   4 +-
 mm/swap_state.c       |   8 +
 mm/swap_table.h       |  53 ++++++
 mm/swapfile.c         | 375 +++++++++++++++++++++++++++++++++---------
 mm/vmscan.c           |   5 +-
 mm/vswap.h            | 292 +++++++++++++++++++++++++++++++-
 mm/zswap.c            | 106 +++++++-----
 13 files changed, 807 insertions(+), 150 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 30c193a1207e..4b4f211f3301 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -6,6 +6,7 @@
 #include <linux/mm_types.h>
 
 struct lruvec;
+struct zswap_entry;
 
 extern atomic_long_t zswap_stored_pages;
 
@@ -28,6 +29,7 @@ unsigned long zswap_total_pages(void);
 bool zswap_store(struct folio *folio);
 int zswap_load(struct folio *folio);
 void zswap_invalidate(swp_entry_t swp);
+void zswap_entry_free(struct zswap_entry *entry);
 int zswap_swapon(int type, unsigned long nr_pages);
 void zswap_swapoff(int type);
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
@@ -50,6 +52,7 @@ static inline int zswap_load(struct folio *folio)
 }
 
 static inline void zswap_invalidate(swp_entry_t swp) {}
+static inline void zswap_entry_free(struct zswap_entry *entry) {}
 static inline int zswap_swapon(int type, unsigned long nr_pages)
 {
 	return 0;
diff --git a/mm/internal.h b/mm/internal.h
index 7646ecb9d621..23ea4c8172df 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -16,6 +16,7 @@
 #include <linux/pagewalk.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
+#include "vswap.h"
 #include <linux/leafops.h>
 #include <linux/tracepoint-defs.h>
 
@@ -436,6 +437,9 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
  * @start_ptep: Page table pointer for the first entry.
  * @max_nr: The maximum number of table entries to consider.
  * @pte: Page table entry for the first entry.
+ * @free_batch: True when the batch is for a free path. Skips the
+ *              vswap uniform-backing check (which is only relevant
+ *              for swapin batches).
  *
  * Detect a batch of contiguous swap entries: consecutive (non-present) PTEs
  * containing swap entries all with consecutive offsets and targeting the same
@@ -446,11 +450,14 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
  *
  * Return: the number of table entries in the batch.
  */
-static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
+static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte,
+				 bool free_batch)
 {
 	pte_t expected_pte = pte_next_swp_offset(pte);
 	const pte_t *end_ptep = start_ptep + max_nr;
 	pte_t *ptep = start_ptep + 1;
+	swp_entry_t entry __maybe_unused;
+	int nr;
 
 	VM_WARN_ON(max_nr < 1);
 	VM_WARN_ON(!softleaf_is_swap(softleaf_from_pte(pte)));
@@ -464,7 +471,16 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 		ptep++;
 	}
 
-	return ptep - start_ptep;
+	nr = ptep - start_ptep;
+#ifdef CONFIG_VSWAP
+	if (!free_batch) {
+		entry = softleaf_from_pte(ptep_get(start_ptep));
+		if (nr > 1 && swap_is_vswap(__swap_entry_to_info(entry)) &&
+		    !vswap_can_swapin_thp(entry, nr))
+			return 1;
+	}
+#endif
+	return nr;
 }
 #endif /* CONFIG_MMU */
 
diff --git a/mm/madvise.c b/mm/madvise.c
index cd9bb077072c..75ec10fbd61a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -692,7 +692,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 
 			if (softleaf_is_swap(entry)) {
 				max_nr = (end - addr) / PAGE_SIZE;
-				nr = swap_pte_batch(pte, max_nr, ptent);
+				nr = swap_pte_batch(pte, max_nr, ptent, true);
 				nr_swap -= nr;
 				swap_put_entries_direct(entry, nr);
 				clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 039e9bc8971c..a3ad83c229f7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -48,6 +48,7 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
 #include <linux/swapops.h>
+#include <linux/zswap.h>
 #include <linux/spinlock.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
@@ -5538,8 +5539,13 @@ void __mem_cgroup_uncharge_swap(unsigned short id, unsigned int nr_pages)
 
 long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
-	long nr_swap_pages = get_nr_swap_pages();
+	long nr_swap_pages;
 
+	/* vswap provides unbounded virtual swap when zswap is enabled */
+	if (IS_ENABLED(CONFIG_VSWAP) && zswap_is_enabled())
+		return PAGE_COUNTER_MAX;
+
+	nr_swap_pages = get_nr_swap_pages();
 	if (mem_cgroup_disabled() || do_memsw_account())
 		return nr_swap_pages;
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
diff --git a/mm/memory.c b/mm/memory.c
index 7c020995eafc..c3050e49b086 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1764,7 +1764,7 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		if (!should_zap_cows(details))
 			return 1;
 
-		nr = swap_pte_batch(pte, max_nr, ptent);
+		nr = swap_pte_batch(pte, max_nr, ptent, true);
 		rss[MM_SWAPENTS] -= nr;
 		swap_put_entries_direct(entry, nr);
 	} else if (softleaf_is_migration(entry)) {
@@ -4630,7 +4630,7 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 	 * from different backends. And they are likely corner cases. Similar
 	 * things might be added once zswap support large folios.
 	 */
-	if (swap_pte_batch(ptep, nr_pages, pte) != nr_pages)
+	if (swap_pte_batch(ptep, nr_pages, pte, false) != nr_pages)
 		return false;
 	return true;
 }
@@ -4675,15 +4675,19 @@ static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
 	if (unlikely(userfaultfd_armed(vma)))
 		return 0;
 
+	entry = softleaf_from_pte(vmf->orig_pte);
+
 	/*
-	 * A large swapped out folio could be partially or fully in zswap. We
-	 * lack handling for such cases, so fallback to swapping in order-0
-	 * folio.
+	 * A large swapped out folio could be partially or fully in zswap.
+	 * With vswap, vswap_can_swapin_thp() (via swap_pte_batch) lets
+	 * THP swapin through only for backings that don't need per-page
+	 * decompression. For non-vswap entries we still need the
+	 * zswap_never_enabled() bail — zswap_load rejects large folios
+	 * with -EINVAL, which would SIGBUS the fault.
 	 */
-	if (!zswap_never_enabled())
+	if (!swap_is_vswap(__swap_entry_to_info(entry)) && !zswap_never_enabled())
 		return 0;
 
-	entry = softleaf_from_pte(vmf->orig_pte);
 	/*
 	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
 	 * and suitable for swapping THP.
@@ -4942,7 +4946,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_ptep = vmf->pte - idx;
 		folio_pte = ptep_get(folio_ptep);
 		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
-		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
+		    swap_pte_batch(folio_ptep, nr, folio_pte, false) != nr)
 			goto check_folio;
 
 		page_idx = idx;
diff --git a/mm/page_io.c b/mm/page_io.c
index 8126be6e4cfb..b3c7e56c8eed 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -27,6 +27,7 @@
 #include <linux/zswap.h>
 #include "swap.h"
 #include "swap_table.h"
+#include "vswap.h"
 
 static void __end_swap_bio_write(struct bio *bio)
 {
@@ -204,19 +205,28 @@ static bool is_folio_zero_filled(struct folio *folio)
 
 static void swap_zeromap_folio_set(struct folio *folio)
 {
+	struct swap_info_struct *si = __swap_entry_to_info(folio->swap);
 	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
 	int nr_pages = folio_nr_pages(folio);
 	struct swap_cluster_info *ci;
+	unsigned int voff, i;
 	swp_entry_t entry;
-	unsigned int i;
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 
 	ci = swap_cluster_get_and_lock(folio);
-	for (i = 0; i < folio_nr_pages(folio); i++) {
-		entry = page_swap_entry(folio_page(folio, i));
-		__swap_table_set_zero(ci, swp_cluster_offset(entry));
+	if (swap_is_vswap(si)) {
+		voff = swp_cluster_offset(folio->swap);
+		/* Free any prior backing (e.g. ZSWAP entry from earlier swapout) */
+		vswap_release_backing(ci, voff, nr_pages);
+		for (i = 0; i < nr_pages; i++)
+			vswap_set_zero(ci, voff + i);
+	} else {
+		for (i = 0; i < nr_pages; i++) {
+			entry = page_swap_entry(folio_page(folio, i));
+			__swap_table_set_zero(ci, swp_cluster_offset(entry));
+		}
 	}
 	swap_cluster_unlock(ci);
 
@@ -282,6 +292,9 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 	 */
 	swap_zeromap_folio_clear(folio);
 
+	if (swap_is_vswap(__swap_entry_to_info(folio->swap)))
+		vswap_prepare_writeout(folio->swap, folio);
+
 	if (zswap_store(folio)) {
 		count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
 		goto out_unlock;
@@ -295,6 +308,11 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 	}
 	rcu_read_unlock();
 
+	if (swap_is_vswap(__swap_entry_to_info(folio->swap))) {
+		folio_mark_dirty(folio);
+		return AOP_WRITEPAGE_ACTIVATE;
+	}
+
 	return __swap_writepage(folio, swap_plug);
 out_unlock:
 	folio_unlock(folio);
@@ -537,23 +555,40 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 static int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 			      bool *is_zerop)
 {
-	int i;
-	bool is_zero;
-	unsigned int ci_start = swp_cluster_offset(entry);
+	struct swap_info_struct *si = __swap_entry_to_info(entry);
 	struct swap_cluster_info *ci = __swap_entry_to_cluster(entry);
+	unsigned int ci_start = swp_cluster_offset(entry), ci_off, ci_end;
+	bool is_zero;
 
 	VM_WARN_ON_ONCE(ci_start + max_nr > SWAPFILE_CLUSTER);
 
+	ci_off = ci_start;
+	ci_end = ci_off + max_nr;
+
+	if (swap_is_vswap(si)) {
+		spin_lock(&ci->lock);
+		is_zero = vswap_test_zero(ci, ci_off);
+		if (is_zerop)
+			*is_zerop = is_zero;
+		while (++ci_off < ci_end) {
+			if (is_zero != vswap_test_zero(ci, ci_off))
+				break;
+		}
+		spin_unlock(&ci->lock);
+		return ci_off - ci_start;
+	}
+
 	rcu_read_lock();
-	is_zero = __swap_table_test_zero(ci, ci_start);
-	for (i = 1; i < max_nr; i++)
-		if (is_zero != __swap_table_test_zero(ci, ci_start + i))
-			break;
-	rcu_read_unlock();
+	is_zero = __swap_table_test_zero(ci, ci_off);
 	if (is_zerop)
 		*is_zerop = is_zero;
+	while (++ci_off < ci_end) {
+		if (is_zero != __swap_table_test_zero(ci, ci_off))
+			break;
+	}
+	rcu_read_unlock();
 
-	return i;
+	return ci_off - ci_start;
 }
 
 static bool swap_read_folio_zeromap(struct folio *folio)
diff --git a/mm/swap.h b/mm/swap.h
index 479ee5871cb9..640413e30880 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -69,7 +69,9 @@ struct swap_cluster_info_dynamic {
 	struct swap_cluster_info ci;	/* Underlying cluster info */
 	unsigned int index;		/* for cluster_index() */
 	struct rcu_head rcu;		/* For kfree_rcu deferred free */
-	/* Backend pointers (virtual_table) added in a later patch. */
+#ifdef CONFIG_VSWAP
+	atomic_long_t *virtual_table;	/* Backing pointers for vswap slots */
+#endif
 };
 
 /* All on-list cluster must have a non-zero flag. */
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b063c47138c5..6bfa185b7d0f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -25,6 +25,7 @@
 #include "internal.h"
 #include "swap_table.h"
 #include "swap.h"
+#include "vswap.h"
 
 /*
  * swapper_space is a fiction, retained to simplify the path through
@@ -692,6 +693,13 @@ struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp, unsigned long orders,
 	if (IS_ERR(folio))
 		return folio;
 
+	if (folio_test_large(folio) && swap_is_vswap(__swap_entry_to_info(folio->swap)) &&
+	    !vswap_can_swapin_thp(folio->swap, folio_nr_pages(folio))) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return NULL;
+	}
+
 	swap_read_folio(folio, NULL);
 	return folio;
 }
diff --git a/mm/swap_table.h b/mm/swap_table.h
index fd7f0fb9836a..b0e7ef9c966b 100644
--- a/mm/swap_table.h
+++ b/mm/swap_table.h
@@ -6,6 +6,8 @@
 #include <linux/atomic.h>
 #include "swap.h"
 
+struct zswap_entry;
+
 /* A typical flat array in each cluster as swap table */
 struct swap_table {
 	atomic_long_t entries[SWAPFILE_CLUSTER];
@@ -368,4 +370,55 @@ static inline unsigned short __swap_cgroup_clear(struct swap_cluster_info *ci,
 }
 #endif
 
+/*
+ * Pointer-tagged swap table entry: rmap for vswap-backing physical slots.
+ *
+ * On physical clusters, a Pointer-tagged entry stores the vswap entry
+ * that owns this physical slot (the reverse map). The top bit is reserved
+ * as a cache-only flag, set when vswap swap_count drops to 0 but the
+ * folio is still in swap cache.
+ *
+ *   Pointer:  |C|--- vswap entry ---|100|
+ *             C = SWP_RMAP_CACHE_ONLY (bit 63)
+ */
+#ifdef CONFIG_VSWAP
+#define SWP_TB_PTR_MARK		0b100UL
+#define SWP_TB_PTR_MARK_MASK	0b111UL
+#define SWP_RMAP_CACHE_ONLY	(1UL << (BITS_PER_LONG - 1))
+#define SWP_RMAP_ENTRY_MASK	(~(SWP_RMAP_CACHE_ONLY | SWP_TB_PTR_MARK_MASK))
+
+static inline bool swp_tb_is_pointer(unsigned long swp_tb)
+{
+	return (swp_tb & SWP_TB_PTR_MARK_MASK) == SWP_TB_PTR_MARK;
+}
+
+static inline unsigned long swp_entry_to_swp_tb_ptr(swp_entry_t entry)
+{
+	return (entry.val << 3) | SWP_TB_PTR_MARK;
+}
+
+static inline swp_entry_t swp_tb_ptr_to_swp_entry(unsigned long swp_tb)
+{
+	swp_entry_t entry;
+
+	VM_WARN_ON(!swp_tb_is_pointer(swp_tb));
+	entry.val = (swp_tb & SWP_RMAP_ENTRY_MASK) >> 3;
+	return entry;
+}
+#else
+static inline bool swp_tb_is_pointer(unsigned long swp_tb)
+{
+	return false;
+}
+static inline unsigned long swp_entry_to_swp_tb_ptr(swp_entry_t entry)
+{
+	return 0;
+}
+static inline swp_entry_t swp_tb_ptr_to_swp_entry(unsigned long swp_tb)
+{
+	return (swp_entry_t){};
+}
+
+#endif /* CONFIG_VSWAP */
+
 #endif
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f6d2529159ff..c90d83fd628a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -131,6 +131,26 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
 	.lock = INIT_LOCAL_LOCK(),
 };
 
+#ifdef CONFIG_VSWAP
+struct percpu_vswap_cluster {
+	unsigned long offset[SWAP_NR_ORDERS];
+	local_lock_t lock;
+};
+
+static DEFINE_PER_CPU(struct percpu_vswap_cluster, percpu_vswap_cluster) = {
+	.offset = { [0 ... SWAP_NR_ORDERS - 1] = SWAP_ENTRY_INVALID },
+	.lock = INIT_LOCAL_LOCK(),
+};
+
+static bool vswap_alloc(struct folio *folio);
+static void vswap_free_cluster(struct swap_info_struct *si,
+			       struct swap_cluster_info *ci);
+#else
+static inline bool vswap_alloc(struct folio *folio) { return false; }
+static inline void vswap_free_cluster(struct swap_info_struct *si,
+				      struct swap_cluster_info *ci) {}
+#endif
+
 /* May return NULL on invalid type, caller must check for NULL return */
 static struct swap_info_struct *swap_type_to_info(int type)
 {
@@ -538,8 +558,14 @@ swap_cluster_populate(struct swap_info_struct *si,
 	 * Only cluster isolation from the allocator does table allocation.
 	 * Swap allocator uses percpu clusters and holds the local lock.
 	 */
-	lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
-	if (!(si->flags & SWP_SOLIDSTATE))
+#ifdef CONFIG_VSWAP
+	if (swap_is_vswap(si))
+		lockdep_assert_held(&this_cpu_ptr(&percpu_vswap_cluster)->lock);
+	else
+#endif
+	if (si->flags & SWP_SOLIDSTATE)
+		lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
+	else
 		lockdep_assert_held(&si->global_cluster_lock);
 	lockdep_assert_held(&ci->lock);
 
@@ -555,7 +581,12 @@ swap_cluster_populate(struct swap_info_struct *si,
 	spin_unlock(&ci->lock);
 	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_unlock(&si->global_cluster_lock);
-	local_unlock(&percpu_swap_cluster.lock);
+#ifdef CONFIG_VSWAP
+	if (swap_is_vswap(si))
+		local_unlock(&percpu_vswap_cluster.lock);
+	else
+#endif
+		local_unlock(&percpu_swap_cluster.lock);
 
 	ret = swap_cluster_alloc_table(ci, __GFP_HIGH | __GFP_NOMEMALLOC |
 					   GFP_KERNEL);
@@ -568,7 +599,12 @@ swap_cluster_populate(struct swap_info_struct *si,
 	 * could happen with ignoring the percpu cluster is fragmentation,
 	 * which is acceptable since this fallback and race is rare.
 	 */
-	local_lock(&percpu_swap_cluster.lock);
+#ifdef CONFIG_VSWAP
+	if (swap_is_vswap(si))
+		local_lock(&percpu_vswap_cluster.lock);
+	else
+#endif
+		local_lock(&percpu_swap_cluster.lock);
 	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_lock(&si->global_cluster_lock);
 	spin_lock(&ci->lock);
@@ -738,19 +774,12 @@ static void free_cluster(struct swap_info_struct *si, struct swap_cluster_info *
 		return;
 	}
 
+	/*
+	 * Vswap dynamic clusters need explicit cleanup (xarray erase,
+	 * kfree_rcu, virtual_table free if allocated).
+	 */
 	if (si->flags & SWP_VSWAP) {
-		struct swap_cluster_info_dynamic *ci_dyn;
-
-		ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
-		if (ci->flags != CLUSTER_FLAG_NONE) {
-			spin_lock(&si->lock);
-			list_del(&ci->list);
-			spin_unlock(&si->lock);
-		}
-		swap_cluster_free_table(ci);
-		xa_erase(&si->cluster_info_pool, ci_dyn->index);
-		ci->flags = CLUSTER_FLAG_DEAD;
-		kfree_rcu(ci_dyn, rcu);
+		vswap_free_cluster(si, ci);
 		return;
 	}
 
@@ -874,6 +903,8 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 	spin_unlock(&ci->lock);
 	do {
 		swp_tb = swap_table_get(ci, offset % SWAPFILE_CLUSTER);
+		if (swp_tb_is_pointer(swp_tb))
+			break;
 		if (swp_tb_get_count(swp_tb))
 			break;
 		if (swp_tb_is_folio(swp_tb))
@@ -946,47 +977,29 @@ static bool cluster_scan_range(struct swap_info_struct *si,
 
 static bool __swap_cluster_alloc_entries(struct swap_info_struct *si,
 					 struct swap_cluster_info *ci,
+					 unsigned int ci_off,
+					 unsigned long swp_tb,
 					 struct folio *folio,
-					 unsigned int ci_off)
+					 unsigned int order)
 {
-	unsigned int order;
-	unsigned long nr_pages;
+	unsigned long nr_pages = 1 << order;
 
 	lockdep_assert_held(&ci->lock);
 
 	if (!(si->flags & SWP_WRITEOK))
 		return false;
 
-	/*
-	 * All mm swap allocation starts with a folio (folio_alloc_swap),
-	 * it's also the only allocation path for large orders allocation.
-	 * Such swap slots starts with count == 0 and will be increased
-	 * upon folio unmap.
-	 *
-	 * Else, it's a exclusive order 0 allocation for hibernation.
-	 * The slot starts with count == 1 and never increases.
-	 */
-	if (likely(folio)) {
-		order = folio_order(folio);
-		nr_pages = 1 << order;
-		swap_cluster_assert_empty(ci, ci_off, nr_pages, false);
+	swap_cluster_assert_empty(ci, ci_off, nr_pages, false);
+
+	if (swp_tb_is_folio(swp_tb))
 		__swap_cache_add_folio(ci, folio, swp_entry(si->type,
 							    ci_off + cluster_offset(si, ci)));
-	} else if (IS_ENABLED(CONFIG_HIBERNATION)) {
-		order = 0;
-		nr_pages = 1;
-		swap_cluster_assert_empty(ci, ci_off, 1, false);
-		/* Fake shadow placeholder with no flag, hibernation does not use the zeromap */
-		__swap_table_set(ci, ci_off, __swp_tb_mk_count(shadow_to_swp_tb(NULL, 0), 1));
-	} else {
-		/* Allocation without folio is only possible with hibernation */
-		WARN_ON_ONCE(1);
-		return false;
-	}
+	else
+		__swap_table_set(ci, ci_off, swp_tb);
 
 	/*
 	 * The first allocation in a cluster makes the
-	 * cluster exclusive to this order
+	 * cluster exclusive to this order.
 	 */
 	if (cluster_is_empty(ci))
 		ci->order = order;
@@ -999,11 +1012,13 @@ static bool __swap_cluster_alloc_entries(struct swap_info_struct *si,
 /* Try use a new cluster for current CPU and allocate from it. */
 static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 					    struct swap_cluster_info *ci,
-					    struct folio *folio, unsigned long offset)
+					    struct folio *folio,
+					    unsigned long offset,
+					    unsigned long swp_tb)
 {
 	unsigned int next = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
 	unsigned long start = ALIGN_DOWN(offset, SWAPFILE_CLUSTER);
-	unsigned int order = likely(folio) ? folio_order(folio) : 0;
+	unsigned int order = folio ? folio_order(folio) : 0;
 	unsigned long end = start + SWAPFILE_CLUSTER;
 	unsigned int nr_pages = 1 << order;
 	bool need_reclaim, ret, usable;
@@ -1029,7 +1044,8 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 			if (!ret)
 				continue;
 		}
-		if (!__swap_cluster_alloc_entries(si, ci, folio, offset % SWAPFILE_CLUSTER))
+		if (!__swap_cluster_alloc_entries(si, ci, offset % SWAPFILE_CLUSTER,
+					swp_tb, folio, order))
 			break;
 		found = offset;
 		offset += nr_pages;
@@ -1042,6 +1058,11 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 		relocate_cluster(si, ci);
 		swap_cluster_unlock(ci);
 	}
+#ifdef CONFIG_VSWAP
+	if (swap_is_vswap(si)) {
+		this_cpu_write(percpu_vswap_cluster.offset[order], next);
+	} else
+#endif
 	if (si->flags & SWP_SOLIDSTATE) {
 		this_cpu_write(percpu_swap_cluster.offset[order], next);
 		this_cpu_write(percpu_swap_cluster.si[order], si);
@@ -1054,7 +1075,8 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
 					 struct list_head *list,
 					 struct folio *folio,
-					 bool scan_all)
+					 bool scan_all,
+					 unsigned long swp_tb)
 {
 	unsigned int found = SWAP_ENTRY_INVALID;
 
@@ -1065,7 +1087,7 @@ static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
 		if (!ci)
 			break;
 		offset = cluster_offset(si, ci);
-		found = alloc_swap_scan_cluster(si, ci, folio, offset);
+		found = alloc_swap_scan_cluster(si, ci, folio, offset, swp_tb);
 		if (found)
 			break;
 	} while (scan_all);
@@ -1074,7 +1096,8 @@ static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
 }
 
 static unsigned int alloc_swap_scan_dynamic(struct swap_info_struct *si,
-					    struct folio *folio)
+					    struct folio *folio,
+					    unsigned long swp_tb)
 {
 	struct swap_cluster_info_dynamic *ci_dyn;
 	struct swap_cluster_info *ci;
@@ -1094,10 +1117,17 @@ static unsigned int alloc_swap_scan_dynamic(struct swap_info_struct *si,
 		return SWAP_ENTRY_INVALID;
 	}
 
+	if (vswap_cluster_alloc_vtable(ci_dyn)) {
+		swap_cluster_free_table(&ci_dyn->ci);
+		kfree(ci_dyn);
+		return SWAP_ENTRY_INVALID;
+	}
+
 	if (xa_alloc(&si->cluster_info_pool, &ci_dyn->index, ci_dyn,
 		     XA_LIMIT(1, DIV_ROUND_UP(si->max, SWAPFILE_CLUSTER) - 1),
 		     GFP_ATOMIC)) {
 		swap_cluster_free_table(&ci_dyn->ci);
+		vswap_cluster_free_vtable(&ci_dyn->ci);
 		kfree(ci_dyn);
 		return SWAP_ENTRY_INVALID;
 	}
@@ -1105,7 +1135,7 @@ static unsigned int alloc_swap_scan_dynamic(struct swap_info_struct *si,
 	ci = &ci_dyn->ci;
 	spin_lock(&ci->lock);
 	offset = cluster_offset(si, ci);
-	return alloc_swap_scan_cluster(si, ci, folio, offset);
+	return alloc_swap_scan_cluster(si, ci, folio, offset, swp_tb);
 }
 
 static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
@@ -1166,18 +1196,20 @@ static void swap_reclaim_work(struct work_struct *work)
  * Try to allocate swap entries with specified order and try set a new
  * cluster for current CPU too.
  */
-static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
-					      struct folio *folio)
+static unsigned long cluster_alloc_swap_entry_tb(struct swap_info_struct *si,
+						 struct folio *folio,
+						 unsigned long swp_tb)
 {
+	unsigned int order = folio ? folio_order(folio) : 0;
 	struct swap_cluster_info *ci;
-	unsigned int order = likely(folio) ? folio_order(folio) : 0;
 	unsigned int offset = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
 
 	/*
-	 * Swapfile is not block device so unable
-	 * to allocate large entries.
+	 * File-based swap can't do large contiguous IO. vswap has no IO
+	 * here (large entries are fine; THP swapin uses vswap_can_swapin_thp
+	 * to gate based on backing).
 	 */
-	if (order && !(si->flags & SWP_BLKDEV))
+	if (order && !(si->flags & SWP_BLKDEV) && !swap_is_vswap(si))
 		return 0;
 
 	if (!(si->flags & SWP_SOLIDSTATE)) {
@@ -1192,7 +1224,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 		if (cluster_is_usable(ci, order)) {
 			if (cluster_is_empty(ci))
 				offset = cluster_offset(si, ci);
-			found = alloc_swap_scan_cluster(si, ci, folio, offset);
+			found = alloc_swap_scan_cluster(si, ci, folio, offset, swp_tb);
 		} else {
 			swap_cluster_unlock(ci);
 		}
@@ -1206,25 +1238,25 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 	 * to spread out the writes.
 	 */
 	if (si->flags & SWP_PAGE_DISCARD) {
-		found = alloc_swap_scan_list(si, &si->free_clusters, folio, false);
+		found = alloc_swap_scan_list(si, &si->free_clusters, folio, false, swp_tb);
 		if (found)
 			goto done;
 	}
 
 	if (order < PMD_ORDER) {
-		found = alloc_swap_scan_list(si, &si->nonfull_clusters[order], folio, true);
+		found = alloc_swap_scan_list(si, &si->nonfull_clusters[order], folio, true, swp_tb);
 		if (found)
 			goto done;
 	}
 
 	if (si->flags & SWP_VSWAP) {
-		found = alloc_swap_scan_dynamic(si, folio);
+		found = alloc_swap_scan_dynamic(si, folio, swp_tb);
 		if (found)
 			goto done;
 	}
 
 	if (!(si->flags & SWP_PAGE_DISCARD)) {
-		found = alloc_swap_scan_list(si, &si->free_clusters, folio, false);
+		found = alloc_swap_scan_list(si, &si->free_clusters, folio, false, swp_tb);
 		if (found)
 			goto done;
 	}
@@ -1240,7 +1272,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 		 * failure is not critical. Scanning one cluster still
 		 * keeps the list rotated and reclaimed (for clean swap cache).
 		 */
-		found = alloc_swap_scan_list(si, &si->frag_clusters[order], folio, false);
+		found = alloc_swap_scan_list(si, &si->frag_clusters[order], folio, false, swp_tb);
 		if (found)
 			goto done;
 	}
@@ -1254,11 +1286,11 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 		 * Clusters here have at least one usable slots and can't fail order 0
 		 * allocation, but reclaim may drop si->lock and race with another user.
 		 */
-		found = alloc_swap_scan_list(si, &si->frag_clusters[o], folio, true);
+		found = alloc_swap_scan_list(si, &si->frag_clusters[o], folio, true, swp_tb);
 		if (found)
 			goto done;
 
-		found = alloc_swap_scan_list(si, &si->nonfull_clusters[o], folio, true);
+		found = alloc_swap_scan_list(si, &si->nonfull_clusters[o], folio, true, swp_tb);
 		if (found)
 			goto done;
 	}
@@ -1394,7 +1426,8 @@ static void swap_range_alloc(struct swap_info_struct *si,
 		if (vm_swap_full())
 			schedule_work(&si->reclaim_work);
 	}
-	atomic_long_sub(nr_entries, &nr_swap_pages);
+	if (!swap_is_vswap(si))
+		atomic_long_sub(nr_entries, &nr_swap_pages);
 }
 
 static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
@@ -1404,8 +1437,10 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
 	unsigned int i;
 
-	for (i = 0; i < nr_entries; i++)
-		zswap_invalidate(swp_entry(si->type, offset + i));
+	if (!swap_is_vswap(si)) {
+		for (i = 0; i < nr_entries; i++)
+			zswap_invalidate(swp_entry(si->type, offset + i));
+	}
 
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
@@ -1424,7 +1459,8 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	 * only after the above cleanups are done.
 	 */
 	smp_wmb();
-	atomic_long_add(nr_entries, &nr_swap_pages);
+	if (!swap_is_vswap(si))
+		atomic_long_add(nr_entries, &nr_swap_pages);
 	swap_usage_sub(si, nr_entries);
 }
 
@@ -1452,12 +1488,15 @@ static bool get_swap_device_info(struct swap_info_struct *si)
  * Fast path try to get swap entries with specified order from current
  * CPU's swap entry pool (a cluster).
  */
-static bool swap_alloc_fast(struct folio *folio)
+static swp_entry_t swap_alloc_fast(struct folio *folio)
 {
 	unsigned int order = folio_order(folio);
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
-	unsigned int offset;
+	unsigned long offset, swp_tb;
+	unsigned long found = 0;
+
+	lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
 
 	/*
 	 * Once allocated, swap_info_struct will never be completely freed,
@@ -1466,25 +1505,32 @@ static bool swap_alloc_fast(struct folio *folio)
 	si = this_cpu_read(percpu_swap_cluster.si[order]);
 	offset = this_cpu_read(percpu_swap_cluster.offset[order]);
 	if (!si || !offset || !get_swap_device_info(si))
-		return false;
+		return (swp_entry_t){};
+
+	swp_tb = folio_to_swp_tb(folio, 0);
 
 	ci = swap_cluster_lock(si, offset);
 	if (ci && cluster_is_usable(ci, order)) {
 		if (cluster_is_empty(ci))
 			offset = cluster_offset(si, ci);
-		alloc_swap_scan_cluster(si, ci, folio, offset);
+		found = alloc_swap_scan_cluster(si, ci, folio, offset, swp_tb);
 	} else if (ci) {
 		swap_cluster_unlock(ci);
 	}
 
 	put_swap_device(si);
-	return folio_test_swapcache(folio);
+	if (found)
+		return swp_entry(si->type, found);
+	return (swp_entry_t){};
 }
 
 /* Rotate the device and switch to a new cluster */
-static void swap_alloc_slow(struct folio *folio)
+static swp_entry_t swap_alloc_slow(struct folio *folio)
 {
 	struct swap_info_struct *si, *next;
+	unsigned long swp_tb, found;
+
+	swp_tb = folio_to_swp_tb(folio, 0);
 
 	spin_lock(&swap_avail_lock);
 start_over:
@@ -1493,12 +1539,13 @@ static void swap_alloc_slow(struct folio *folio)
 		plist_requeue(&si->avail_list, &swap_avail_head);
 		spin_unlock(&swap_avail_lock);
 		if (get_swap_device_info(si)) {
-			cluster_alloc_swap_entry(si, folio);
+			found = cluster_alloc_swap_entry_tb(si, folio,
+							    swp_tb);
 			put_swap_device(si);
-			if (folio_test_swapcache(folio))
-				return;
+			if (found)
+				return swp_entry(si->type, found);
 			if (folio_test_large(folio))
-				return;
+				return (swp_entry_t){};
 		}
 
 		spin_lock(&swap_avail_lock);
@@ -1516,6 +1563,7 @@ static void swap_alloc_slow(struct folio *folio)
 			goto start_over;
 	}
 	spin_unlock(&swap_avail_lock);
+	return (swp_entry_t){};
 }
 
 /*
@@ -1695,6 +1743,15 @@ static void swap_put_entries_cluster(struct swap_info_struct *si,
 	if (!need_reclaim || !reclaim_cache)
 		return;
 
+	/*
+	 * Vswap space is dynamically allocated and effectively infinite —
+	 * there is no benefit to reclaiming swap cache entries to free
+	 * virtual slots. Physical slot reclaim is handled separately via
+	 * SWP_RMAP_CACHE_ONLY on the physical cluster.
+	 */
+	if (swap_is_vswap(si))
+		return;
+
 	do {
 		nr_reclaimed = __try_to_reclaim_swap(si, offset,
 						     TTRS_UNMAPPED | TTRS_FULL);
@@ -1800,6 +1857,44 @@ static int swap_dup_entries_cluster(struct swap_info_struct *si,
  * Context: Caller needs to hold the folio lock.
  * Return: Whether the folio was added to the swap cache.
  */
+#ifdef CONFIG_VSWAP
+static bool vswap_alloc(struct folio *folio)
+{
+	unsigned int order = folio_order(folio);
+	struct swap_cluster_info *ci;
+	unsigned long offset;
+
+	local_lock(&percpu_vswap_cluster.lock);
+	offset = this_cpu_read(percpu_vswap_cluster.offset[order]);
+
+	if (offset != SWAP_ENTRY_INVALID) {
+		ci = swap_cluster_lock(vswap_si, offset);
+		if (ci && cluster_is_usable(ci, order)) {
+			if (cluster_is_empty(ci))
+				offset = cluster_offset(vswap_si, ci);
+			alloc_swap_scan_cluster(vswap_si, ci, folio,
+					       offset, folio_to_swp_tb(folio, 0));
+		} else if (ci) {
+			swap_cluster_unlock(ci);
+		}
+	}
+
+	if (!folio_test_swapcache(folio))
+		cluster_alloc_swap_entry_tb(vswap_si, folio,
+					    folio_to_swp_tb(folio, 0));
+
+	if (folio_test_swapcache(folio)) {
+		/* alloc_swap_scan_cluster updated percpu offset already */
+		local_unlock(&percpu_vswap_cluster.lock);
+		return true;
+	}
+
+	this_cpu_write(percpu_vswap_cluster.offset[order], SWAP_ENTRY_INVALID);
+	local_unlock(&percpu_vswap_cluster.lock);
+	return false;
+}
+#endif
+
 int folio_alloc_swap(struct folio *folio)
 {
 	unsigned int order = folio_order(folio);
@@ -1827,12 +1922,21 @@ int folio_alloc_swap(struct folio *folio)
 		}
 	}
 
+	/*
+	 * Skip vswap when zswap is disabled — without zswap, vswap entries
+	 * have nowhere to go on writeout (no physical fallback yet; that
+	 * arrives in the next patch).
+	 */
+	if (zswap_is_enabled() && vswap_alloc(folio))
+		goto done;
+
 again:
 	local_lock(&percpu_swap_cluster.lock);
-	if (!swap_alloc_fast(folio))
+	if (!swap_alloc_fast(folio).val)
 		swap_alloc_slow(folio);
 	local_unlock(&percpu_swap_cluster.lock);
 
+done:
 	if (!order && unlikely(!folio_test_swapcache(folio))) {
 		if (swap_sync_discard())
 			goto again;
@@ -1848,6 +1952,106 @@ int folio_alloc_swap(struct folio *folio)
 	return 0;
 }
 
+#ifdef CONFIG_VSWAP
+static void vswap_free_cluster(struct swap_info_struct *si,
+			       struct swap_cluster_info *ci)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	if (ci->flags != CLUSTER_FLAG_NONE) {
+		spin_lock(&si->lock);
+		list_del(&ci->list);
+		spin_unlock(&si->lock);
+	}
+	swap_cluster_free_table(ci);
+	vswap_cluster_free_vtable(ci);
+	xa_erase(&si->cluster_info_pool, ci_dyn->index);
+	ci->flags = CLUSTER_FLAG_DEAD;
+	kfree_rcu(ci_dyn, rcu);
+}
+
+void vswap_release_backing(struct swap_cluster_info *ci,
+			   unsigned int ci_start, unsigned int nr)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+	unsigned int ci_off;
+	unsigned long vt;
+
+	lockdep_assert_held(&ci->lock);
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+
+	for (ci_off = ci_start; ci_off < ci_start + nr; ci_off++) {
+		vt = __vtable_get(ci_dyn, ci_off);
+
+		switch (vtable_type(vt)) {
+		case VSWAP_ZSWAP:
+			if (vtable_to_zswap(vt))
+				zswap_entry_free(vtable_to_zswap(vt));
+			break;
+		case VSWAP_SWAPFILE:
+		case VSWAP_FOLIO:
+		case VSWAP_ZERO:
+		case VSWAP_NONE:
+			break;
+		}
+
+		__vtable_set(ci_dyn, ci_off, vtable_mk_none());
+	}
+}
+
+void vswap_store_folio(swp_entry_t entry, struct folio *folio)
+{
+	struct swap_cluster_info *ci;
+	struct swap_cluster_info_dynamic *ci_dyn;
+	int i, nr = folio_nr_pages(folio);
+	unsigned int voff;
+
+	ci = __swap_entry_to_cluster(entry);
+	if (!ci)
+		return;
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	voff = swp_cluster_offset(entry);
+
+	spin_lock(&ci->lock);
+	vswap_release_backing(ci, voff, nr);
+	for (i = 0; i < nr; i++)
+		__vtable_set(ci_dyn, voff + i, vtable_mk_folio(folio));
+	spin_unlock(&ci->lock);
+}
+
+void vswap_prepare_writeout(swp_entry_t entry, struct folio *folio)
+{
+	struct swap_cluster_info *ci;
+	struct swap_cluster_info_dynamic *ci_dyn;
+	int i, nr = folio_nr_pages(folio);
+	unsigned int voff;
+	unsigned long vt;
+	enum vswap_backing_type type;
+
+	ci = __swap_entry_to_cluster(entry);
+	if (!ci)
+		return;
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	voff = swp_cluster_offset(entry);
+
+	spin_lock(&ci->lock);
+	vt = __vtable_get(ci_dyn, voff);
+	type = vtable_type(vt);
+
+	if (type == VSWAP_SWAPFILE || type == VSWAP_FOLIO || type == VSWAP_NONE) {
+		spin_unlock(&ci->lock);
+		return;
+	}
+
+	vswap_release_backing(ci, voff, nr);
+	for (i = 0; i < nr; i++)
+		__vtable_set(ci_dyn, voff + i, vtable_mk_folio(folio));
+	spin_unlock(&ci->lock);
+}
+
+#endif /* CONFIG_VSWAP */
+
 /**
  * folio_dup_swap() - Increase swap count of swap entries of a folio.
  * @folio: folio with swap entries bounded.
@@ -1989,6 +2193,9 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 
 	VM_WARN_ON(ci->count < nr_pages);
 
+	if (swap_is_vswap(si))
+		vswap_release_backing(ci, ci_start, nr_pages);
+
 	ci->count -= nr_pages;
 	do {
 		old_tb = __swap_table_get(ci, ci_off);
@@ -2240,12 +2447,15 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 	if (pcp_si == si && pcp_offset) {
 		ci = swap_cluster_lock(si, pcp_offset);
 		if (ci && cluster_is_usable(ci, 0))
-			offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
+			offset = alloc_swap_scan_cluster(si, ci, NULL,
+					pcp_offset,
+					__swp_tb_mk_count(
+						shadow_to_swp_tb(NULL, 0), 1));
 		else if (ci)
 			swap_cluster_unlock(ci);
 	}
 	if (!offset)
-		offset = cluster_alloc_swap_entry(si, NULL);
+		offset = cluster_alloc_swap_entry_tb(si, NULL, __swp_tb_mk_count(shadow_to_swp_tb(NULL, 0), 1));
 	local_unlock(&percpu_swap_cluster.lock);
 	if (offset)
 		entry = swp_entry(si->type, offset);
@@ -2915,6 +3125,7 @@ static int try_to_unuse(unsigned int type)
 	       (i = find_next_to_unuse(si, i)) != 0) {
 
 		entry = swp_entry(type, i);
+
 		folio = swap_cache_get_folio(entry);
 		if (!folio)
 			continue;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ca4533eba701..94b6cfcc28ac 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -350,6 +350,9 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 		 */
 		if (get_nr_swap_pages() > 0)
 			return true;
+		/* vswap doesn't contribute to nr_swap_pages */
+		if (IS_ENABLED(CONFIG_VSWAP) && zswap_is_enabled())
+			return true;
 	} else {
 		/* Is the memcg below its swap limit? */
 		if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
@@ -2615,7 +2618,7 @@ static bool can_age_anon_pages(struct lruvec *lruvec,
 			       struct scan_control *sc)
 {
 	/* Aging the anon LRU is valuable if swap is present: */
-	if (total_swap_pages > 0)
+	if (total_swap_pages > 0 || (IS_ENABLED(CONFIG_VSWAP) && zswap_is_enabled()))
 		return true;
 
 	/* Also valuable if anon pages can be demoted: */
diff --git a/mm/vswap.h b/mm/vswap.h
index 094ff16cb5a4..5e6e5b88593c 100644
--- a/mm/vswap.h
+++ b/mm/vswap.h
@@ -7,23 +7,307 @@
 #ifndef _MM_VSWAP_H
 #define _MM_VSWAP_H
 
+
 #include <linux/swap.h>
 
+struct zswap_entry;
+
+static inline bool swap_is_vswap(struct swap_info_struct *si)
+{
+	return si->flags & SWP_VSWAP;
+}
+
 #ifdef CONFIG_VSWAP
 
+#include "swap.h"
+#include "swap_table.h"
+
 extern struct swap_info_struct *vswap_si;
 
-static inline bool swap_is_vswap(struct swap_info_struct *si)
+/*
+ * Virtual table entry encoding for vswap clusters.
+ *
+ * Each entry in ci_dyn->virtual_table stores the backing type and
+ * pointer for a virtual swap slot. Tag in low 3 bits, payload in
+ * upper 61 bits.
+ *
+ *   NONE:   |----- 0000 ------|000|  — free / unbacked
+ *   PHYS:   |-- (type:5,off:N)|001|  — on a physical swapfile (shifted)
+ *   ZERO:   |----- 0000 ------|010|  — zero-filled page
+ *   ZSWAP:  |--- zswap_entry* |011|  — compressed in zswap (tag in low bits)
+ *   FOLIO:  |--- folio* ------|100|  — in-memory only (tag in low bits)
+ *
+ * PHYS payloads are shifted left by 3. Pointer payloads (ZSWAP, FOLIO)
+ * are stored directly with the tag OR'd into the low bits (kernel
+ * pointers are >= 8-byte aligned, same approach as xarray).
+ */
+enum vswap_backing_type {
+	VSWAP_NONE	= 0,
+	VSWAP_SWAPFILE	= 1,
+	VSWAP_ZERO	= 2,
+	VSWAP_ZSWAP	= 3,
+	VSWAP_FOLIO	= 4,
+};
+
+#define VTABLE_TAG_BITS		3
+#define VTABLE_TAG_MASK		((1UL << VTABLE_TAG_BITS) - 1)
+
+static inline enum vswap_backing_type vtable_type(unsigned long vt)
 {
-	return si->flags & SWP_VSWAP;
+	return vt & VTABLE_TAG_MASK;
 }
 
-#else
+static inline unsigned long vtable_payload(unsigned long vt)
+{
+	return vt >> VTABLE_TAG_BITS;
+}
 
-static inline bool swap_is_vswap(struct swap_info_struct *si)
+static inline unsigned long vtable_mk(enum vswap_backing_type type,
+				       unsigned long payload)
+{
+	return (payload << VTABLE_TAG_BITS) | type;
+}
+
+static inline unsigned long vtable_mk_none(void)
+{
+	return 0;
+}
+
+static inline unsigned long vtable_mk_zero(void)
+{
+	return VSWAP_ZERO;
+}
+
+static inline unsigned long vtable_mk_zswap(struct zswap_entry *ze)
+{
+	return (unsigned long)ze | VSWAP_ZSWAP;
+}
+
+static inline struct zswap_entry *vtable_to_zswap(unsigned long vt)
+{
+	VM_WARN_ON(vtable_type(vt) != VSWAP_ZSWAP);
+	return (struct zswap_entry *)(vt & ~VTABLE_TAG_MASK);
+}
+
+static inline unsigned long vtable_mk_folio(struct folio *folio)
+{
+	return (unsigned long)folio | VSWAP_FOLIO;
+}
+
+static inline struct folio *vtable_to_folio(unsigned long vt)
+{
+	VM_WARN_ON(vtable_type(vt) != VSWAP_FOLIO);
+	return (struct folio *)(vt & ~VTABLE_TAG_MASK);
+}
+
+/* Virtual table accessors */
+
+static inline unsigned long __vtable_get(struct swap_cluster_info_dynamic *ci_dyn,
+					 unsigned int off)
+{
+	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
+	return atomic_long_read(&ci_dyn->virtual_table[off]);
+}
+
+static inline void __vtable_set(struct swap_cluster_info_dynamic *ci_dyn,
+				unsigned int off, unsigned long vt)
+{
+	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
+	atomic_long_set(&ci_dyn->virtual_table[off], vt);
+}
+
+/*
+ * Lock a vswap cluster and return the dynamic info + slot offset.
+ * Returns NULL if cluster not found.
+ * Caller must spin_unlock(&ci_dyn->ci.lock) when done.
+ */
+static inline struct swap_cluster_info_dynamic *
+vswap_lock_cluster(swp_entry_t entry, unsigned int *voff)
+{
+	struct swap_cluster_info *ci;
+	struct swap_cluster_info_dynamic *ci_dyn;
+
+	ci = __swap_entry_to_cluster(entry);
+	if (!ci)
+		return NULL;
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	*voff = swp_cluster_offset(entry);
+	spin_lock(&ci->lock);
+	return ci_dyn;
+}
+
+/* Zswap entry helpers — store/load/erase in virtual_table */
+
+void vswap_release_backing(struct swap_cluster_info *ci,
+			   unsigned int ci_start, unsigned int nr);
+
+static inline void vswap_zswap_store(swp_entry_t entry,
+				     struct zswap_entry *ze)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+	unsigned int voff;
+
+	ci_dyn = vswap_lock_cluster(entry, &voff);
+	if (!ci_dyn)
+		return;
+	vswap_release_backing(&ci_dyn->ci, voff, 1);
+	__vtable_set(ci_dyn, voff, vtable_mk_zswap(ze));
+	spin_unlock(&ci_dyn->ci.lock);
+}
+
+static inline struct zswap_entry *vswap_zswap_load(swp_entry_t entry)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+	unsigned int voff;
+	unsigned long vt;
+
+	ci_dyn = vswap_lock_cluster(entry, &voff);
+	if (!ci_dyn)
+		return NULL;
+	vt = __vtable_get(ci_dyn, voff);
+	spin_unlock(&ci_dyn->ci.lock);
+
+	if (vtable_type(vt) != VSWAP_ZSWAP)
+		return NULL;
+	return vtable_to_zswap(vt);
+}
+
+
+void vswap_store_folio(swp_entry_t entry, struct folio *folio);
+void vswap_prepare_writeout(swp_entry_t entry, struct folio *folio);
+
+/*
+ * Check that all nr vtable entries starting at entry have the same
+ * backing type. Returns the number of matching entries (< nr on
+ * mismatch).
+ */
+static inline int vswap_check_backing(swp_entry_t entry, int nr,
+				      enum vswap_backing_type *typep)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+	enum vswap_backing_type first_type;
+	unsigned int voff;
+	unsigned long vt;
+	int i;
+
+	ci_dyn = vswap_lock_cluster(entry, &voff);
+	if (!ci_dyn)
+		return 0;
+
+	for (i = 0; i < nr; i++) {
+		vt = __vtable_get(ci_dyn, voff + i);
+		if (!i)
+			first_type = vtable_type(vt);
+		else if (vtable_type(vt) != first_type)
+			break;
+	}
+	spin_unlock(&ci_dyn->ci.lock);
+
+	if (typep)
+		*typep = first_type;
+	return i;
+}
+
+static inline bool vswap_can_swapin_thp(swp_entry_t entry, int nr)
+{
+	enum vswap_backing_type type;
+
+	return vswap_check_backing(entry, nr, &type) == nr &&
+	       type == VSWAP_ZERO;
+}
+
+static inline int vswap_cluster_alloc_vtable(struct swap_cluster_info_dynamic *ci_dyn)
+{
+	ci_dyn->virtual_table = kcalloc(SWAPFILE_CLUSTER,
+					sizeof(*ci_dyn->virtual_table),
+					GFP_ATOMIC);
+	return ci_dyn->virtual_table ? 0 : -ENOMEM;
+}
+
+static inline void vswap_cluster_free_vtable(struct swap_cluster_info *ci)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	kfree(ci_dyn->virtual_table);
+	ci_dyn->virtual_table = NULL;
+}
+
+/* Low-level setter for callers already holding the cluster lock */
+static inline void vswap_set_zswap(struct swap_cluster_info *ci,
+				   unsigned int ci_off,
+				   struct zswap_entry *ze)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	__vtable_set(ci_dyn, ci_off, vtable_mk_zswap(ze));
+}
+
+/* Zeromap helpers — test/set ZERO backing in virtual_table */
+
+static inline bool vswap_test_zero(struct swap_cluster_info *ci,
+				   unsigned int ci_off)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	return vtable_type(__vtable_get(ci_dyn, ci_off)) == VSWAP_ZERO;
+}
+
+static inline void vswap_set_zero(struct swap_cluster_info *ci,
+				  unsigned int ci_off)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	__vtable_set(ci_dyn, ci_off, vtable_mk_zero());
+}
+
+#else /* !CONFIG_VSWAP */
+
+static inline void vswap_release_backing(struct swap_cluster_info *ci,
+					 unsigned int ci_start,
+					 unsigned int nr) {}
+
+static inline void vswap_zswap_store(swp_entry_t entry,
+				     struct zswap_entry *ze) {}
+
+static inline struct zswap_entry *vswap_zswap_load(swp_entry_t entry)
+{
+	return NULL;
+}
+
+static inline void vswap_store_folio(swp_entry_t entry,
+				     struct folio *folio) {}
+static inline void vswap_prepare_writeout(swp_entry_t entry,
+					  struct folio *folio) {}
+
+static inline bool vswap_can_swapin_thp(swp_entry_t entry, int nr)
+{
+	return false;
+}
+
+struct swap_cluster_info_dynamic;
+static inline int vswap_cluster_alloc_vtable(struct swap_cluster_info_dynamic *ci_dyn)
+{
+	return 0;
+}
+
+static inline void vswap_cluster_free_vtable(struct swap_cluster_info *ci) {}
+
+static inline void vswap_set_zswap(struct swap_cluster_info *ci,
+				   unsigned int ci_off,
+				   struct zswap_entry *ze) {}
+
+static inline bool vswap_test_zero(struct swap_cluster_info *ci,
+				   unsigned int ci_off)
 {
 	return false;
 }
 
+static inline void vswap_set_zero(struct swap_cluster_info *ci,
+				  unsigned int ci_off) {}
+
 #endif /* CONFIG_VSWAP */
 #endif /* _MM_VSWAP_H */
diff --git a/mm/zswap.c b/mm/zswap.c
index 993406074d58..c57bf0246bb2 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -38,6 +38,7 @@
 #include <linux/zsmalloc.h>
 
 #include "swap.h"
+#include "vswap.h"
 #include "internal.h"
 
 /*********************************
@@ -762,7 +763,7 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
  * Carries out the common pattern of freeing an entry's zsmalloc allocation,
  * freeing the entry itself, and decrementing the number of stored pages.
  */
-static void zswap_entry_free(struct zswap_entry *entry)
+void zswap_entry_free(struct zswap_entry *entry)
 {
 	zswap_lru_del(&zswap_list_lru, entry);
 	zs_free(entry->pool->zs_pool, entry->handle);
@@ -994,16 +995,21 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct swap_info_struct *si;
 	int ret = 0;
 
+	/* try to allocate swap cache folio */
 	si = get_swap_device(swpentry);
 	if (!si)
 		return -EEXIST;
 
+	/*
+	 * Vswap entries have no physical backing — writeback would fail
+	 * and SIGBUS the caller. Bail before we waste a swap-cache folio
+	 * allocation.
+	 */
 	if (si->flags & SWP_VSWAP) {
 		put_swap_device(si);
 		return -EINVAL;
 	}
 
-	/* try to allocate swap cache folio */
 	mpol = get_task_policy(current);
 	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NULL, mpol,
 				       NO_INTERLEAVE_INDEX);
@@ -1206,6 +1212,18 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
 		return 0;
 
+	/*
+	 * With CONFIG_VSWAP and zswap enabled, every zswap entry is
+	 * vswap-backed and needs a physical swap slot allocated on demand
+	 * (via folio_realloc_swap) for writeback. If no physical slots are
+	 * available, writeback will fail — skip the shrinker to avoid
+	 * spinning on entries we cannot drain. Vanilla zswap-on-swapfile is
+	 * unaffected because every zswap entry already has a backing slot;
+	 * gate on CONFIG_VSWAP so the check compiles out there.
+	 */
+	if (IS_ENABLED(CONFIG_VSWAP) && !get_nr_swap_pages())
+		return 0;
+
 	/*
 	 * The shrinker resumes swap writeback, which will enter block
 	 * and may enter fs. XXX: Harmonize with vmscan.c __GFP_FS
@@ -1416,25 +1434,25 @@ static bool zswap_store_page(struct page *page,
 	if (!zswap_compress(page, entry, pool))
 		goto compress_failed;
 
-	old = xa_store(swap_zswap_tree(page_swpentry),
-		       swp_offset(page_swpentry),
-		       entry, GFP_KERNEL);
-	if (xa_is_err(old)) {
-		int err = xa_err(old);
+	if (swap_is_vswap(__swap_entry_to_info(page_swpentry))) {
+		vswap_zswap_store(page_swpentry, entry);
+	} else {
+		old = xa_store(swap_zswap_tree(page_swpentry),
+			       swp_offset(page_swpentry),
+			       entry, GFP_KERNEL);
+		if (xa_is_err(old)) {
+			int err = xa_err(old);
+
+			WARN_ONCE(err != -ENOMEM,
+				  "unexpected xarray error: %d\n", err);
+			zswap_reject_alloc_fail++;
+			goto store_failed;
+		}
 
-		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
-		zswap_reject_alloc_fail++;
-		goto store_failed;
+		if (old)
+			zswap_entry_free(old);
 	}
 
-	/*
-	 * We may have had an existing entry that became stale when
-	 * the folio was redirtied and now the new version is being
-	 * swapped out. Get rid of the old.
-	 */
-	if (old)
-		zswap_entry_free(old);
-
 	/*
 	 * The entry is successfully compressed and stored in the tree, there is
 	 * no further possibility of failure. Grab refs to the pool and objcg,
@@ -1533,6 +1551,8 @@ bool zswap_store(struct folio *folio)
 
 	count_vm_events(ZSWPOUT, nr_pages);
 
+	/* zswap_store_page stores directly in virtual_table for vswap */
+
 	ret = true;
 
 put_pool:
@@ -1547,8 +1567,14 @@ bool zswap_store(struct folio *folio)
 	 * the possibly stale entries which were previously stored at the
 	 * offsets corresponding to each page of the folio. Otherwise,
 	 * writeback could overwrite the new data in the swapfile.
+	 *
+	 * vswap stores zswap entries directly in the per-slot virtual_table
+	 * (no per-device xarray), so the stale-entry cleanup is implicit:
+	 * a successful vswap_zswap_store overwrites the slot via
+	 * vswap_release_backing, and a failed store leaves the old backing
+	 * untouched.
 	 */
-	if (!ret) {
+	if (!ret && !swap_is_vswap(__swap_entry_to_info(swp))) {
 		unsigned type = swp_type(swp);
 		pgoff_t offset = swp_offset(swp);
 		struct zswap_entry *entry;
@@ -1588,8 +1614,7 @@ bool zswap_store(struct folio *folio)
 int zswap_load(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
-	pgoff_t offset = swp_offset(swp);
-	struct xarray *tree = swap_zswap_tree(swp);
+	struct swap_info_struct *si = __swap_entry_to_info(swp);
 	struct zswap_entry *entry;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
@@ -1599,16 +1624,25 @@ int zswap_load(struct folio *folio)
 		return -ENOENT;
 
 	/*
-	 * Large folios should not be swapped in while zswap is being used, as
-	 * they are not properly handled. Zswap does not properly load large
-	 * folios, and a large folio may only be partially in zswap.
+	 * zswap_load() does not support large folios. For non-vswap
+	 * entries this is unexpected on the swapin path: WARN and
+	 * sigbus. For vswap entries vswap_can_swapin_thp() has already
+	 * filtered out ZSWAP-backed THPs, so the large folio here is
+	 * zero- or phys-backed; return -ENOENT to fall through to the
+	 * phys/zero IO path.
 	 */
-	if (WARN_ON_ONCE(folio_test_large(folio))) {
-		folio_unlock(folio);
-		return -EINVAL;
+	if (folio_test_large(folio)) {
+		if (WARN_ON_ONCE(!swap_is_vswap(si))) {
+			folio_unlock(folio);
+			return -EINVAL;
+		}
+		return -ENOENT;
 	}
 
-	entry = xa_load(tree, offset);
+	if (swap_is_vswap(si))
+		entry = vswap_zswap_load(swp);
+	else
+		entry = xa_load(swap_zswap_tree(swp), swp_offset(swp));
 	if (!entry)
 		return -ENOENT;
 
@@ -1623,16 +1657,14 @@ int zswap_load(struct folio *folio)
 	if (entry->objcg)
 		count_objcg_events(entry->objcg, ZSWPIN, 1);
 
-	/*
-	 * We are reading into the swapcache, invalidate zswap entry.
-	 * The swapcache is the authoritative owner of the page and
-	 * its mappings, and the pressure that results from having two
-	 * in-memory copies outweighs any benefits of caching the
-	 * compression work.
-	 */
 	folio_mark_dirty(folio);
-	xa_erase(tree, offset);
-	zswap_entry_free(entry);
+
+	if (swap_is_vswap(si)) {
+		vswap_store_folio(swp, folio);
+	} else {
+		xa_erase(swap_zswap_tree(swp), swp_offset(swp));
+		zswap_entry_free(entry);
+	}
 
 	folio_unlock(folio);
 	return 0;
-- 
2.53.0-Meta


