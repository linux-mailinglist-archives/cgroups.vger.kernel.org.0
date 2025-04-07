Return-Path: <cgroups+bounces-7410-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061D7A7F15B
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 01:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916A63B5BE1
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D4C22F3A8;
	Mon,  7 Apr 2025 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfODJ0xc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF0722A1E9;
	Mon,  7 Apr 2025 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069352; cv=none; b=klYNkCqHjemHpRSd+hDHYUWKsZQnXn/Bn5EV/S+RyMtZHuFC9DkLkdf70MenQKQiUNA1uPQIV+i3Lk62EgdIDHbJd+rBjneG0KoMai5LrWsLNw2a4pPGroF67hYNsTLpe0YHpXmjrEmB337KrM1bgpkxG92i6wdtD+zcNJ2UFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069352; c=relaxed/simple;
	bh=wXMByu3+yG6bgC4hESbH9CPw8s0oKS+GUPKiTDjIYoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMfItyVV53uyMbvpG6W6AQmUA8Vvr6NxG48V3DO73045Cd6tjJ0CQEwEaXw4ofJ7F9CrNWL3mHqJn3YXnHyqxKCZF7e7a3aSF2pOuhJLD9jJB1JNtq/0IZiVNq3a0XQK0uMmWFkIgWn9wXbBkcpNP4ysuLeUgm9b73ec0T14o98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfODJ0xc; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e6dee579f38so4327975276.0;
        Mon, 07 Apr 2025 16:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069348; x=1744674148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEQEACQD2Wfh+5v0+KctRKm6Y8AFy6+TQkhluAfNqzs=;
        b=SfODJ0xciu/nNl5oYhAPhP/h1q6YgBfhG/kHCRWDlygYRhtuIqNuvlGvj+zdbqlDjj
         967sJzTFs9G8FpPmIMeEajDesuXDB1RuC43Xhng4s5Y1gzVM6rSfCWiTD5f0cyY9jwHl
         /PbiQ1D5nlb58O7+PzIQ90rjPNmvTMaTxAnNK9QS4qTTtbzmgqpY26oFa4mBEzuj+zEa
         X4xSKnfOpIbRbFATMaZmuznJuxIGoexH9+ghD+422m2Ys0oJhDDSaNKtXRTl2G9iqPgr
         bYqQhsRiRnBRDAb4QWp7U32GnZaE4/9LgoZdRktSKLQJrYSj1jfcdEdsDuh8v5YG+y1P
         +JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069348; x=1744674148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEQEACQD2Wfh+5v0+KctRKm6Y8AFy6+TQkhluAfNqzs=;
        b=kmGuvWGb6/9+ZZSc+RKrvh7vCrklKQgV4yDakupAHgRDYWxQjJXqJhtXbv+uIOqO+5
         5jeF+8hXBJXaEsvodqvNlqapVWzaZiVSFVUaie5RcHqiyX3ycGTSpH19s17sIS1smPQG
         +KRzj5JC1/cchAGn0X0YY5kMIr0AUlgj/mMUFVntLz7rRboyDV+srhF1fKBXNYreUh1I
         uz1/TXdOGYiS2/JlLlWMzrAFFS5SJdWZ3vPVqjEnZXg4/dgkmsoH1+62Ifh3/qzQSHx4
         iI7cYjmf/myxzrV4YCpO89ytwukb9QJuHdPB/708kOCHuhwHiJGl9Co5xZvCs34a6Wbq
         cwSA==
X-Forwarded-Encrypted: i=1; AJvYcCUM4w0jt9jZDRavFTJFxGOYkUrBB7DrDGqv+4nMF72qds4RBm2fUJk7q/8kgLjbuxqmi/80Japk@vger.kernel.org, AJvYcCV7lY99CkRvcUMTV3K5IWwfk2oAeIasHrTtFo9HNGKVEgUHDI3dkBwL4bbcAQLgJf4g3iSTZqYf8UM=@vger.kernel.org, AJvYcCXoPcPaW8yJI75ioI5PlaARvtTgBNSOYFLnDHXwkboCcsewePW+WbXhXRsRD2Pa64m0IcV5ce1r8oHmZTSF@vger.kernel.org
X-Gm-Message-State: AOJu0YzFhjA2iVO/er7hSfq9F9PvnKYiEJqzFmmWTijOAw1uJOjslNHX
	6thW3OYsCdnPgNxtImyiDVohJ9ICcj2bBiFoI2R08cIRX6ZwrHgc
