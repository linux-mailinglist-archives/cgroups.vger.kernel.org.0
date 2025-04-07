Return-Path: <cgroups+bounces-7417-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793B4A7F170
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 01:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EDA3B6E95
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0FE2566C5;
	Mon,  7 Apr 2025 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWqbb1AD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCEA22FF44;
	Mon,  7 Apr 2025 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069358; cv=none; b=uu194t+qWzzEhdMAOu612XwrHGcFDYmMniG/HH7CaU0ENjIewwvCuYDkedHoOu7ZCAJyxqLQD1V4CIZEXA7ub+n7oMmHH0fimNB22ZlP6owZWwibnxW6pdvECC4dhOKWFONz95Y85G9CappNGwy/8+QH4LSGmBZtKkcD6kC6kmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069358; c=relaxed/simple;
	bh=j3Ez4oaXvJugRrSaR967azYeavG7pZoUaT+kPJaOBIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hja9X6IWuCUzjbDv0XiWpbhrZH68u4pFaSg/ZE00GWPOLAGKS49p/VHnv2JdHeVtAxRrw0WtiNHfVLbxqKyR+xgxpAMSCpfeOY+WZ8bEl50Y8uDR9/CuuDSN6sOoCp+mQ/k4Blbqr9zGp8XLxDYIAp1OIhOkboVCZHpReSqJtG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWqbb1AD; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e6df4507690so4460777276.0;
        Mon, 07 Apr 2025 16:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069351; x=1744674151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++y7zqsSUm8uP+99pfz8bU1v8EN8IiNpgEeMWYk8aVg=;
        b=CWqbb1ADg5mTXiAN9Zze3F1cPczdOznfYmOW6/pghUtnPkUvzBJ9GhVZ1B+zPGWIoG
         pGGMMaVqsUAyyQy5+Ioy680E9w7OqoECXeWL/1vxUJGARGLRy6uF0Ui4QzxtgK0nUXgg
         zNI0SwyqTMq/Z2Qlw9FL6bPGqrhunC8+be0f2PKnW2QIuEU+j9T8UkKd0+6Y1TLC2kqN
         K879EEar1d40xH95gyHDLQoI3JXrGNHnPjQi0obCpRHsEKzgwOaRruu/r3mWHZ1iEeGI
         ox/v68f4A+ePEqQtbCMCfDahkrzFZDEYkAUMYclPWbM/4m+1GFlHwu3v9Oswd6wwSyN6
         ocew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069351; x=1744674151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++y7zqsSUm8uP+99pfz8bU1v8EN8IiNpgEeMWYk8aVg=;
        b=ZEyAsFnf0gOjU8cGJe84/ZY+5uG6iUGXnjSWvdTl6uowSGW3VFa87g7rRdFJLbBVU0
         IS6aMkVcFmCPi+Gtkd/WxrREnbDGgNYE5yO7Rzk90z8xA0S6mo+AFx1JJNqUCUjQe43P
         hBxbTLkuvUATfuRJbwAD3AUVO62rInL3oQSlanaiPnOBk3OXP5OUDzlTLw9fObrJVhhE
         PK+zm/SA0Gs1wvyzeYjafWwSDrTNpGk+sPKaMh03C+qZKWplDY8b7aFbcWgSuKAnjq0y
         Z0vETH0BbbdGuq3VZ+FSXbsEyhw/t947SDQ98orbNNoGAriOw+HcYgRzLzNzSmDWjBTM
         4Akw==
X-Forwarded-Encrypted: i=1; AJvYcCVNuOrfS4erWq0bjbkrqL4Tyc0mRgRLf6J9wdZ4ulbXvVJzYypvQhdiIIX7aiwDOB06eWoGlLujimA=@vger.kernel.org, AJvYcCVU/SvVc/WxlMjQUBa5NHrQ5qhGWN8gfa1vzL8O7JrbydK+zb08OLJn/xEVk5Xdp6Y55ZzAKAJ7yI9XVolB@vger.kernel.org, AJvYcCVgbego6/Jov7AGUuVAGuuABw4tD2Y0GJHc7EyWmj1leZ3NQ/jlsx8juc1rqAqtaukgFShbaV7k@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0GP2MyomLYOJAyM8Tekucm/KMB3iWM+Y+pUUlFHyBZJFQlLfG
	9uvECI8uz0XDufEDj6rjJp/AsqEu3llRWiaVCoQTzz+EHAZ68R3v
X-Gm-Gg: ASbGncuq5NdliVqafNo3BZ6uo5R9Mm1FkPxFre1ebYAJFk0xHyDGPAxYaQzaIEWFYZa
	X3Ath2a6AthBreKzQOM7+mg0DRdQRniuEZWVssErOAMH2p3klVCN28fWq/xUMbwL6HKRp6jSG7g
	CMjxqDOpZ2sRyvKyRWx1TcrfXkw7RfA0gC9TVxW2fpQIff3vNQnSmgIGj/BbCFUb5MEP+Xj5wlf
	VWaanxwSbpd92++L245id1WjnjMvj+GrAo1UerDbsVZwjHlWg4wU+OKkDxpn1gP2yWFx0t+Kdo2
	HuAIoDJXQjd5gZiIaqnAUAaq6he44qMGOnCV07uEaA2fbw==
X-Google-Smtp-Source: AGHT+IHumYcSFOyyzMxaCYbmI7UMkmPuvvyLK3KYwROrGmszF9zaV/12YHvO/xSJpGYI0gp7r3mZ+w==
X-Received: by 2002:a05:6902:1381:b0:e5b:32f5:e38c with SMTP id 3f1490d57ef6-e6e5d8dd287mr2145989276.8.1744069350968;
        Mon, 07 Apr 2025 16:42:30 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e6e0ca987d9sm2615939276.39.2025.04.07.16.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:42:30 -0700 (PDT)
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
Subject: [RFC PATCH 10/14] mm: swap: decouple virtual swap slot from backing store
Date: Mon,  7 Apr 2025 16:42:11 -0700
Message-ID: <20250407234223.1059191-11-nphamcs@gmail.com>
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

This patch presents the first real use case of the new virtual swap
design. It leverages the virtualization of the swap space to decouple a
swap entry and its backing storage. A swap entry can now be backed by
one of the following options:

1. A slot on a physical swapfile/swap partition.
2. A "zero swap page".
3. A compressed object in the zswap pool.
4. An in-memory page. This can happen when a page is loaded
   (exclusively) from the zswap pool, or if the page is rejected by
   zswap and zswap writeback is disabled.

This allows us to use zswap and the zero swap page optimization, without
having to reserved a slot on a swapfile, or a swapfile at all.

Note that we disable THP swapin on virtual swap implementation, for now.
Similarly, we only operates on one swap entry at a time when we zap a
PTE range. There is no real reason why we cannot build support for this
in the new design. It is simply to make the patch smaller and more
manageable for reviewers - these capabilities will be restored in a
following patch.

