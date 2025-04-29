Return-Path: <cgroups+bounces-7918-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66782AA3C96
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609BD17A8D7
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C463D2DFA43;
	Tue, 29 Apr 2025 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akWuXJXT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5902DEBA8;
	Tue, 29 Apr 2025 23:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969939; cv=none; b=cdMYoUGKilO6xTNjp6kZc4SiIGF6Vg7gjX4hdxwrXBXqamubnofLEGsVRgB/2UAs7m95nsrVwe24s314WgB4O4YLpBILcWMRaPClewAhzq7ognj8Njgqv2qzO87nG06UuRNOmtZp2qHh1wCZW0xy70eM2x1nDQBYPOqiKwr0BhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969939; c=relaxed/simple;
	bh=196lU1jIJriKLiqmzv1Vy3qpM+eNgjeCkiA+fGipeqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVM7oZm5dD1NTP+AB/9SyeOTbp2kb1WdWQ4Xa3eBxvhmKDiJaDGxMYtcCn7WZ6yzqYn7g7qFWDQhFD6jJd0c6TQ5A4e5jh4L/NNOD406/mTSg3De37vpbFFRQPwEZOqWBBtY5dEsdpb07N76BG7ElLti4Mewuy7f66eQyxZ4NNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akWuXJXT; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70811611315so57367017b3.1;
        Tue, 29 Apr 2025 16:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969936; x=1746574736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44dQEBk34Lg+twP2t8lNoyYgFTs2iNjxhzJ6aTJ3tVA=;
        b=akWuXJXT023ucQQLpYOgmCCXrORzgtGLN4vEd7skv9SM6NcWwuZwkyCz5A1UznBm/G
         GnTmSXJQfVU/Zg/CBugWsLa4HSCXpT5xYb6QrTX6rs5/HjtQR1WvfudCtdAae1fc4hcT
         vVOGo0T/0TTV8X8/kNKGQ/2S8rTKAu6P84triLyjGClpJLZicPMvbZ39IMvKPNvdaBz3
         GzQ+MMlWX24VN/amejdiD+FQn+O2SuXWBjbGfJRxuWTT2YvJ9Nn1aGeHcr5m5wNescUH
         41nvwdf2VbNllvIfc+CLNKMHgvTucoy3GuwKqRwUwfOWDSCTCCrLFoc4sxEMfIg/59FR
         0Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969936; x=1746574736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44dQEBk34Lg+twP2t8lNoyYgFTs2iNjxhzJ6aTJ3tVA=;
        b=iG70vX4RywuDsbbPqSqKxsMFC2zgMFsy/FyBql/g6tizXskDFfczxFGxGWgVfFwprn
         KOWmct0FRO6voMTiUPLQamjHN397lzZ9AnuXnV6N93Nj53cvIm5E9bQtiu/H6GWx0Q0P
         fRyORTqtHgj+koikyolkcsKC5tVqBbvHXbJqyZ6B6lK945Ah/YC4yPxEDw3V9sn/aP3H
         8oCnOKxWz3OWkW+FCvU83yexUd2HTmfjkBuvwEJhGTkyhQB+9O6enWq+Y/oxjVRmdJCh
         1DjQWR+5jDySoReAST+FKauSQAkTuzRagh5uuVWyQs7fRZ4AzsQ3E8og5I5VGRgNWKdi
         n3yg==
X-Forwarded-Encrypted: i=1; AJvYcCVSnCrGdY8m/k7bNNN0TBSRT3mQNJUhc29L7UHvfZcjZdTf7Qqmi/Zji47ddy5/jvjdmyhVpY0/@vger.kernel.org, AJvYcCVdxUklhEuQ89MgiYAFdz0FD5bKGKpyj4aI0uTSNvaAjXsYyxh0pCxpGY+/jndMYJyAGQz/iTt4f4c=@vger.kernel.org, AJvYcCWpi7j+XTrdpbBrlumxE4xvp139q9/gjQFRSR9VNMLWnTFZyjFIG3/2HUZSZKW4AnuiEueUswwuaQYRJZhU@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQWQhwYMainBDfSsnkku52NedeU9737Yn6j+BA6VCAQfUggun
	mB6LO2q2UPdu3bQgSdxYwGVMAzzs8mCkJy15GH2YEnmaaJxvO+0G
