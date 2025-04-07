Return-Path: <cgroups+bounces-7406-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD656A7F149
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 01:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11EB17CA72
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEAA22D4D0;
	Mon,  7 Apr 2025 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAPP8oYX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1A622B8A4;
	Mon,  7 Apr 2025 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069350; cv=none; b=r5ej1L3rHA8zn4JCisorb7dT9TMNvuGgNjGMHKtnVmoTmAZiRz/oi8D5TejDlXWon8a+6Hmt+u6BnZdk8/PdnPJgKElvaqlctxirB8CPn0lZkR8itpPzioAYXkZ0io+H3YHpRI9q/T0vXPNAIDgmgyPwVT/73HwR3y/KMU9yUo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069350; c=relaxed/simple;
	bh=1L2gaPkIu5XYa3vBqkeaYMpblZz6+kkjUGPCN9QandM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfhNC/XjbigGye/jgdEKY93nY2fkw0h8QwUrbBdQj3W26mTnQ1fWod/Jy6+WlpV9A869CZsiwYlE0Ed6uvRKu/3KVWRGbPM9QqDxTkfd/A9Sr4+WjZj/gyoAVgY1IoIJhfVRMi2pcrQuosraJt6Sn9PrJpdW4gxV82ejHZuuSZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAPP8oYX; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6fee63b9139so44557687b3.1;
        Mon, 07 Apr 2025 16:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069347; x=1744674147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73uaIqpGQmGcoc6xX4uGJDrIoUQxEZ/6HdzUqXO0b/Q=;
        b=MAPP8oYXVDS/ZoAKAwneREp+q5lJ946pJ+3Iq7+fLd0vYAkJIBVdm7pOxo1pS6AsvW
         cXHElaL5JwOJ7+0aZvdib9fHA/wQwe0AW2Y7oz8fyiLTwUT8LZgBn+ODIukH/xUOnSTE
         kyNRJ0judkkNPbsXIRB0mNh4WzKs2duRhtEkC7PsLAmj3ms40suMIubwKKn45k0mJNto
         OFFiJ0qzSewYzG/CkNShR08Jk156LQk7OGDEjp12Tcl2rIOjacebQq2BtnwdZlrLR9Eo
         eH0zjFYfmotvzbs3f3XF8qUBf5nwnK39/I5wF7aayd0bAs2FGbMf44nA1/G4Eoms4wkD
         VYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069347; x=1744674147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73uaIqpGQmGcoc6xX4uGJDrIoUQxEZ/6HdzUqXO0b/Q=;
        b=YId6vpeD3s7C0l2kEJTsPKYFNa2pvfKrxEua9vpBbYKxE/rJ99umPxE7NSxNXBJRfR
         4WjupCaF/Y+o8rHfDUowsoVRzBU4ViI2Igb4rsBfJJH4RufgZXqhrefycuZU+MufcgmA
         uSjC3duakaXb9I7Fmr5z9GQGIXtr8pbxi4HixTBCnIP7gCA8fYxempFKyjHnz5iOCBoB
         dDrczjpW6uK2yMdMza7kccEfuoNSroLCi2Sqmv/AD1J/eMBdtjg7cWL0gGmbOQi8IjZn
         Q04Ka0+gA1Xkd39nP+ibECj3rXN/6P10egq/fo1eaKJlI8m6E3O8hiFhPFUQfV52Zp2u
         7qvA==
X-Forwarded-Encrypted: i=1; AJvYcCUYJrk/zZhqv5BFgWEq6U+oRwUI+xql93lClxpnvzfYFyigk52HimBT44VSYEDfzkDBJg0gXz1d@vger.kernel.org, AJvYcCVfOfu1aZXXwYCwTaaBCOC2/NgiS4Jah71J27n4n5OvDJfLQJ4H6FPSo9KOX5XNBe7VZosLhAppkMGgG4S+@vger.kernel.org, AJvYcCWEfgSiOnDBQD5FGx5hnx2JolNWByonR109XxatDT6HbJAhqw/htWtZz7P3zQ6+wCYxnP2bNJ1du+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6wTPvnU3VVeFYhxhE74zjwWuQazEkPZBihP29JDnSlULtWav+
	lYGs5Pyp5c3H8pcEfvoTuD252TZAVEm+DzWvi/0w9eVuJWMDw0OO