In the same vein, for now we still charge virtual swap slots towards the
memcg's swap usage. In a following patch, we will change this behavior
and only charge physical (i.e on swapfile) swap slots towards the
memcg's swap usage.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  71 +++++-
 mm/Kconfig           |  11 +
 mm/huge_memory.c     |   5 +-
 mm/internal.h        |  16 +-
 mm/memcontrol.c      |  70 ++++--
 mm/memory.c          |  73 ++++--
 mm/migrate.c         |   1 +
 mm/page_io.c         |  31 ++-
 mm/shmem.c           |   7 +-
 mm/swap.h            |  10 +
 mm/swap_state.c      |  23 +-
 mm/swapfile.c        |  20 +-
 mm/vmscan.c          |  26 ++-
 mm/vswap.c           | 531 ++++++++++++++++++++++++++++++++++++++-----
 mm/zswap.c           |  34 ++-
 15 files changed, 771 insertions(+), 158 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 7f6200f1db33..073835335667 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -461,6 +461,7 @@ extern void __meminit kswapd_stop(int nid);
 /* Virtual swap API */
 swp_entry_t folio_alloc_swap(struct folio *folio);
 bool folio_free_swap(struct folio *folio);
+void put_swap_folio(struct folio *folio, swp_entry_t entry);
 void swap_shmem_alloc(swp_entry_t, int);
 int swap_duplicate(swp_entry_t);
 int swapcache_prepare(swp_entry_t entry, int nr);
@@ -508,7 +509,6 @@ static inline long get_nr_swap_pages(void)
 }
 
 void si_swapinfo(struct sysinfo *);
-void swap_slot_put_folio(swp_slot_t slot, struct folio *folio);
 swp_slot_t swap_slot_alloc_of_type(int);
 int swap_slot_alloc(int n, swp_slot_t swp_slots[], int order);
 void swap_slot_free_nr(swp_slot_t slot, int nr_pages);
@@ -725,9 +725,12 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 }
 #endif
 
+struct zswap_entry;
+
 #ifdef CONFIG_VIRTUAL_SWAP
 int vswap_init(void);
 void vswap_exit(void);
+swp_slot_t vswap_alloc_swap_slot(struct folio *folio);
 swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry);
 swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot);
 bool vswap_tryget(swp_entry_t entry);
@@ -736,7 +739,13 @@ bool folio_swapped(struct folio *folio);
 bool vswap_swapcache_only(swp_entry_t entry, int nr);
 int non_swapcache_batch(swp_entry_t entry, int nr);
 bool swap_free_nr_any_cache_only(swp_entry_t entry, int nr);
-void put_swap_folio(struct folio *folio, swp_entry_t entry);
+bool vswap_disk_backed(swp_entry_t entry, int nr);
+void vswap_split_huge_page(struct folio *head, struct folio *subpage);
+void vswap_migrate(struct folio *src, struct folio *dst);
+bool vswap_folio_backed(swp_entry_t entry, int nr);
+void vswap_store_folio(swp_entry_t entry, struct folio *folio);
+void swap_zeromap_folio_set(struct folio *folio);
+void vswap_assoc_zswap(swp_entry_t entry, struct zswap_entry *zswap_entry);
 
 static inline bool trylock_swapoff(swp_entry_t entry,
 				struct swap_info_struct **si)
@@ -745,16 +754,33 @@ static inline bool trylock_swapoff(swp_entry_t entry,
 		return false;
 
 	/*
-	 * No need to hold a reference to the swap device. The virtual swap slot pins
-	 * the physical swap slot, which in turns pin the swap device.
+	 * Note that this function does not provide any guarantee that the virtual
+	 * swap slot's backing state will be stable, only that the slot itself will
+	 * not be freed. This has several implications:
+	 *
+	 * 1. If the virtual swap slot is backed by a physical swap slot, we need to
+	 * also acquire a reference to the swap device before returning it.
+	 * Otherwise, the virtual swap slot can change its backend, allowing swapoff
+	 * to free the swap device looked up here.
+	 *
+	 * 2. The swap device we are looking up here might be outdated by the time we
+	 * return to the caller. It is perfectly OK, if the swap_info_struct is only
+	 * used in a best-effort manner (i.e optimization). If we need the precise
+	 * backing state, we need to re-check after the entry is pinned in swap cache.
 	 */
-	*si = swap_slot_swap_info(swp_entry_to_swp_slot(entry));
+	if (vswap_disk_backed(entry, 1))
+		*si = swap_slot_tryget_swap_info(swp_entry_to_swp_slot(entry));
+	else
+		*si = NULL;
+
 	return true;
 }
 
 static inline void unlock_swapoff(swp_entry_t entry,
 				struct swap_info_struct *si)
 {
+	if (si)
+		swap_slot_put_swap_info(si);
 	vswap_put(entry);
 }
 #else
@@ -791,9 +817,32 @@ static inline swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
 	return (swp_entry_t) { slot.val };
 }
 