X-Gm-Gg: ASbGncuXaYn6xQjae7dM4+bngBZHB1GnlAATUxPmIkEiZfy71wE/p7KqT7oQAsf76lT
	wCmghTgQIj/GAKJZ/xbP0pay9ut3DRXf3UN+yNqR/Gko1QYoYVgDAY2LckvTR9I/k/kJrE0gats
	mJ6zAlUsz3MckcUs288dYtHDuLrLMwDw18Hn7MN90uOxLzZo6xdSCBjIAsedTnIrW4T53IY5Zyv
	bNiCXCJzJNdA3hZc+Kk7wahQPymfTwsO9pwliiTmCN70+b/S5osCFKAzuF3NNJNfzrcysoX7kWH
	NwgECpUuHiT33/dKzGCNXr54P3zTOj2dTrAf
X-Google-Smtp-Source: AGHT+IFDsRD0X/uNyaT45Bx26CornbhSVsTZAubB1ovo34tXqCw2Uq6LR7maL4EQaJQJoudWeFTtMQ==
X-Received: by 2002:a05:6902:e02:b0:e6d:f47e:6a40 with SMTP id 3f1490d57ef6-e6e1c2a5e39mr25036905276.6.1744069348014;
        Mon, 07 Apr 2025 16:42:28 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1f78eaesm27717997b3.70.2025.04.07.16.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:42:27 -0700 (PDT)
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
Subject: [RFC PATCH 06/14] mm: swap: allocate a virtual swap slot for each swapped out page
Date: Mon,  7 Apr 2025 16:42:07 -0700
Message-ID: <20250407234223.1059191-7-nphamcs@gmail.com>
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
 MAINTAINERS             |   7 +
 include/linux/swap.h    |  28 ++-
 include/linux/swapops.h |  12 ++
 mm/Kconfig              |   4 +
 mm/Makefile             |   1 +
 mm/internal.h           |  43 ++++-
 mm/shmem.c              |  10 +-
 mm/swap.h               |   2 +
 mm/swap_state.c         |  39 +++--
 mm/swapfile.c           |  18 +-
 mm/vswap.c              | 375 ++++++++++++++++++++++++++++++++++++++++
 11 files changed, 508 insertions(+), 31 deletions(-)
 create mode 100644 mm/vswap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 00e94bec401e..65108bf2a5f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25290,6 +25290,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
 F:	drivers/iio/light/veml6030.c
 
+VIRTUAL SWAP SPACE
+M:	Nhat Pham <nphamcs@gmail.com>
+M:	Johannes Weiner <hannes@cmpxchg.org>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	mm/vswap.c
+
 VISHAY VEML6075 UVA AND UVB LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 674089bc4cd1..d32a2c300924 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -455,7 +455,6 @@ extern void __meminit kswapd_stop(int nid);
 /* Virtual swap API */
 swp_entry_t folio_alloc_swap(struct folio *folio);
 bool folio_free_swap(struct folio *folio);
-void put_swap_folio(struct folio *folio, swp_entry_t entry);
 int add_swap_count_continuation(swp_entry_t, gfp_t);
 void swap_shmem_alloc(swp_entry_t, int);
 int swap_duplicate(swp_entry_t);
@@ -504,6 +503,7 @@ static inline long get_nr_swap_pages(void)
 }
 
 void si_swapinfo(struct sysinfo *);
