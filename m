Return-Path: <cgroups+bounces-14944-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM+xLr2fvWkM/wIAu9opvQ
	(envelope-from <cgroups+bounces-14944-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:27:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8C72DFE8B
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 570AE3013CBF
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 19:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8003502A9;
	Fri, 20 Mar 2026 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTHP6NNO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51534DCE2
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034861; cv=none; b=UeqtsFhOxjvHGIPcbp+1wygPInRPKsz5o6RVSa8RgWBm3BQEmUUYy/Tuu1pjlb7eCdUYJ1+AIlpM95XTB8kAhp0YwyMV1v2apMUY55rTMt3vuen30WnDppRV5/EmVYGGbO2hnc6ySngB7iW2pK3Gy9mEMPHXlOGHKr2DlRnni6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034861; c=relaxed/simple;
	bh=E7IvwqT01r9Y9AARhPTA4kVsR7QTb37BUUQJU1OMnqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9esIll7Jx77focRasGIWkfZl2ytIttCbVTksJ4jQz2lMch9YSUj+Myrp0rejKAhl0g3IhgvRNWc8aiTXFPyMbwcyp8rYpj45mm00GrR2rgLAZEKz5RAGgMW7a66zwGAnQBfrAqNbgpTKxdt61wxkG16n5GeKhlUkjG38J+ud3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTHP6NNO; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4670676ba03so824789b6e.1
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 12:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034859; x=1774639659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQz9gXtG0BjRbamDLXajf4zSV33YchOog2Zf6fZXOug=;
        b=bTHP6NNOOOBWwNzOYVSLxqxd3JWxnfEPnUL9p5qSoS8xWh/o3/wwoD3ZifS3M9zupP
         UoUdsWpEKcGkX8bDy1Xq/zb64gDbTw9B7+8BUIEoLUzuKMcKCEgP7/WsPt/KTLFUFi60
         OZucRlE7qbhRO7/loFA0uIvvJOLn2v+MSx6ULqiY9rwIhi8sNvJuN4YK0L/PSeCFOPog
         KNlrPg57brPtAbmHDwrXSFcHjGFStEAU2K4B3WTxxkzT9OQlkN940QtIMMjYGpW/tvr8
         tadkWRTmOdj14o2yXSphyGdGmOOr2/QGbDQUrncyV4FQ+EqOJtcz2myym4FFIjmBwQ0z
         7Kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034859; x=1774639659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQz9gXtG0BjRbamDLXajf4zSV33YchOog2Zf6fZXOug=;
        b=pTvJ2GQQTTTNLyvoljf5hKnpAU3tVz72Ad1BM6iwKUSNcKlf1CaoI8H4igLQfeIK22
         Q7tkMLBY/c6a/jrOz2scIPbHn+ghTi57J/tEeAXAK8+K0q3l0ghut9PN21rrAanyTuaJ
         ciYo4pKZYSYNEFaGRRDotfwSpEo0ea87giyaf0ANn8olO4kK8WFmztpXCckPXLjmfwCk
         liBtpjVcPwNSGWU08j+a4o1GlwR5rUF6MuA1pjWy51+6e9pI2K8xuDRVPixx3xvrvxwl
         QpRsk9TOvkCCj8l3sEiOjeg3j6ZQKXCgsfCWnK7TK0bGT/cB4+qbSOLPuWwe6XGc9Ynz
         +XCw==
X-Forwarded-Encrypted: i=1; AJvYcCXNVa79gcX+F6y9bYRzsWf/3SrMjqlyeKWySPJQ2a2By3saUZWtOIBa9Ejyk4MlvEkVtG4J4+bY@vger.kernel.org
X-Gm-Message-State: AOJu0YzOYLBc4/PI8gGwJs501+MdOK34OY75vkOvLlI2/RC9PBT90yFI
	WzkrOPSmP/CgN0trV+vPlbBwgcFWubdTiLJ8ksvXrZloRR2XuMsS7eU+
X-Gm-Gg: ATEYQzzeNqV6oE4i1gHFiGhjHJdje3mFXwbuOP3YDhnQziYCVoleetYUJGyCZqoipXY
	9PMzZfDarDPdRhkY+cEmSeOSnxOJWAYpAMr9vE0m4MvxZqVuXU5ruXL+xipYwrZPGMa2+pYG/KD
	U8plcMqOLyJqf9R9gXa41n1qX0N7ztImbMyj2v+FyWQIqX6Q0LG0ot4a9SPMw7UvSQJKkMExi1b
	Kp0ev8e7YxNdDQDTXPbZ8+DLW05ZjBJqsVLQ9K4029TioXX2Oz+vcbvR3aRgQzu/KLwclG3Wr+s
	/0tCoU1UtPDnOM2sdKUNjO9+LGh9FrdRIEOh6v3P/JCs3L2fzqkouujVZIzTHgBwJS4C/tJ0zg4
	ViNPEvuEkvKWRelZCZ6WuUrOh8+cWYHI/xtWH0lG4tgwfHtPEOOKAOA0/5PfAkAxjL0Kj8sgP4F
	UQ1NenvKGdxNd0BddONlJKhjhMtHyjOgSryWlHYqXMyU1saA==
X-Received: by 2002:a05:6808:1645:b0:462:dc57:f8ba with SMTP id 5614622812f47-467e5f095d0mr2364034b6e.27.1774034859050;
        Fri, 20 Mar 2026 12:27:39 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14ddbca8sm2951988fac.15.2026.03.20.12.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:27:38 -0700 (PDT)
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
	riel@surriel.com
Subject: [PATCH v5 02/21] swap: rearrange the swap header file
Date: Fri, 20 Mar 2026 12:27:16 -0700
Message-ID: <20260320192735.748051-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320192735.748051-1-nphamcs@gmail.com>
References: <20260320192735.748051-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14944-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.839];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E8C72DFE8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the swap header file (include/linux/swap.h), group the swap API into
the following categories:

1. Lifecycle swap functions (i.e the function that changes the reference
   count of the swap entry).

2. Swap cache API.

3. Physical swapfile allocator and swap device API.

Also remove extern in the functions that are rearranged.

This is purely a clean up. No functional change intended.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h | 53 +++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 38ca3df687160..aa29d8ac542d1 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -423,20 +423,34 @@ extern void __meminit kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
 
-int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
-		unsigned long nr_pages, sector_t start_block);
-int generic_swapfile_activate(struct swap_info_struct *, struct file *,
-		sector_t *);
-
+/* Lifecycle swap API (mm/swapfile.c) */
+int folio_alloc_swap(struct folio *folio);
+bool folio_free_swap(struct folio *folio);
+void put_swap_folio(struct folio *folio, swp_entry_t entry);
+void swap_shmem_alloc(swp_entry_t, int);
+int swap_duplicate(swp_entry_t);
+int swapcache_prepare(swp_entry_t entry, int nr);
+void swap_free_nr(swp_entry_t entry, int nr_pages);
+void free_swap_and_cache_nr(swp_entry_t entry, int nr);
+int __swap_count(swp_entry_t entry);
+bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
+int swp_swapcount(swp_entry_t entry);
+
+/* Swap cache API (mm/swap_state.c) */
 static inline unsigned long total_swapcache_pages(void)
 {
 	return global_node_page_state(NR_SWAPCACHE);
 }
-
-void free_swap_cache(struct folio *folio);
 void free_folio_and_swap_cache(struct folio *folio);
 void free_pages_and_swap_cache(struct encoded_page **, int);
-/* linux/mm/swapfile.c */
+void free_swap_cache(struct folio *folio);
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
@@ -452,26 +466,15 @@ static inline long get_nr_swap_pages(void)
 	return atomic_long_read(&nr_swap_pages);
 }
 
-extern void si_swapinfo(struct sysinfo *);
-int folio_alloc_swap(struct folio *folio);
-bool folio_free_swap(struct folio *folio);
-void put_swap_folio(struct folio *folio, swp_entry_t entry);
-extern swp_entry_t get_swap_page_of_type(int);
-extern int add_swap_count_continuation(swp_entry_t, gfp_t);
-extern void swap_shmem_alloc(swp_entry_t, int);
-extern int swap_duplicate(swp_entry_t);
-extern int swapcache_prepare(swp_entry_t entry, int nr);
-extern void swap_free_nr(swp_entry_t entry, int nr_pages);
-extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
+void si_swapinfo(struct sysinfo *);
+swp_entry_t get_swap_page_of_type(int);
+int add_swap_count_continuation(swp_entry_t, gfp_t);
 int swap_type_of(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
-extern unsigned int count_swap_pages(int, int);
-extern sector_t swapdev_block(int, pgoff_t);
-extern int __swap_count(swp_entry_t entry);
-extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
-extern int swp_swapcount(swp_entry_t entry);
+unsigned int count_swap_pages(int, int);
+sector_t swapdev_block(int, pgoff_t);
 struct backing_dev_info;
-extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
+struct swap_info_struct *get_swap_device(swp_entry_t entry);
 sector_t swap_folio_sector(struct folio *folio);
 
 static inline void put_swap_device(struct swap_info_struct *si)
-- 
2.52.0