-static inline void put_swap_folio(struct folio *folio, swp_entry_t entry)
+static inline swp_slot_t vswap_alloc_swap_slot(struct folio *folio)
+{
+	return swp_entry_to_swp_slot(folio->swap);
+}
+
+static inline void vswap_split_huge_page(struct folio *head,
+				struct folio *subpage)
+{
+}
+
+static inline void vswap_migrate(struct folio *src, struct folio *dst)
+{
+}
+
+static inline bool vswap_folio_backed(swp_entry_t entry, int nr)
+{
+	return false;
+}
+
+static inline void vswap_store_folio(swp_entry_t entry, struct folio *folio)
+{
+}
+
+static inline void vswap_assoc_zswap(swp_entry_t entry,
+				struct zswap_entry *zswap_entry)
 {
-	swap_slot_put_folio(swp_entry_to_swp_slot(entry), folio);
 }
 
 static inline bool trylock_swapoff(swp_entry_t entry,
@@ -810,8 +859,16 @@ static inline void unlock_swapoff(swp_entry_t entry,
 {
 	swap_slot_put_swap_info(si);
 }
+
 #endif
 
+static inline struct swap_info_struct *vswap_get_device(swp_entry_t entry)
+{
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+
+	return slot.val ? swap_slot_tryget_swap_info(slot) : NULL;
+}
+
 #if defined(CONFIG_SWAP) && !defined(CONFIG_VIRTUAL_SWAP)
 int add_swap_count_continuation(swp_entry_t, gfp_t);
 #else
diff --git a/mm/Kconfig b/mm/Kconfig
index d578b8e6ab6a..e9abc33fe4b7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -35,6 +35,17 @@ config VIRTUAL_SWAP
 		In this new design, for each swap entry, a virtual swap slot is
 		allocated and stored in the page table entry, rather than the
 		handle to the physical swap slot on the swap device itself.
+		Swap entries that are:
+
+		1. Zero-filled
+
+		2. Stored in the zswap pool.
+
+		3. Rejected by zswap but cannot be written back to a backing
+		   swap device.
+
+		no longer take up any disk storage (i.e they do not occupy any
+		slot in the backing swap device).
 
 		There might be more lock contentions with heavy swap use, since
 		the swap cache is no longer range partitioned.
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 373781b21e5c..e6832ec2b07a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3172,6 +3172,7 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 {
 	struct page *head = &folio->page;
 	struct page *page_tail = head + tail;
+
 	/*
 	 * Careful: new_folio is not a "real" folio before we cleared PageTail.
 	 * Don't pass it around before clear_compound_head().
@@ -3227,8 +3228,10 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 		VM_WARN_ON_ONCE_PAGE(true, page_tail);
 		page_tail->private = 0;
 	}
-	if (folio_test_swapcache(folio))
+	if (folio_test_swapcache(folio)) {
 		new_folio->swap.val = folio->swap.val + tail;
+		vswap_split_huge_page(folio, new_folio);
+	}
 
 	/* Page flags must be visible before we make the page non-compound. */
 	smp_wmb();
diff --git a/mm/internal.h b/mm/internal.h
index ca28729f822a..51061691a731 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -268,17 +268,12 @@ static inline swp_entry_t swap_nth(swp_entry_t entry, long n)
 	return (swp_entry_t) { entry.val + n };
 }
 
-/* similar to swap_nth, but check the backing physical slots as well. */
+/* temporary disallow batched swap operations */
 static inline swp_entry_t swap_move(swp_entry_t entry, long delta)
 {
-	swp_slot_t slot = swp_entry_to_swp_slot(entry), next_slot;
-	swp_entry_t next_entry = swap_nth(entry, delta);
-
-	next_slot = swp_entry_to_swp_slot(next_entry);
-	if (swp_slot_type(slot) != swp_slot_type(next_slot) ||
-			swp_slot_offset(slot) + delta != swp_slot_offset(next_slot))
-		next_entry.val = 0;
+	swp_entry_t next_entry;
 
+	next_entry.val = 0;
 	return next_entry;
 }
 #else
@@ -349,6 +344,8 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
  * max_nr must be at least one and must be limited by the caller so scanning
  * cannot exceed a single page table.
  *
+ * Note that for virtual swap space, we will not batch anything for now.
+ *
  * Return: the number of table entries in the batch.
  */
 static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
@@ -363,6 +360,9 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 	VM_WARN_ON(!is_swap_pte(pte));
 	VM_WARN_ON(non_swap_entry(entry));
 
+	if (IS_ENABLED(CONFIG_VIRTUAL_SWAP))
+		return 1;
+
 	cgroup_id = lookup_swap_cgroup_id(entry);
 	while (ptep < end_ptep) {
 		pte = ptep_get(ptep);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a037ec92881d..126b2d0e6aaa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5095,10 +5095,23 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	rcu_read_unlock();
 }
 
+static bool mem_cgroup_may_zswap(struct mem_cgroup *original_memcg);
+
 long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
-	long nr_swap_pages = get_nr_swap_pages();
+	long nr_swap_pages, nr_zswap_pages = 0;
+
+	/*
+	 * If swap is virtualized and zswap is enabled, we can still use zswap even
+	 * if there is no space left in any swap file/partition.
+	 */
+	if (IS_ENABLED(CONFIG_VIRTUAL_SWAP) && zswap_is_enabled() &&
+			(mem_cgroup_disabled() || do_memsw_account() ||
+				mem_cgroup_may_zswap(memcg))) {
+		nr_zswap_pages = PAGE_COUNTER_MAX;
+	}
 
+	nr_swap_pages = max_t(long, nr_zswap_pages, get_nr_swap_pages());
 	if (mem_cgroup_disabled() || do_memsw_account())
 		return nr_swap_pages;
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
@@ -5267,6 +5280,29 @@ static struct cftype swap_files[] = {
 };
 
 #ifdef CONFIG_ZSWAP
+static bool mem_cgroup_may_zswap(struct mem_cgroup *original_memcg)
+{
+	struct mem_cgroup *memcg;
+
+	for (memcg = original_memcg; !mem_cgroup_is_root(memcg);
+	     memcg = parent_mem_cgroup(memcg)) {
+		unsigned long max = READ_ONCE(memcg->zswap_max);
+		unsigned long pages;
+
+		if (max == PAGE_COUNTER_MAX)
+			continue;
+		if (max == 0)
+			return false;
+
+		/* Force flush to get accurate stats for charging */
+		__mem_cgroup_flush_stats(memcg, true);
+		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
+		if (pages >= max)
+			return false;
+	}
+	return true;
+}
+
 /**
  * obj_cgroup_may_zswap - check if this cgroup can zswap
  * @objcg: the object cgroup
@@ -5281,34 +5317,15 @@ static struct cftype swap_files[] = {
  */
 bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 {
-	struct mem_cgroup *memcg, *original_memcg;
+	struct mem_cgroup *memcg;
 	bool ret = true;
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return true;
 
-	original_memcg = get_mem_cgroup_from_objcg(objcg);
-	for (memcg = original_memcg; !mem_cgroup_is_root(memcg);
-	     memcg = parent_mem_cgroup(memcg)) {
-		unsigned long max = READ_ONCE(memcg->zswap_max);
-		unsigned long pages;
-
-		if (max == PAGE_COUNTER_MAX)
-			continue;
-		if (max == 0) {
-			ret = false;
-			break;
-		}
-
-		/* Force flush to get accurate stats for charging */
-		__mem_cgroup_flush_stats(memcg, true);
-		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
-		if (pages < max)
-			continue;
-		ret = false;
-		break;
-	}
-	mem_cgroup_put(original_memcg);
+	memcg = get_mem_cgroup_from_objcg(objcg);
+	ret = mem_cgroup_may_zswap(memcg);
+	mem_cgroup_put(memcg);
 	return ret;
 }
 
@@ -5452,6 +5469,11 @@ static struct cftype zswap_files[] = {
 	},
 	{ }	/* terminate */
 };
+#else
+static inline bool mem_cgroup_may_zswap(struct mem_cgroup *original_memcg)
+{
+	return false;
+}
 #endif /* CONFIG_ZSWAP */
 
 static int __init mem_cgroup_swap_init(void)
diff --git a/mm/memory.c b/mm/memory.c
index a1d3631ad85f..c5c34efafa81 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4226,8 +4226,10 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	 * A large swapped out folio could be partially or fully in zswap. We
 	 * lack handling for such cases, so fallback to swapping in order-0
 	 * folio.
+	 *
+	 * We also disable THP swapin on the virtual swap implementation, for now.
 	 */
-	if (!zswap_never_enabled())
+	if (!zswap_never_enabled() || IS_ENABLED(CONFIG_VIRTUAL_SWAP))
 		goto fallback;
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
@@ -4305,12 +4307,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct folio *swapcache, *folio = NULL;
 	DECLARE_WAITQUEUE(wait, current);
 	struct page *page;
-	struct swap_info_struct *si = NULL;
+	struct swap_info_struct *si = NULL, *stable_si;
 	rmap_t rmap_flags = RMAP_NONE;
 	bool need_clear_cache = false;
 	bool swapoff_locked = false;
 	bool exclusive = false;
-	swp_entry_t entry;
+	swp_entry_t orig_entry, entry;
 	swp_slot_t slot;
 	pte_t pte;
 	vm_fault_t ret = 0;
@@ -4324,6 +4326,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out;
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
+	/*
+	 * entry might change if we get a large folio - remember the original entry
+	 * for unlocking swapoff etc.
+	 */
+	orig_entry = entry;
 	if (unlikely(non_swap_entry(entry))) {
 		if (is_migration_entry(entry)) {
 			migration_entry_wait(vma->vm_mm, vmf->pmd,
@@ -4381,7 +4388,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swapcache = folio;
 
 	if (!folio) {
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
+		if (si && data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
 			/* skip swapcache */
 			folio = alloc_swap_folio(vmf);
@@ -4591,27 +4598,43 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 * swapcache -> certainly exclusive.
 			 */
 			exclusive = true;
-		} else if (exclusive && folio_test_writeback(folio) &&
-			  data_race(si->flags & SWP_STABLE_WRITES)) {
+		} else if (exclusive && folio_test_writeback(folio)) {
 			/*
-			 * This is tricky: not all swap backends support
-			 * concurrent page modifications while under writeback.
-			 *
-			 * So if we stumble over such a page in the swapcache
-			 * we must not set the page exclusive, otherwise we can
-			 * map it writable without further checks and modify it
-			 * while still under writeback.
-			 *
-			 * For these problematic swap backends, simply drop the
-			 * exclusive marker: this is perfectly fine as we start
-			 * writeback only if we fully unmapped the page and
-			 * there are no unexpected references on the page after
-			 * unmapping succeeded. After fully unmapped, no
-			 * further GUP references (FOLL_GET and FOLL_PIN) can
-			 * appear, so dropping the exclusive marker and mapping
-			 * it only R/O is fine.
+			 * We need to look up the swap device again here, for the virtual
+			 * swap case. The si we got from trylock_swapoff() is not
+			 * guaranteed to be stable, as at that time we have not pinned
+			 * the virtual swap slot's backing storage. With the folio locked
+			 * and loaded into the swap cache, we can now guarantee a stable
+			 * backing state.
 			 */
-			exclusive = false;
+			if (IS_ENABLED(CONFIG_VIRTUAL_SWAP))
+				stable_si = vswap_get_device(entry);
+			else
+				stable_si = si;
+			if (stable_si && data_race(stable_si->flags & SWP_STABLE_WRITES)) {
+				/*
+				 * This is tricky: not all swap backends support
+				 * concurrent page modifications while under writeback.
+				 *
+				 * So if we stumble over such a page in the swapcache
+				 * we must not set the page exclusive, otherwise we can
+				 * map it writable without further checks and modify it
+				 * while still under writeback.
+				 *
+				 * For these problematic swap backends, simply drop the
+				 * exclusive marker: this is perfectly fine as we start
+				 * writeback only if we fully unmapped the page and
+				 * there are no unexpected references on the page after
+				 * unmapping succeeded. After fully unmapped, no
+				 * further GUP references (FOLL_GET and FOLL_PIN) can
+				 * appear, so dropping the exclusive marker and mapping
+				 * it only R/O is fine.
+				 */
+				exclusive = false;
+			}
+
+			if (IS_ENABLED(CONFIG_VIRTUAL_SWAP) && stable_si)
+				swap_slot_put_swap_info(stable_si);
 		}
 	}
 
@@ -4720,7 +4743,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			wake_up(&swapcache_wq);
 	}
 	if (swapoff_locked)
-		unlock_swapoff(entry, si);
+		unlock_swapoff(orig_entry, si);
 	return ret;
 out_nomap:
 	if (vmf->pte)
@@ -4739,7 +4762,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			wake_up(&swapcache_wq);
 	}
 	if (swapoff_locked)
-		unlock_swapoff(entry, si);
+		unlock_swapoff(orig_entry, si);
 	return ret;
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 97f0edf0c032..3a2cf62f47ea 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -523,6 +523,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	if (folio_test_swapcache(folio)) {
 		folio_set_swapcache(newfolio);
 		newfolio->private = folio_get_private(folio);
+		vswap_migrate(folio, newfolio);
 		entries = nr;
 	} else {
 		entries = 1;
diff --git a/mm/page_io.c b/mm/page_io.c
index 182851c47f43..83fc4a466db8 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -201,6 +201,12 @@ static bool is_folio_zero_filled(struct folio *folio)
 	return true;
 }
 
+#ifdef CONFIG_VIRTUAL_SWAP
+static void swap_zeromap_folio_clear(struct folio *folio)
+{
+	vswap_store_folio(folio->swap, folio);
+}
+#else
 static void swap_zeromap_folio_set(struct folio *folio)
 {
 	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
@@ -238,6 +244,7 @@ static void swap_zeromap_folio_clear(struct folio *folio)
 		clear_bit(swp_slot_offset(slot), sis->zeromap);
 	}
 }
+#endif /* CONFIG_VIRTUAL_SWAP */
 
 /*
  * We may have stale swap cache pages in memory: notice
@@ -246,6 +253,7 @@ static void swap_zeromap_folio_clear(struct folio *folio)
 int swap_writepage(struct page *page, struct writeback_control *wbc)
 {
 	struct folio *folio = page_folio(page);
+	swp_slot_t slot;
 	int ret;
 
 	if (folio_free_swap(folio)) {
@@ -275,9 +283,8 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		return 0;
 	} else {
 		/*
-		 * Clear bits this folio occupies in the zeromap to prevent
-		 * zero data being read in from any previous zero writes that
-		 * occupied the same swap entries.
+		 * Clear the zeromap state to prevent zero data being read in from any
+		 * previous zero writes that occupied the same swap entries.
 		 */
 		swap_zeromap_folio_clear(folio);
 	}