+void swap_slot_put_folio(swp_slot_t slot, struct folio *folio);
 swp_slot_t swap_slot_alloc_of_type(int);
 int swap_slot_alloc(int n, swp_slot_t swp_slots[], int order);
 void swap_slot_free_nr(swp_slot_t slot, int nr_pages);
@@ -725,6 +725,26 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 }
 #endif
 
+#ifdef CONFIG_VIRTUAL_SWAP
+int vswap_init(void);
+void vswap_exit(void);
+void vswap_free(swp_entry_t entry);
+swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry);
+swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot);
+#else
+static inline int vswap_init(void)
+{
+	return 0;
+}
+
+static inline void vswap_exit(void)
+{
+}
+
+static inline void vswap_free(swp_entry_t entry)
+{
+}
+
 /**
  * swp_entry_to_swp_slot - look up the physical swap slot corresponding to a
  *                         virtual swap slot.
@@ -748,6 +768,12 @@ static inline swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
 {
 	return (swp_entry_t) { slot.val };
 }
+#endif
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
diff --git a/mm/Kconfig b/mm/Kconfig
index 1a6acdb64333..d578b8e6ab6a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -32,6 +32,10 @@ config VIRTUAL_SWAP
 		(zswap, on-disk swapfile, etc.), and save disk space when we
 		use zswap (or the zero-filled swap page optimization).
 
+		In this new design, for each swap entry, a virtual swap slot is
+		allocated and stored in the page table entry, rather than the
+		handle to the physical swap slot on the swap device itself.
+
 		There might be more lock contentions with heavy swap use, since
 		the swap cache is no longer range partitioned.
 
diff --git a/mm/Makefile b/mm/Makefile
index 850386a67b3e..b7216c714fa1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -76,6 +76,7 @@ ifdef CONFIG_MMU
 endif
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o swap_slots.o
+obj-$(CONFIG_VIRTUAL_SWAP)	+= vswap.o
 obj-$(CONFIG_ZSWAP)	+= zswap.o
 obj-$(CONFIG_HAS_DMA)	+= dmapool.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
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
index 268338a0ea57..eb4cd6ba2068 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -176,6 +176,7 @@ void __delete_from_swap_cache(struct folio *folio,
 	__lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr);
 }
 
+#ifndef CONFIG_VIRTUAL_SWAP
 swp_entry_t folio_alloc_swap(struct folio *folio)
 {
 	swp_slot_t slot = folio_alloc_swap_slot(folio);
@@ -188,6 +189,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 
 	return entry;
 }
+#endif
 
 /**
  * add_to_swap - allocate swap space for a folio
@@ -270,26 +272,30 @@ void delete_from_swap_cache(struct folio *folio)
 }
 
 #ifdef CONFIG_VIRTUAL_SWAP
-void clear_shadow_from_swap_cache(int type, unsigned long begin,
-				unsigned long end)
+/*
+ * In the virtual swap implementation, we index the swap cache by virtual swap
+ * slots rather than physical ones. As a result, we only clear the shadow when
+ * the virtual swap slot is freed (via virt_clear_shadow_from_swap_cache()),
+ * not when the physical swap slot is freed (via clear_shadow_from_swap_cache()
+ * in the old implementation, which is a no-op in the new implementation).
+ */
+void virt_clear_shadow_from_swap_cache(swp_entry_t entry)
 {
-	swp_slot_t slot = swp_slot(type, begin);
-	swp_entry_t entry = swp_slot_to_swp_entry(slot);
-	unsigned long index = swap_cache_index(entry);
 	struct address_space *address_space = swap_address_space(entry);
-	void *old;
+	pgoff_t index = swap_cache_index(entry);
 	XA_STATE(xas, &address_space->i_pages, index);
 
 	xas_set_update(&xas, workingset_update_node);
-
 	xa_lock_irq(&address_space->i_pages);
-	xas_for_each(&xas, old, entry.val + end - begin) {
-		if (!xa_is_value(old))
-			continue;
+	if (xa_is_value(xas_load(&xas)))
 		xas_store(&xas, NULL);
-	}
 	xa_unlock_irq(&address_space->i_pages);
 }