X-Gm-Gg: ASbGnctjeA+RIVOmEBxLGH2lCKwbMMHYCcciA3AtBJ0g3c1Zaz1/JMifjZCmrku8FDI
	e9TfVDZKigh0xzVeR5a5jkopx9njjpdZydT8UXivzx9R/wa/3I9vxc+iaR9LEmtvbLmC7mFPiG8
	Zu+SjtdCgU3CdKtNlWYVxQytA9tstW+uYm3vVBKRpM5WeLee9MI5MIvbBKNoP1+Pct6x+XJkw2i
	vNLoIoRkgV8hmQxLQuUFl8lg8AhMcBPLKuJLauQQ6lkhx41rpIG3B3PpXzDtDwttJevLb30UAgX
	G4OsszSJyMcQ/wukyNMZEVtXdjyxZ1DrZ6cYJyYDBw==
X-Google-Smtp-Source: AGHT+IF0Gq0OKMjMbPFewLBiKCryoCgbkMLTWTjJKXA6zaQErPJ0Qq2QeEf8yHjPw1HgNf/wZrnNZg==
X-Received: by 2002:a05:690c:6c85:b0:6f7:55a2:4cd8 with SMTP id 00721157ae682-708ad5c575dmr9535387b3.5.1745969936353;
        Tue, 29 Apr 2025 16:38:56 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708ae1e9ae7sm701547b3.102.2025.04.29.16.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:38:55 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/18] mm: swap: zswap: swap cache and zswap support for virtualized swap
Date: Tue, 29 Apr 2025 16:38:35 -0700
Message-ID: <20250429233848.3093350-8-nphamcs@gmail.com>
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

Currently, the swap cache code assumes that the swap space is of a fixed
size. The virtual swap space is dynamically sized, so the existing
partitioning code cannot be easily reused.  A dynamic partitioning is
planned, but for now keep the design simple and just use a flat
swapcache for vswap.

Similar to swap cache, the zswap tree code, specifically the range
partition logic, can no longer easily be reused for the new virtual swap
space design. Use a simple unified zswap tree in the new implementation
for now. As in the case of swap cache, range partitioning is planned as
a follow up work.