@@ -291,6 +298,13 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		return AOP_WRITEPAGE_ACTIVATE;
 	}
 
+	/* fall back to physical swap device */
+	slot = vswap_alloc_swap_slot(folio);
+	if (!slot.val) {
+		folio_mark_dirty(folio);
+		return AOP_WRITEPAGE_ACTIVATE;
+	}
+
 	__swap_writepage(folio, wbc);
 	return 0;
 }
@@ -624,14 +638,11 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 
 void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
-	struct swap_info_struct *sis =
-		swap_slot_swap_info(swp_entry_to_swp_slot(folio->swap));
-	bool synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
-	bool workingset = folio_test_workingset(folio);
+	struct swap_info_struct *sis;
+	bool synchronous, workingset = folio_test_workingset(folio);
 	unsigned long pflags;
 	bool in_thrashing;
 
-	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
 
@@ -657,6 +668,10 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	/* We have to read from slower devices. Increase zswap protection. */
 	zswap_folio_swapin(folio);
 
+	sis = swap_slot_swap_info(swp_entry_to_swp_slot(folio->swap));
+	synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
+	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, folio);
+
 	if (data_race(sis->flags & SWP_FS_OPS)) {
 		swap_read_folio_fs(folio, plug);
 	} else if (synchronous) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 4c00b4673468..609971a2b365 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1404,7 +1404,7 @@ static int shmem_find_swap_entries(struct address_space *mapping,
 		 * swapin error entries can be found in the mapping. But they're
 		 * deliberately ignored here as we've done everything we can do.
 		 */
-		if (swp_slot_type(slot) != type)
+		if (!slot.val || swp_slot_type(slot) != type)
 			continue;
 
 		indices[folio_batch_count(fbatch)] = xas.xa_index;
@@ -1554,7 +1554,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	if ((info->flags & VM_LOCKED) || sbinfo->noswap)
 		goto redirty;
 
-	if (!total_swap_pages)
+	if (!IS_ENABLED(CONFIG_VIRTUAL_SWAP) && !total_swap_pages)
 		goto redirty;
 
 	/*
@@ -2295,7 +2295,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			fallback_order0 = true;
 
 		/* Skip swapcache for synchronous device. */
-		if (!fallback_order0 && data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
+		if (!fallback_order0 && si &&
+				  data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
 			folio = shmem_swap_alloc_folio(inode, vma, index, swap, order, gfp);
 			if (!IS_ERR(folio)) {
 				skip_swapcache = true;
diff --git a/mm/swap.h b/mm/swap.h
index 31c94671cb44..411282d08a15 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -86,9 +86,18 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	swp_slot_t swp_slot = swp_entry_to_swp_slot(folio->swap);
 
+	/*
+	 * In the virtual swap implementation, the folio might not be backed by any
+	 * physical swap slots (for e.g zswap-backed only).
+	 */
+	if (!swp_slot.val)
+		return 0;
 	return swap_slot_swap_info(swp_slot)->flags;
 }
 
+#ifdef CONFIG_VIRTUAL_SWAP
+int swap_zeromap_batch(swp_entry_t entry, int max_nr, bool *is_zeromap);
+#else
 /*
  * Return the count of contiguous swap entries that share the same
  * zeromap status as the starting entry. If is_zeromap is not NULL,
@@ -114,6 +123,7 @@ static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 	else
 		return find_next_bit(sis->zeromap, end, start) - start;
 }
+#endif
 
 #else /* CONFIG_SWAP */
 struct swap_iocb;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index eb4cd6ba2068..3a549c4583e9 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -494,6 +494,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 
 	for (;;) {
 		int err;
+
 		/*
 		 * First check the swap cache.  Since this is normally
 		 * called after swap_cache_get_folio() failed, re-calling
@@ -531,8 +532,20 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * Swap entry may have been freed since our caller observed it.
 		 */
 		err = swapcache_prepare(entry, 1);
-		if (!err)
+		if (!err) {
+			/* This might be invoked by swap_cluster_readahead(), which can
+			 * race with shmem_swapin_folio(). The latter might have already
+			 * called delete_from_swap_cache(), allowing swapcache_prepare()
+			 * to succeed here. This can lead to reading bogus data to populate
+			 * the page. To prevent this, skip folio-backed virtual swap slots,
+			 * and let caller retry if necessary.
+			 */
+			if (vswap_folio_backed(entry, 1)) {
+				swapcache_clear(si, entry, 1);
+				goto put_and_return;
+			}
 			break;
+		}
 		else if (err != -EEXIST)
 			goto put_and_return;
 
@@ -715,6 +728,14 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	struct swap_iocb *splug = NULL;
 	bool page_allocated;
 
+	/*
+	 * If swap is virtualized, the swap entry might not be backed by any
+	 * physical swap slot. In that case, just skip readahead and bring in the
+	 * target entry.
+	 */
+	if (!slot.val)
+		goto skip;
+
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
 		goto skip;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index babb545acffd..59b34d51b16b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1165,16 +1165,22 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	unsigned long begin = offset;
 	unsigned long end = offset + nr_entries - 1;
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
+#ifndef CONFIG_VIRTUAL_SWAP
 	unsigned int i;
 
 	/*
 	 * Use atomic clear_bit operations only on zeromap instead of non-atomic
 	 * bitmap_clear to prevent adjacent bits corruption due to simultaneous writes.
+	 *
+	 * Note that in the virtual swap implementation, we do not need to perform
+	 * these operations, since zswap and zero-filled pages are not backed by
+	 * physical swapfile.
 	 */
 	for (i = 0; i < nr_entries; i++) {
 		clear_bit(offset + i, si->zeromap);
 		zswap_invalidate(swp_slot_to_swp_entry(swp_slot(si->type, offset + i)));
 	}
+#endif
 
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
@@ -1639,43 +1645,35 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
 {
 	swap_slot_free_nr(swp_entry_to_swp_slot(entry), nr_pages);
 }
-#endif
 
 /*
  * This should only be called in contexts in which the slot has
  * been allocated but not associated with any swap entries.
  */
-void swap_slot_put_folio(swp_slot_t slot, struct folio *folio)
+void put_swap_folio(struct folio *folio, swp_entry_t entry)
 {
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
 	unsigned long offset = swp_slot_offset(slot);
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
 	int size = 1 << swap_slot_order(folio_order(folio));
-	unsigned char usage;
 
 	si = _swap_info_get(slot);
 	if (!si)
 		return;
 
-#ifdef CONFIG_VIRTUAL_SWAP
-	usage = SWAP_MAP_ALLOCATED;
-#else
-	usage = SWAP_HAS_CACHE;
-#endif
-
 	ci = lock_cluster(si, offset);
 	if (swap_is_has_cache(si, offset, size))
 		swap_slot_range_free(si, ci, slot, size);
 	else {
 		for (int i = 0; i < size; i++, slot.val++) {
-			if (!__swap_slot_free_locked(si, offset + i, usage))
+			if (!__swap_slot_free_locked(si, offset + i, SWAP_HAS_CACHE))
 				swap_slot_range_free(si, ci, slot, 1);
 		}
 	}
 	unlock_cluster(ci);
 }
 
-#ifndef CONFIG_VIRTUAL_SWAP
 int __swap_count(swp_entry_t entry)
 {
 	swp_slot_t slot = swp_entry_to_swp_slot(entry);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c767d71c43d7..db4178bf5f6f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -341,10 +341,15 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 {
 	if (memcg == NULL) {
 		/*
-		 * For non-memcg reclaim, is there
-		 * space in any swap device?
+		 * For non-memcg reclaim:
+		 *
+		 * If swap is virtualized, we can still use zswap even if there is no
+		 * space left in any swap file/partition.
+		 *
+		 * Otherwise, check if there is space in any swap device?
 		 */
-		if (get_nr_swap_pages() > 0)
+		if ((IS_ENABLED(CONFIG_VIRTUAL_SWAP) && zswap_is_enabled()) ||
+				get_nr_swap_pages() > 0)
 			return true;
 	} else {
 		/* Is the memcg below its swap limit? */
@@ -2611,12 +2616,15 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 static bool can_age_anon_pages(struct pglist_data *pgdat,
 			       struct scan_control *sc)
 {
-	/* Aging the anon LRU is valuable if swap is present: */
-	if (total_swap_pages > 0)
-		return true;
-
-	/* Also valuable if anon pages can be demoted: */
-	return can_demote(pgdat->node_id, sc);
+	/*
+	 * Aging the anon LRU is valuable if:
+	 * 1. Swap is virtualized and zswap is enabled.
+	 * 2. There are physical swap slots available.
+	 * 3. Anon pages can be demoted
+	 */
+	return (IS_ENABLED(CONFIG_VIRTUAL_SWAP) && zswap_is_enabled()) ||
+			total_swap_pages > 0 ||
+			can_demote(pgdat->node_id, sc);
 }
 
 #ifdef CONFIG_LRU_GEN
diff --git a/mm/vswap.c b/mm/vswap.c
index 8a518ebd20e4..3146c231ca69 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -34,9 +34,33 @@
  * about to be added to the swap cache). Its reference count is incremented or
  * decremented every time it is mapped to or unmapped from a PTE, as well as
  * when it is added to or removed from the swap cache. Finally, when its
- * reference count reaches 0, the virtual swap slot is freed.
+ * reference count reaches 0, the virtual swap slot is freed, and its backing
+ * store released.
+ *
+ *
+ * II. Backing State
+ *
+ * Each virtual swap slot be backed by:
+ *
+ * 1. A slot on a physical swap device (i.e a swapfile or a swap partition).
+ * 2. A swapped out zero-filled page.
+ * 3. A compressed object in zswap.
+ * 4. An in-memory folio, that is not backed by neither a physical swap device
+ *    nor zswap (i.e only in swap cache). This is used for pages that are
+ *    rejected by zswap, but not (yet) backed by a physical swap device,
+ *    (for e.g, due to zswap.writeback = 0), or for pages that were previously
+ *    stored in zswap, but has since been loaded back into memory (and has its
+ *    zswap copy invalidated).
  */
 
+/* The backing state options of a virtual swap slot */
+enum swap_type {
+	VSWAP_SWAPFILE,
+	VSWAP_ZERO,
+	VSWAP_ZSWAP,
+	VSWAP_FOLIO
+};
+
 /**
  * Swap descriptor - metadata of a swapped out page.
  *
@@ -44,7 +68,11 @@
  * @slot: The handle to the physical swap slot backing this page.
  * @rcu: The RCU head to free the descriptor with an RCU grace period.
  * @lock: The lock protecting the swap slot backing field.
+ * @folio: The folio that backs the virtual swap slot.
+ * @zswap_entry: The zswap entry that backs the virtual swap slot.
+ * @lock: The lock protecting the swap slot backing fields.
  * @memcgid: The memcg id of the owning memcg, if any.
+ * @type: The backing store type of the swap entry.
  * @in_swapcache: whether the swapped out page is currently in swap cache.
  *                This flag is also used to establish the primary owner of
  *                the swap page in many cases.
@@ -55,10 +83,15 @@
  */
 struct swp_desc {
 	swp_entry_t vswap;
-	swp_slot_t slot;
+	union {
+		swp_slot_t slot;
+		struct folio *folio;
+		struct zswap_entry *zswap_entry;
+	};
 	struct rcu_head rcu;
 
 	rwlock_t lock;
+	enum swap_type type;
 
 #ifdef CONFIG_MEMCG
 	atomic_t memcgid;
@@ -159,6 +192,7 @@ static swp_entry_t vswap_alloc(int nr)
 	}
 
 	for (i = 0; i < nr; i++) {
+		descs[i]->type = VSWAP_SWAPFILE;
 		descs[i]->slot.val = 0;
 		atomic_set(&descs[i]->memcgid, 0);
 		atomic_set(&descs[i]->swap_count, 0);
@@ -250,6 +284,74 @@ static inline void release_vswap_slot(unsigned long index)
 	atomic_dec(&vswap_used);
 }
 
+/*
+ * Caller enters with swap descriptor unlocked, but needs to handle races with
+ * other operations themselves.
+ *
+ * For instance, this function is safe to be called in contexts where the swap
+ * entry has been added to the swap cache and the associated folio is locked.
+ * We cannot race with other accessors, and the swap entry is guaranteed to be
+ * valid the whole time (since in_swapcache status implies one reference
+ * count).
+ *
+ * We also need to make sure the backing state of the entire range matches.
+ * This is usually already checked by upstream callers.
+ */
+static inline void release_backing(swp_entry_t entry, int nr)
+{
+	swp_slot_t slot = (swp_slot_t){0};
+	struct swap_info_struct *si;
+	struct folio *folio = NULL;
+	enum swap_type type;
+	struct swp_desc *desc;
+	int i = 0;
+
+	VM_WARN_ON(!entry.val);
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		VM_WARN_ON(!desc);
+		write_lock(&desc->lock);
+		if (!i) {
+			type = desc->type;
+			if (type == VSWAP_FOLIO)
+				folio = desc->folio;
+			else if (type == VSWAP_SWAPFILE)
+				slot = desc->slot;
+		} else {
+			VM_WARN_ON(type != desc->type);
+			VM_WARN_ON(type == VSWAP_FOLIO && desc->folio != folio);
+			VM_WARN_ON(type == VSWAP_SWAPFILE && slot.val &&
+				desc->slot.val != slot.val + i);
+		}
+
+		if (desc->type == VSWAP_ZSWAP)
+			zswap_invalidate((swp_entry_t){entry.val + i});
+		else if (desc->type == VSWAP_SWAPFILE) {
+			if (desc->slot.val) {
+				xa_erase(&vswap_rmap, desc->slot.val);
+				desc->slot.val = 0;
+			}
+		}
+		write_unlock(&desc->lock);
+		i++;
+	}
+	rcu_read_unlock();
+
+	if (slot.val) {
+		si = swap_slot_tryget_swap_info(slot);
+		if (si) {
+			swap_slot_free_nr(slot, nr);
+			swap_slot_put_swap_info(si);
+		}
+	}
+}
+
 /**
  * vswap_free - free a virtual swap slot.
  * @id: the virtual swap slot to free
@@ -261,20 +363,11 @@ static void vswap_free(swp_entry_t entry)
 	if (!entry.val)
 		return;
 
-	/* do not immediately erase the virtual slot to prevent its reuse */
 	desc = xa_load(&vswap_map, entry.val);
-	if (!desc)
-		return;
 
 	virt_clear_shadow_from_swap_cache(entry);
-
-	if (desc->slot.val) {
-		/* we only charge after linkage was established */
-		mem_cgroup_uncharge_swap(entry, 1);
-		xa_erase(&vswap_rmap, desc->slot.val);
-		swap_slot_free_nr(desc->slot, 1);
-	}
-
+	release_backing(entry, 1);
+	mem_cgroup_uncharge_swap(entry, 1);
 	/* erase forward mapping and release the virtual slot for reallocation */
 	release_vswap_slot(entry.val);
 	kfree_rcu(desc, rcu);
@@ -288,34 +381,78 @@ static void vswap_ref_release(struct kref *refcnt)
 }
 
 /**
- * folio_alloc_swap - allocate virtual swap slots for a folio.
- * @folio: the folio.
+ * folio_alloc_swap - allocate virtual swap slots for a folio, and
+ *                    set their backing store to the folio.
+ * @folio: the folio to allocate virtual swap slots for.
  *
  * Return: the first allocated slot if success, or the zero virtuals swap slot
  * on failure.
  */
 swp_entry_t folio_alloc_swap(struct folio *folio)
 {
-	int i, err, nr = folio_nr_pages(folio);
-	bool manual_freeing = true;
-	struct swp_desc *desc;
 	swp_entry_t entry;
-	swp_slot_t slot;
+	struct swp_desc *desc;
+	int i, nr = folio_nr_pages(folio);
 
 	entry = vswap_alloc(nr);
 	if (!entry.val)
 		return entry;
 
 	/*
-	 * XXX: for now, we always allocate a physical swap slot for each virtual
-	 * swap slot, and their lifetime are coupled. This will change once we
-	 * decouple virtual swap slots from their backing states, and only allocate
-	 * physical swap slots for them on demand (i.e on zswap writeback, or
-	 * fallback from zswap store failure).
+	 * XXX: for now, we charge towards the memory cgroup's swap limit on virtual
+	 * swap slots allocation. This will be changed soon - we will only charge on
+	 * physical swap slots allocation.
 	 */
+	if (mem_cgroup_try_charge_swap(folio, entry)) {
+		for (i = 0; i < nr; i++) {
+			vswap_free(entry);
+			entry.val++;
+		}
+		atomic_add(nr, &vswap_alloc_reject);
+		entry.val = 0;
+		return entry;
+	}
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		desc->folio = folio;
+		desc->type = VSWAP_FOLIO;
+	}
+	rcu_read_unlock();
+	return entry;
+}
+
+/**
+ * vswap_alloc_swap_slot - allocate physical swap space for a folio that is
+ *                         already associated with virtual swap slots.
+ * @folio: folio we want to allocate physical swap space for.
+ *
+ * Return: the first allocated physical swap slot, if succeeds.
+ */
+swp_slot_t vswap_alloc_swap_slot(struct folio *folio)
+{
+	int i, err, nr = folio_nr_pages(folio);
+	swp_slot_t slot = { .val = 0 };
+	swp_entry_t entry = folio->swap;
+	struct swp_desc *desc;
+	bool fallback = false;
+
+	/*
+	 * We might have already allocated a backing physical swap slot in past
+	 * attempts (for instance, when we disable zswap).
+	 */
+	slot = swp_entry_to_swp_slot(entry);
+	if (slot.val)
+		return slot;
+
 	slot = folio_alloc_swap_slot(folio);
 	if (!slot.val)
-		goto vswap_free;
+		return slot;
 
 	/* establish the vrtual <-> physical swap slots linkages. */
 	for (i = 0; i < nr; i++) {
@@ -325,7 +462,13 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 		if (err) {
 			while (--i >= 0)
 				xa_erase(&vswap_rmap, slot.val + i);
-			goto put_physical_swap;
+			/*
+			 * We have not updated the backing type of the virtual swap slot.
+			 * Simply free up the physical swap slots here!
+			 */
+			swap_slot_free_nr(slot, nr);
+			slot.val = 0;
+			return slot;
 		}
 	}
 
@@ -337,36 +480,31 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 		if (xas_retry(&xas, desc))
 			continue;
 
+		write_lock(&desc->lock);
+		if (desc->type == VSWAP_FOLIO) {
+			/* case 1: fallback from zswap store failure */
+			fallback = true;
+			if (!folio)
+				folio = desc->folio;
+			else
+				VM_WARN_ON(folio != desc->folio);
+		} else {
+			/*
+			 * Case 2: zswap writeback.
+			 *
+			 * No need to free zswap entry here - it will be freed once zswap
+			 * writeback suceeds.
+			 */
+			VM_WARN_ON(desc->type != VSWAP_ZSWAP);
+			VM_WARN_ON(fallback);
+		}
+		desc->type = VSWAP_SWAPFILE;
 		desc->slot.val = slot.val + i;
+		write_unlock(&desc->lock);
 		i++;
 	}
 	rcu_read_unlock();
-
-	manual_freeing = false;
-	/*
-	 * XXX: for now, we charge towards the memory cgroup's swap limit on virtual
-	 * swap slots allocation. This is acceptable because as noted above, each
-	 * virtual swap slot corresponds to a physical swap slot. Once we have
-	 * decoupled virtual and physical swap slots, we will only charge when we
-	 * actually allocate a physical swap slot.
-	 */
-	if (!mem_cgroup_try_charge_swap(folio, entry))
-		return entry;
-
-put_physical_swap:
-	/*
-	 * There is no any linkage between virtual and physical swap slots yet. We
-	 * have to manually and separately free the allocated virtual and physical
-	 * swap slots.
-	 */
-	swap_slot_put_folio(slot, folio);
-vswap_free:
-	if (manual_freeing) {
-		for (i = 0; i < nr; i++)
-			vswap_free((swp_entry_t){entry.val + i});
-	}
-	entry.val = 0;
-	return entry;
+	return slot;
 }
 
 /**
@@ -374,7 +512,9 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
  *                         virtual swap slot.
  * @entry: the virtual swap slot.
  *
- * Return: the physical swap slot corresponding to the virtual swap slot.
+ * Return: the physical swap slot corresponding to the virtual swap slot, if
+ * exists, or the zero physical swap slot if the virtual swap slot is not
+ * backed by any physical slot on a swapfile.
  */
 swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
 {
@@ -392,7 +532,10 @@ swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
 	}
 
 	read_lock(&desc->lock);
-	slot = desc->slot;
+	if (desc->type != VSWAP_SWAPFILE)
+		slot = (swp_slot_t){0};
+	else
+		slot = desc->slot;
 	read_unlock(&desc->lock);
 	rcu_read_unlock();
 
@@ -729,6 +872,286 @@ int non_swapcache_batch(swp_entry_t entry, int max_nr)
 	return i;
 }
 
+/**
+ * vswap_split_huge_page - update a subpage's swap descriptor to point to the
+ *                         recently split out subpage folio descriptor.
+ * @head: the original head's folio descriptor.
+ * @subpage: the subpage's folio descriptor.
+ */
+void vswap_split_huge_page(struct folio *head, struct folio *subpage)
+{
+	struct swp_desc *desc = xa_load(&vswap_map, subpage->swap.val);
+
+	write_lock(&desc->lock);
+	if (desc->type == VSWAP_FOLIO) {
+		VM_WARN_ON(desc->folio != head);
+		desc->folio = subpage;
+	}
+	write_unlock(&desc->lock);
+}
+
+/**
+ * vswap_migrate - update the swap entries of the original folio to refer to
+ *                 the new folio for migration.
+ * @old: the old folio.
+ * @new: the new folio.
+ */
+void vswap_migrate(struct folio *src, struct folio *dst)
+{
+	long nr = folio_nr_pages(src), nr_folio_backed = 0;
+	struct swp_desc *desc;
+
+	VM_WARN_ON(!folio_test_locked(src));
+	VM_WARN_ON(!folio_test_swapcache(src));
+
+	XA_STATE(xas, &vswap_map, src->swap.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, src->swap.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		write_lock(&desc->lock);
+		if (desc->type == VSWAP_FOLIO) {
+			VM_WARN_ON(desc->folio != src);
+			desc->folio = dst;
+			nr_folio_backed++;
+		}
+		write_unlock(&desc->lock);
+	}
+	rcu_read_unlock();
+
+	/* we should not see mixed backing states for swap entries in swap cache */
+	VM_WARN_ON(nr_folio_backed && nr_folio_backed != nr);
+}
+
+/**
+ * vswap_store_folio - set a folio as the backing of a range of virtual swap
+ *                     slots.
+ * @entry: the first virtual swap slot in the range.
+ * @folio: the folio.
+ */
+void vswap_store_folio(swp_entry_t entry, struct folio *folio)
+{
+	int nr = folio_nr_pages(folio);
+	struct swp_desc *desc;
+
+	VM_BUG_ON(!folio_test_locked(folio));
+	VM_BUG_ON(folio->swap.val != entry.val);
+
+	release_backing(entry, nr);
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		write_lock(&desc->lock);
+		desc->type = VSWAP_FOLIO;
+		desc->folio = folio;
+		write_unlock(&desc->lock);
+	}
+	rcu_read_unlock();
+}
+
+/**
+ * vswap_assoc_zswap - associate a virtual swap slot to a zswap entry.
+ * @entry: the virtual swap slot.
+ * @zswap_entry: the zswap entry.
+ */
+void vswap_assoc_zswap(swp_entry_t entry, struct zswap_entry *zswap_entry)
+{
+	struct swp_desc *desc;
+
+	release_backing(entry, 1);
+
+	desc = xa_load(&vswap_map, entry.val);
+	write_lock(&desc->lock);
+	desc->type = VSWAP_ZSWAP;
+	desc->zswap_entry = zswap_entry;
+	write_unlock(&desc->lock);
+}
+
+/**
+ * swap_zeromap_folio_set - mark a range of virtual swap slots corresponding to
+ *                          a folio as zero-filled.
+ * @folio: the folio
+ */
+void swap_zeromap_folio_set(struct folio *folio)
+{
+	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
+	swp_entry_t entry = folio->swap;
+	int nr = folio_nr_pages(folio);
+	struct swp_desc *desc;
+
+	VM_BUG_ON(!folio_test_locked(folio));
+	VM_BUG_ON(!entry.val);
+
+	release_backing(entry, nr);
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		write_lock(&desc->lock);
+		desc->type = VSWAP_ZERO;
+		write_unlock(&desc->lock);
+	}
+	rcu_read_unlock();
+
+	count_vm_events(SWPOUT_ZERO, nr);
+	if (objcg) {
+		count_objcg_events(objcg, SWPOUT_ZERO, nr);
+		obj_cgroup_put(objcg);
+	}
+}
+
+/*
+ * Iterate through the entire range of virtual swap slots, returning the
+ * longest contiguous range of slots starting from the first slot that satisfies:
+ *
+ * 1. If the first slot is zero-mapped, the entire range should be
+ *    zero-mapped.
+ * 2. If the first slot is backed by a swapfile, the entire range should
+ *    be backed by a range of contiguous swap slots on the same swapfile.
+ * 3. If the first slot is zswap-backed, the entire range should be
+ *    zswap-backed.
+ * 4. If the first slot is backed by a folio, the entire range should
+ *    be backed by the same folio.
+ *
+ * Note that this check is racy unless we can ensure that the entire range
+ * has their backing state stable - for instance, if the caller was the one
+ * who set the in_swapcache flag of the entire field.
+ */
+static int vswap_check_backing(swp_entry_t entry, enum swap_type *type, int nr)
+{
+	unsigned int swapfile_type;
+	enum swap_type first_type;
+	struct swp_desc *desc;
+	pgoff_t first_offset;
+	struct folio *folio;
+	int i = 0;
+
+	if (!entry.val || non_swap_entry(entry))
+		return 0;
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		if (!desc)
+			goto done;
+
+		read_lock(&desc->lock);
+		if (!i) {
+			first_type = desc->type;
+			if (first_type == VSWAP_SWAPFILE) {
+				swapfile_type = swp_slot_type(desc->slot);
+				first_offset = swp_slot_offset(desc->slot);
+			} else if (first_type == VSWAP_FOLIO) {
+				folio = desc->folio;
+			}
+		} else if (desc->type != first_type) {
+			read_unlock(&desc->lock);
+			goto done;
+		} else if (first_type == VSWAP_SWAPFILE &&
+				(swp_slot_type(desc->slot) != swapfile_type ||
+					swp_slot_offset(desc->slot) != first_offset + i)) {
+			read_unlock(&desc->lock);
+			goto done;
+		} else if (first_type == VSWAP_FOLIO && desc->folio != folio) {
+			read_unlock(&desc->lock);
+			goto done;
+		}
+		read_unlock(&desc->lock);
+		i++;
+	}
+done:
+	rcu_read_unlock();
+	if (type)
+		*type = first_type;
+	return i;
+}
+
+/**
+ * vswap_disk_backed - check if the virtual swap slots are backed by physical
+ *                     swap slots.
+ * @entry: the first entry in the range.
+ * @nr: the number of entries in the range.
+ */
+bool vswap_disk_backed(swp_entry_t entry, int nr)
+{
+	enum swap_type type;
+
+	return vswap_check_backing(entry, &type, nr) == nr
+				&& type == VSWAP_SWAPFILE;
+}
+
+/**
+ * vswap_folio_backed - check if the virtual swap slots are backed by in-memory
+ *                      pages.
+ * @entry: the first virtual swap slot in the range.
+ * @nr: the number of slots in the range.
+ */
+bool vswap_folio_backed(swp_entry_t entry, int nr)
+{
+	enum swap_type type;
+
+	return vswap_check_backing(entry, &type, nr) == nr
+				&& type == VSWAP_FOLIO;
+}
+
+/*
+ * Return the count of contiguous swap entries that share the same
+ * VSWAP_ZERO status as the starting entry. If is_zeromap is not NULL,
+ * it will return the VSWAP_ZERO status of the starting entry.
+ */
+int swap_zeromap_batch(swp_entry_t entry, int max_nr, bool *is_zeromap)
+{
+	struct swp_desc *desc;
+	int i = 0;
+	bool is_zero = false;
+
+	VM_WARN_ON(!entry.val || non_swap_entry(entry));
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + max_nr - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		if (!desc)
+			goto done;
+
+		read_lock(&desc->lock);
+		if (!i) {
+			is_zero = (desc->type == VSWAP_ZERO);
+		} else {
+			if ((desc->type == VSWAP_ZERO) != is_zero) {
+				read_unlock(&desc->lock);
+				goto done;
+			}
+		}
+		read_unlock(&desc->lock);
+		i++;
+	}
+done:
+	rcu_read_unlock();
+	if (i && is_zeromap)
+		*is_zeromap = is_zero;
+
+	return i;
+}
+
 /**
  * free_swap_and_cache_nr() - Release a swap count on range of swap entries and
  *                            reclaim their cache if no more references remain.
diff --git a/mm/zswap.c b/mm/zswap.c
index c1327569ce80..15429825d667 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1068,6 +1068,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
 	};
+	struct zswap_entry *new_entry;
+	swp_slot_t slot;
 
 	/* try to allocate swap cache folio */
 	mpol = get_task_policy(current);
