Return-Path: <cgroups+bounces-7913-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5635AA3C60
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF0F16E94A
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5162DCB69;
	Tue, 29 Apr 2025 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZRAsKZz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D921767D;
	Tue, 29 Apr 2025 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969933; cv=none; b=F692B7FjC1ZmztJDoWDf/AcoK0jbqe5ZOPeQqFAC6ZxSA5fWBhzujQGDAjQS4l/QMM8ANePg0UdekA/VBHu9VnWnc6EcAyO46vtVne+LidDK/rMfo+XcUUWY95e4JkqN5dTp1CWy+4Rz7IRr34c8pZrEKG7OEeepFsQ1HwfWvGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969933; c=relaxed/simple;
	bh=9lfn7Mdrh8XNMBCIBDTXYW/OeN0hzWBMyVinBrI4kxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feI0nmEgEyzEF+5bDD3XTG1aEF7N0sg0JcY3tZBxddfAXqX1rh/a2yA/wMXrg0ERkdRUAPnI7K80qfWwOofzi0YjywQ8BG+pc48xaD4FkvYHssny6RMCI5FW3TA9kx36meJXMT6v2dBBi7lcuuB0mKtPRCgGUdBIsL28PlVtg9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZRAsKZz; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e72c2a1b0d4so6338235276.2;
        Tue, 29 Apr 2025 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969930; x=1746574730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qBYzjibBJx9rHZLcTQDEGn367QWHS1A048569h/uvM=;
        b=dZRAsKZzhcvlY3uKeeyJL+h5abKDODq+ZhZwcWaiElLiiMY4n8jxVQwdMuNJRIIS82
         s951qOk91u2gXqpYbqdJcXYeq/WZs+2+PkP0+aiMJz2sL+HLH3x0+Asotc265sXgwYp5
         zP8iC0U+23N+sCPdswsXkIJZlrLX9zGxZv62UzqZM5ltehN+ASYzQ0RBodAn9qlUeVmu
         BddSd+CmEffUlr4xtznpUHCOUbQi7bnk8IIQbgGo/vfBQRFeUcjotfnWjAk85w38Re+o
         fn9WYrIRzEzmBxzAhLk3ITBuTyJ4ygTk30ksHHiFGdRmMwWe1XvVFDcBVfNjep/OVFuS
         2v0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969930; x=1746574730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qBYzjibBJx9rHZLcTQDEGn367QWHS1A048569h/uvM=;
        b=Za1hDRqvgrAKIUz+ECyuJp6RKtgndeA6yTQ9gd7MCs81Lb+w5Jk/AdN5oWbAoav63g
         mmgQ0pbul1ymAn/vJsVrt1KaSTS8KFhXbrZMGM2rQ9/DS9mYHqrSXMciai572Dus2Qwp
         1bGM8rxRdGp0pykSu1884xBR+O1Mste5hlPZD8b6hWbyjg3qTaZoZ+aXrOx+xmHSj1Ek
         Vpe1FwWgGk+/rmrqIiNCTJAw0y12w91eC4bHd8NgAjbci785swNBTEFQ5oUWwBHsSop2
         TmVS+ji7Flqdvsr33Cpu+ZrqRYdz8apEkL887jfLljUEDA8BnJtGlVFKSHtImZSZ5+H+
         l6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUbVi3j10+v+BRNbOdsh8DEXOIpZuBkc2uE+xkb/gzPlgJ2G6QzOxbq54lT4MXRlMA9U8iaqj/v4f4=@vger.kernel.org, AJvYcCUkkVRS91W7M4zd2kQ8Aav7EMt9ve1BPUKpJuPcFjFMJcCWOHm08v8UUwRT08bsaRIIsEFcHETJ@vger.kernel.org, AJvYcCWtVaQB8dHbCaJL6eLEoLLd/3iLbprdxIToFAEU1UpHC4Hx2yQ3EOyRSjuls5J89HDj0/Cd8y0/U8fhaj1u@vger.kernel.org
X-Gm-Message-State: AOJu0YyqSBTqN0nmZ25s3LxVWfCpxq0VNRql0DmHZmTjwMoyHALGmlmo
	PYrzn2PRQKCO2zNLgPAg9R6g/x4F2rxQySxT8+WFt4iIgxIlzf8N
X-Gm-Gg: ASbGnctVnfMwv/gkP652sGqPhOHAy57WM8jHqFNYCoYqCSeuzNzXkJ79b02XvyMty3h
	VtE5VVJLz/9P2Me98LgpNRd9Hod15FIWWx+SXIqz13/CQBNGrE2ChGlO1cabXc6+X6Ezk/51U2a
	AtWR5YfBS2tC3nPkzIomY0I76JTZv+yfi//o6XVc3Ihdpbit0t5cs04Tn+4XBxCEoaJ0/ZWXWn1
	U+Mwngysq/yxi0SMxfJVf3EibCdARC/JyBogjOq9lcL+lE7lOjtElii9vQpPrXMoA/Kru7ozB8l
	OXnGnxeKPimP+82vwLAGti2lnQEqwyTxRW2KHmf7NWs=