Since the vswap's implementation has begun to diverge from the old
implementation, we also introduce a new build config
(CONFIG_VIRTUAL_SWAP). Users who do not select this config will get the
old implementation, with no behavioral change.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swap.h       | 22 ++++++++++++++--------
 mm/swap_state.c | 44 +++++++++++++++++++++++++++++++++++---------
 mm/zswap.c      | 38 ++++++++++++++++++++++++++++++++------
 3 files changed, 81 insertions(+), 23 deletions(-)

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
index 1607d23a3d7b..f677ebf9c5d0 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -38,8 +38,18 @@ static const struct address_space_operations swap_aops = {
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
+#endif
+
 static bool enable_vma_readahead __read_mostly = true;
 
 #define SWAP_RA_ORDER_CEILING	5
@@ -718,23 +728,34 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
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
+int init_swap_address_space(unsigned int type, unsigned long nr_pages)
+{
+	return 0;
+}
+
+void exit_swap_address_space(unsigned int type) {}
+#else
 int init_swap_address_space(unsigned int type, unsigned long nr_pages)
 {
-	struct address_space *spaces, *space;
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
 
@@ -752,6 +773,7 @@ void exit_swap_address_space(unsigned int type)
 	nr_swapper_spaces[type] = 0;
 	swapper_spaces[type] = NULL;
 }
+#endif
 
 static int swap_vma_ra_win(struct vm_fault *vmf, unsigned long *start,
 			   unsigned long *end)
@@ -930,6 +952,10 @@ static int __init swap_init_sysfs(void)
 	int err;
 	struct kobject *swap_kobj;
 
+#ifdef CONFIG_VIRTUAL_SWAP
+	init_swapper_space(&swapper_space);
+#endif
+
 	err = vswap_init();
 	if (err) {
 		pr_err("failed to initialize virtual swap space\n");
diff --git a/mm/zswap.c b/mm/zswap.c
index 23365e76a3ce..c1327569ce80 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -203,8 +203,6 @@ struct zswap_entry {
 	struct list_head lru;
 };
 
-static struct xarray *zswap_trees[MAX_SWAPFILES];
-static unsigned int nr_zswap_trees[MAX_SWAPFILES];
 
 /* RCU-protected iteration */
 static LIST_HEAD(zswap_pools);
@@ -231,12 +229,28 @@ static bool zswap_has_pool;
 * helpers and fwd declarations
 **********************************/
 
+#ifdef CONFIG_VIRTUAL_SWAP
+static DEFINE_XARRAY(zswap_tree);
+
+static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
+{
+	return &zswap_tree;
+}
+
+#define zswap_tree_index(entry)	entry.val
+#else
+static struct xarray *zswap_trees[MAX_SWAPFILES];
+static unsigned int nr_zswap_trees[MAX_SWAPFILES];
+
 static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
 {
 	return &zswap_trees[swp_type(swp)][swp_offset(swp)
 		>> SWAP_ADDRESS_SPACE_SHIFT];
 }
 
+#define zswap_tree_index(entry)	swp_offset(entry)
+#endif
+
 #define zswap_pool_debug(msg, p)				\
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
 		 zpool_get_type((p)->zpool))
@@ -1047,7 +1061,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 				 swp_entry_t swpentry)
 {
 	struct xarray *tree;
-	pgoff_t offset = swp_offset(swpentry);
+	pgoff_t offset = zswap_tree_index(swpentry);
 	struct folio *folio;
 	struct mempolicy *mpol;
 	bool folio_was_allocated;
@@ -1463,7 +1477,7 @@ static bool zswap_store_page(struct page *page,
 		goto compress_failed;
 
 	old = xa_store(swap_zswap_tree(page_swpentry),
-		       swp_offset(page_swpentry),
+		       zswap_tree_index(page_swpentry),
 		       entry, GFP_KERNEL);
 	if (xa_is_err(old)) {
 		int err = xa_err(old);
@@ -1612,7 +1626,7 @@ bool zswap_store(struct folio *folio)
 bool zswap_load(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
-	pgoff_t offset = swp_offset(swp);
+	pgoff_t offset = zswap_tree_index(swp);
 	bool swapcache = folio_test_swapcache(folio);
 	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
@@ -1670,7 +1684,7 @@ bool zswap_load(struct folio *folio)
 
 void zswap_invalidate(swp_entry_t swp)
 {
-	pgoff_t offset = swp_offset(swp);
+	pgoff_t offset = zswap_tree_index(swp);
 	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 
@@ -1682,6 +1696,16 @@ void zswap_invalidate(swp_entry_t swp)
 		zswap_entry_free(entry);
 }
 
+#ifdef CONFIG_VIRTUAL_SWAP
+int zswap_swapon(int type, unsigned long nr_pages)
+{
+	return 0;
+}
+
+void zswap_swapoff(int type)
+{
+}
+#else
 int zswap_swapon(int type, unsigned long nr_pages)
 {
 	struct xarray *trees, *tree;
@@ -1718,6 +1742,8 @@ void zswap_swapoff(int type)
 	nr_zswap_trees[type] = 0;
 	zswap_trees[type] = NULL;
 }
+#endif /* CONFIG_VIRTUAL_SWAP */
+
 
 /*********************************
 * debugfs functions
-- 
2.47.1