+
+void clear_shadow_from_swap_cache(int type, unsigned long begin,
+				unsigned long end)
+{
+}
 #else
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				unsigned long end)
@@ -978,10 +984,17 @@ static int __init swap_init_sysfs(void)
 	init_swapper_space(&swapper_space);
 #endif
 
+	err = vswap_init();
+	if (err) {
+		pr_err("failed to initialize virtual swap space\n");
+		return err;
+	}
+
 	swap_kobj = kobject_create_and_add("swap", mm_kobj);
 	if (!swap_kobj) {
 		pr_err("failed to create swap kobject\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto vswap_exit;
 	}
 	err = sysfs_create_group(swap_kobj, &swap_attr_group);
 	if (err) {
@@ -992,6 +1005,8 @@ static int __init swap_init_sysfs(void)
 
 delete_obj:
 	kobject_put(swap_kobj);
+vswap_exit:
+	vswap_exit();
 	return err;
 }
 subsys_initcall(swap_init_sysfs);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a1dd7e998e90..533011c97e03 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1505,6 +1505,20 @@ static void swap_slot_range_free(struct swap_info_struct *si,
 	unsigned char *map = si->swap_map + offset;
 	unsigned char *map_end = map + nr_pages;
 	swp_entry_t entry = swp_slot_to_swp_entry(slot);
+	int i;
+
+#ifndef CONFIG_VIRTUAL_SWAP
+	/*
+	 * In the new (i.e virtual swap) implementation, we will let the virtual
+	 * swap layer handle the cgroup swap accounting and charging.
+	 */
+	mem_cgroup_uncharge_swap(entry, nr_pages);
+#endif
+	/* release all the associated (virtual) swap slots */
+	for (i = 0; i < nr_pages; i++) {
+		vswap_free(entry);
+		entry.val++;
+	}
 
 	/* It should never free entries across different clusters */
 	VM_BUG_ON(ci != offset_to_cluster(si, offset + nr_pages - 1));
@@ -1517,7 +1531,6 @@ static void swap_slot_range_free(struct swap_info_struct *si,
 		*map = 0;
 	} while (++map < map_end);
 
-	mem_cgroup_uncharge_swap(entry, nr_pages);
 	swap_range_free(si, offset, nr_pages);
 
 	if (!ci->count)
@@ -1571,9 +1584,8 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
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
new file mode 100644
index 000000000000..23a05c3393d8
--- /dev/null
+++ b/mm/vswap.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtual swap space
+ *
+ * Copyright (C) 2024 Meta Platforms, Inc., Nhat Pham
+ */
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
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+static struct dentry *vswap_debugfs_root;
+
+static int vswap_debug_fs_init(void)
+{
+	if (!debugfs_initialized())
+		return -ENODEV;
+
+	vswap_debugfs_root = debugfs_create_dir("vswap", NULL);
+	debugfs_create_atomic_t("alloc_reject", 0444,
+		vswap_debugfs_root, &vswap_alloc_reject);
+	debugfs_create_atomic_t("used", 0444, vswap_debugfs_root, &vswap_used);
+
+	return 0;
+}
+#else
+static int vswap_debug_fs_init(void)
+{
+	return 0;
+}
+#endif
+
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
+int vswap_init(void)
+{
+	swp_desc_cache = KMEM_CACHE(swp_desc, 0);
+	if (!swp_desc_cache)
+		return -ENOMEM;
+
+	if (xa_insert(&vswap_cluster_map, 0, xa_mk_value(1), GFP_KERNEL)) {
+		kmem_cache_destroy(swp_desc_cache);
+		return -ENOMEM;
+	}
+
+	if (vswap_debug_fs_init())
+		pr_warn("Failed to initialize vswap debugfs\n");
+
+	return 0;
+}
+
+void vswap_exit(void)
+{
+	kmem_cache_destroy(swp_desc_cache);
+}
-- 
2.47.1