X-Google-Smtp-Source: AGHT+IHdxLhTmtD4Ht9GO+oV1MromZ9Nj3cR1phCcjSOrLEmdVAvEWKlu3ewjdvFFLOqR9mFjIe3Tw==
X-Received: by 2002:a05:6902:150a:b0:e73:124b:95c4 with SMTP id 3f1490d57ef6-e740412f1e7mr1147823276.13.1745969930578;
        Tue, 29 Apr 2025 16:38:50 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7412e1f0a4sm63120276.17.2025.04.29.16.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:38:50 -0700 (PDT)
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
Subject: [RFC PATCH v2 01/18] swap: rearrange the swap header file
Date: Tue, 29 Apr 2025 16:38:29 -0700
Message-ID: <20250429233848.3093350-2-nphamcs@gmail.com>
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

In the swap header file (include/linux/swap.h), group the swap API into
the following categories:

1. Lifetime swap functions (i.e the function that changes the reference
   count of the swap entry).

2. Swap cache API.

3. Physical swapfile allocator and swap device API.

Also remove extern in the functions that are rearranged.

This is purely a clean up. No functional change intended.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h | 63 +++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index b13b72645db3..8b8c10356a5c 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -453,24 +453,40 @@ extern void __meminit kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
 
-int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
-		unsigned long nr_pages, sector_t start_block);
-int generic_swapfile_activate(struct swap_info_struct *, struct file *,
-		sector_t *);
-
+/* Lifetime swap API (mm/swapfile.c) */
+swp_entry_t folio_alloc_swap(struct folio *folio);
+bool folio_free_swap(struct folio *folio);
+void put_swap_folio(struct folio *folio, swp_entry_t entry);
+void swap_shmem_alloc(swp_entry_t, int);
+int swap_duplicate(swp_entry_t);
+int swapcache_prepare(swp_entry_t entry, int nr);
+void swap_free_nr(swp_entry_t entry, int nr_pages);
+void free_swap_and_cache_nr(swp_entry_t entry, int nr);
+int __swap_count(swp_entry_t entry);
+int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry);
+int swp_swapcount(swp_entry_t entry);
+
+/* Swap cache API (mm/swap_state.c) */
 static inline unsigned long total_swapcache_pages(void)
 {
 	return global_node_page_state(NR_SWAPCACHE);
 }
-
-void free_swap_cache(struct folio *folio);
 void free_page_and_swap_cache(struct page *);
 void free_pages_and_swap_cache(struct encoded_page **, int);
-/* linux/mm/swapfile.c */
+void free_swap_cache(struct folio *folio);
+int init_swap_address_space(unsigned int type, unsigned long nr_pages);
+void exit_swap_address_space(unsigned int type);
+
+/* Physical swap allocator and swap device API (mm/swapfile.c) */
+int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
+		unsigned long nr_pages, sector_t start_block);
+int generic_swapfile_activate(struct swap_info_struct *, struct file *,
+		sector_t *);
+
 extern atomic_long_t nr_swap_pages;
 extern long total_swap_pages;
 extern atomic_t nr_rotate_swap;
-extern bool has_usable_swap(void);
+bool has_usable_swap(void);
 
 /* Swap 50% full? Release swapcache more aggressively.. */
 static inline bool vm_swap_full(void)
@@ -483,31 +499,18 @@ static inline long get_nr_swap_pages(void)
 	return atomic_long_read(&nr_swap_pages);
 }
 
-extern void si_swapinfo(struct sysinfo *);
-swp_entry_t folio_alloc_swap(struct folio *folio);
-bool folio_free_swap(struct folio *folio);
-void put_swap_folio(struct folio *folio, swp_entry_t entry);
-extern swp_entry_t get_swap_page_of_type(int);
-extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
-extern int add_swap_count_continuation(swp_entry_t, gfp_t);
-extern void swap_shmem_alloc(swp_entry_t, int);
-extern int swap_duplicate(swp_entry_t);
-extern int swapcache_prepare(swp_entry_t entry, int nr);
-extern void swap_free_nr(swp_entry_t entry, int nr_pages);
-extern void swapcache_free_entries(swp_entry_t *entries, int n);
-extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
+void si_swapinfo(struct sysinfo *);
+swp_entry_t get_swap_page_of_type(int);
+int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
+int add_swap_count_continuation(swp_entry_t, gfp_t);
+void swapcache_free_entries(swp_entry_t *entries, int n);
 int swap_type_of(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
-extern unsigned int count_swap_pages(int, int);
-extern sector_t swapdev_block(int, pgoff_t);
-extern int __swap_count(swp_entry_t entry);
-extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry);
-extern int swp_swapcount(swp_entry_t entry);
+unsigned int count_swap_pages(int, int);
+sector_t swapdev_block(int, pgoff_t);
 struct swap_info_struct *swp_swap_info(swp_entry_t entry);
 struct backing_dev_info;
-extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
-extern void exit_swap_address_space(unsigned int type);
-extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
+struct swap_info_struct *get_swap_device(swp_entry_t entry);
 sector_t swap_folio_sector(struct folio *folio);
 
 static inline void put_swap_device(struct swap_info_struct *si)
-- 
2.47.1