@@ -1088,6 +1090,10 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 		return -EEXIST;
 	}
 
+	slot = vswap_alloc_swap_slot(folio);
+	if (!slot.val)
+		goto release_folio;
+
 	/*
 	 * folio is locked, and the swapcache is now secured against
 	 * concurrent swapping to and from the slot, and concurrent
@@ -1098,12 +1104,9 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * be dereferenced.
 	 */
 	tree = swap_zswap_tree(swpentry);
-	if (entry != xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL)) {
-		delete_from_swap_cache(folio);
-		folio_unlock(folio);
-		folio_put(folio);
-		return -ENOMEM;
-	}
+	new_entry = xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL);
+	if (entry != new_entry)
+		goto fail;
 
 	zswap_decompress(entry, folio);
 
@@ -1124,6 +1127,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	folio_put(folio);
 
 	return 0;
+
+fail:
+	vswap_assoc_zswap(swpentry, new_entry);
+release_folio:
+	delete_from_swap_cache(folio);
+	folio_unlock(folio);
+	folio_put(folio);
+	return -ENOMEM;
 }
 
 /*********************************
@@ -1487,6 +1498,8 @@ static bool zswap_store_page(struct page *page,
 		goto store_failed;
 	}
 
+	vswap_assoc_zswap(page_swpentry, entry);
+
 	/*
 	 * We may have had an existing entry that became stale when
 	 * the folio was redirtied and now the new version is being
@@ -1608,7 +1621,7 @@ bool zswap_store(struct folio *folio)
 	 */
 	if (!ret) {
 		unsigned type = swp_type(swp);
-		pgoff_t offset = swp_offset(swp);
+		pgoff_t offset = zswap_tree_index(swp);
 		struct zswap_entry *entry;
 		struct xarray *tree;
 
@@ -1618,6 +1631,12 @@ bool zswap_store(struct folio *folio)
 			if (entry)
 				zswap_entry_free(entry);
 		}
+
+		/*
+		 * We might have also partially associated some virtual swap slots with
+		 * zswap entries. Undo this.
+		 */
+		vswap_store_folio(swp, folio);
 	}
 
 	return ret;
@@ -1674,6 +1693,7 @@ bool zswap_load(struct folio *folio)
 		count_objcg_events(entry->objcg, ZSWPIN, 1);
 
 	if (swapcache) {
+		vswap_store_folio(swp, folio);
 		zswap_entry_free(entry);
 		folio_mark_dirty(folio);
 	}
-- 
2.47.1