X-Gm-Gg: ASbGnctQJOQauP20T0uzMGLGnVVqnlyJKc9yn1x57Ba2H/rICadPI7kWKZwk2YSYEBB
	u+YQF4CchrbtHHYZmv0fywviiTV9dF/VqHyKkjveXcsaPdASR6uE0x8XBFZqgOPAFID61An9shq
	JcNPfCkyZDjP72LTHmneQMdhqU8xoW+v7Tsw3HWM5klz6wIy2dhn1aVlLFrchi71vbAW8jFmlXi
	UVbD2Q1PNNh+C4NMd/76BSPifR4HOR87896KGzldGLdDbphoVw3Nd0MPAnxIJ899dlbhO9RLQBK
	i1Mpik3qZ2ICQyjkzlA7cuqJPl0NZB2OHxw=
X-Google-Smtp-Source: AGHT+IHZdzxtGyNDUvpRfkN+hu9r8BnXmzk6o6ybIvQZjcqkoNyrqs6Z1N2T8Jqkk8HRpaLSwYFkoQ==
X-Received: by 2002:a05:690c:11:b0:6f9:492e:94db with SMTP id 00721157ae682-7042d433cc9mr20957957b3.2.1744069346612;
        Mon, 07 Apr 2025 16:42:26 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1e2f5e3sm28156577b3.23.2025.04.07.16.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:42:26 -0700 (PDT)
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
Subject: [RFC PATCH 04/14] mm: swap: swap cache support for virtualized swap
Date: Mon,  7 Apr 2025 16:42:05 -0700
Message-ID: <20250407234223.1059191-5-nphamcs@gmail.com>
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

Currently, the swap cache code assumes that the swap space is of a fixed
size. The virtual swap space is dynamically sized, so the existing
partitioning code cannot be easily reused.  A dynamic partitioning is
planned, but for now keep the design simple and just use a flat
swapcache for vswap.

Since the vswap's implementation has begun to diverge from the old
implementation, we also introduce a new build config
(CONFIG_VIRTUAL_SWAP). Users who do not select this config will get the
old implementation, with no behavioral change.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/Kconfig      | 13 ++++++++++
 mm/swap.h       | 22 ++++++++++------
 mm/swap_state.c | 68 +++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 85 insertions(+), 18 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 1b501db06417..1a6acdb64333 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -22,6 +22,19 @@ menuconfig SWAP
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 
+config VIRTUAL_SWAP
+	bool "Swap space virtualization"
+	depends on SWAP
+	default n
+	help
+		When this is selected, the kernel is built with the new swap
+		design. This will allow us to decouple the swap backends
+		(zswap, on-disk swapfile, etc.), and save disk space when we
+		use zswap (or the zero-filled swap page optimization).
+
+		There might be more lock contentions with heavy swap use, since
+		the swap cache is no longer range partitioned.
+
 config ZSWAP
 	bool "Compressed cache for swap pages"
 	depends on SWAP
diff --git a/mm/swap.h b/mm/swap.h
index d5f8effa8015..06e20b1d79c4 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -22,22 +22,27 @@ void swap_write_unplug(struct swap_iocb *sio);
 int swap_writepage(struct page *page, struct writeback_control *wbc);
 void __swap_writepage(struct folio *folio, struct writeback_control *wbc);
 
-/* linux/mm/swap_state.c */
-/* One swap address space for each 64M swap space */
+/* Return the swap device position of the swap slot. */
+static inline loff_t swap_slot_pos(swp_slot_t slot)
+{
+	return ((loff_t)swp_slot_offset(slot)) << PAGE_SHIFT;
+}
+
 #define SWAP_ADDRESS_SPACE_SHIFT	14
 #define SWAP_ADDRESS_SPACE_PAGES	(1 << SWAP_ADDRESS_SPACE_SHIFT)
 #define SWAP_ADDRESS_SPACE_MASK		(SWAP_ADDRESS_SPACE_PAGES - 1)
+
+/* linux/mm/swap_state.c */
+#ifdef CONFIG_VIRTUAL_SWAP
+extern struct address_space *swap_address_space(swp_entry_t entry);
+#define swap_cache_index(entry) entry.val
+#else
+/* One swap address space for each 64M swap space */
 extern struct address_space *swapper_spaces[];
 #define swap_address_space(entry)			    \
 	(&swapper_spaces[swp_type(entry)][swp_offset(entry) \
 		>> SWAP_ADDRESS_SPACE_SHIFT])
 
-/* Return the swap device position of the swap slot. */
-static inline loff_t swap_slot_pos(swp_slot_t slot)
-{
-	return ((loff_t)swp_slot_offset(slot)) << PAGE_SHIFT;
-}
-
 /*
  * Return the swap cache index of the swap entry.
  */
@@ -46,6 +51,7 @@ static inline pgoff_t swap_cache_index(swp_entry_t entry)
 	BUILD_BUG_ON((SWP_OFFSET_MASK | SWAP_ADDRESS_SPACE_MASK) != SWP_OFFSET_MASK);
 	return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
 }
+#endif
 
 void show_swap_cache_info(void);
 bool add_to_swap(struct folio *folio);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 055e555d3382..268338a0ea57 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -38,10 +38,19 @@ static const struct address_space_operations swap_aops = {
 #endif
 };
 
+#ifdef CONFIG_VIRTUAL_SWAP
+static struct address_space swapper_space __read_mostly;
+
+struct address_space *swap_address_space(swp_entry_t entry)
+{
+	return &swapper_space;
+}
+#else
 struct address_space *swapper_spaces[MAX_SWAPFILES] __read_mostly;
 static unsigned int nr_swapper_spaces[MAX_SWAPFILES] __read_mostly;
-static bool enable_vma_readahead __read_mostly = true;
+#endif
 
+static bool enable_vma_readahead __read_mostly = true;
 #define SWAP_RA_ORDER_CEILING	5
 
 #define SWAP_RA_WIN_SHIFT	(PAGE_SHIFT / 2)
@@ -260,6 +269,28 @@ void delete_from_swap_cache(struct folio *folio)
 	folio_ref_sub(folio, folio_nr_pages(folio));
 }
 
+#ifdef CONFIG_VIRTUAL_SWAP
+void clear_shadow_from_swap_cache(int type, unsigned long begin,
+				unsigned long end)
+{
+	swp_slot_t slot = swp_slot(type, begin);
+	swp_entry_t entry = swp_slot_to_swp_entry(slot);
+	unsigned long index = swap_cache_index(entry);
+	struct address_space *address_space = swap_address_space(entry);
+	void *old;
+	XA_STATE(xas, &address_space->i_pages, index);
+
+	xas_set_update(&xas, workingset_update_node);
+
+	xa_lock_irq(&address_space->i_pages);
+	xas_for_each(&xas, old, entry.val + end - begin) {
+		if (!xa_is_value(old))
+			continue;
+		xas_store(&xas, NULL);
+	}
+	xa_unlock_irq(&address_space->i_pages);
+}
+#else
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				unsigned long end)
 {
@@ -290,6 +321,7 @@ void clear_shadow_from_swap_cache(int type, unsigned long begin,
 			break;
 	}
 }
+#endif
 
 /*
  * If we are the only user, then try to free up the swap cache.
@@ -718,23 +750,34 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	return folio;
 }
 
+static void init_swapper_space(struct address_space *space)
+{
+	xa_init_flags(&space->i_pages, XA_FLAGS_LOCK_IRQ);
+	atomic_set(&space->i_mmap_writable, 0);
+	space->a_ops = &swap_aops;
+	/* swap cache doesn't use writeback related tags */
+	mapping_set_no_writeback_tags(space);
+}
+
+#ifdef CONFIG_VIRTUAL_SWAP
 int init_swap_address_space(unsigned int type, unsigned long nr_pages)
 {
-	struct address_space *spaces, *space;
+	return 0;
+}
+
+void exit_swap_address_space(unsigned int type) {}
+#else
+int init_swap_address_space(unsigned int type, unsigned long nr_pages)
+{
+	struct address_space *spaces;
 	unsigned int i, nr;
 
 	nr = DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
 	spaces = kvcalloc(nr, sizeof(struct address_space), GFP_KERNEL);
 	if (!spaces)
 		return -ENOMEM;
-	for (i = 0; i < nr; i++) {
-		space = spaces + i;
-		xa_init_flags(&space->i_pages, XA_FLAGS_LOCK_IRQ);
-		atomic_set(&space->i_mmap_writable, 0);
-		space->a_ops = &swap_aops;
-		/* swap cache doesn't use writeback related tags */
-		mapping_set_no_writeback_tags(space);
-	}
+	for (i = 0; i < nr; i++)
+		init_swapper_space(spaces + i);
 	nr_swapper_spaces[type] = nr;
 	swapper_spaces[type] = spaces;
 
@@ -752,6 +795,7 @@ void exit_swap_address_space(unsigned int type)
 	nr_swapper_spaces[type] = 0;
 	swapper_spaces[type] = NULL;
 }
+#endif
 
 static int swap_vma_ra_win(struct vm_fault *vmf, unsigned long *start,
 			   unsigned long *end)
@@ -930,6 +974,10 @@ static int __init swap_init_sysfs(void)
 	int err;
 	struct kobject *swap_kobj;
 
+#ifdef CONFIG_VIRTUAL_SWAP
+	init_swapper_space(&swapper_space);
+#endif
+
 	swap_kobj = kobject_create_and_add("swap", mm_kobj);
 	if (!swap_kobj) {
 		pr_err("failed to create swap kobject\n");
-- 
2.47.1


