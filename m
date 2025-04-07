Return-Path: <cgroups+bounces-7407-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D14BA7F151
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 01:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04DC3B40EC
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A264222D4FD;
	Mon,  7 Apr 2025 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaOA7qnP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B3F22C331;
	Mon,  7 Apr 2025 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069350; cv=none; b=bcBspqWjQ70amCtatZvpph8rH2Gz3Is2comDI4kxN/i56ADpYb/VBuwoU+9MOO6Npz4QVTBTNIbpJvUGDMnOLL5gz/nbAP6R85lmALmgM2P1UkoO6Ru0xt6E6Oyu+cOL8AOfkDsa9MWrgImek/WVBSfdB7sk0Zy9ee6JBm8kh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069350; c=relaxed/simple;
	bh=xGkTVATKl7Dz5MF8/YenF9EkW4XRw9kuAb6cvIvOxVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSlvFMfEX/hJAJTHwVsLfCQ12XPj+XYgyUtHbq+l6ItQqBIbEq9CkaR+I0gHnYdcCP1WAM2ZyvyCbVsp2Vnpzde9MKXqMXI/cVYB5Y2Blw22pVbMPw7GDsO+UnqBbNfZPJYgleCCAJbk1+RenKme1RC9FIdi+fZo5lN0i3Z35PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaOA7qnP; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e6e2a303569so2469350276.0;
        Mon, 07 Apr 2025 16:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069347; x=1744674147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daAcY/nDP4YSMa9CHOT/fNiMPU/yMDIagIbMON6vw+o=;
        b=jaOA7qnP4SIL3d4eLIDe0V+sP2qdUVpbCQPcrYVPmR3Qi42lBHp6SGfcEypn/0yO2T
         kvvmJdnDFLBT1DqcJVJz8KZ8ol28ia69Wt3JdOyb0nkhkiNb2lqhVATqBcSC6b8tPSLc
         zrgEF8r070r/UqHvwSeXPtMHjZnWvl8kt84mNqHmqpxwmwriyjAob1hB64j+x6QSiii8
         KungphvNHmjG3xoqqIXOT8SxN6CuH3zoQ25OdvUIATbvZ5EAZmYBvvZkeZ53DjDHeSe6
         AWiZgKYQz84ZIgNRNePzSQucnruiXPEjSliI0ICgq1dS9gHLiQen4vsbfSp5Kp/JI5rH
         h69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069347; x=1744674147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daAcY/nDP4YSMa9CHOT/fNiMPU/yMDIagIbMON6vw+o=;
        b=qaRIRuGDm2JDMv0vXGHxq+d6Ifmu8kmZqFTW8VDSQGhD4x1n60QQVLRYW10IUSCN9g
         R57w569GBz/OWOGNFgiJKecnAsAFuh+yJ6ozk6KTky3Jnm7qDd7bFe5kGKS1j0DDYoDd
         ECYxJ6KMdYR5/oQfDFb3TfkzmM8ByuOw/ZgBovz1O5tHfUIm2mzc0SBqLLfh1EoACcXp
         6gx9/r9dyRD4YPADJcWRjMzdzXV7ZNl05tQt05/8pyXtenLYKc98XB5a8PNDPI31h9rv
         LpybKgLyDybrCOuJ1ZRtqgL+zYdRv68Mr9CPTcXHsssxmZdJaH4fA4U0CslaYcnrYmLN
         zolQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtBvxaOKaDPTapuEEbkOllovWC8S1nBxOaumvtS1WUeWw2cJruVFYHgT32+UWz34dW2SidkQnQQj8=@vger.kernel.org, AJvYcCW3pqjL5R0Bf9XlU5AVQ3VFgrG2RHRmTx9my1p/ykUyrNYqWoLRUhZMzYAQTBcWTvbjeqrGJjJlVala5nnB@vger.kernel.org, AJvYcCXz56DO/jxKqFIr3dx9m/oyGDYupQxmCM45lXTWOCKA8iEMWZ9zdDRQAiFa/wlgsBmHaETulGf5@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7p6hNorvKlbuGOor5nyVI7lWXL1eeT2nTVXj2e2pQlbipkwX
	0nco4aLfiC2UovrCW86HLpEcd4C+4YtAehYF01nPhrhVwlh2rRv1
X-Gm-Gg: ASbGncuXxHbC/90OSQsRpSwNb/8sNe813dU/bWJmVscoUYLRa04lA+XsDCCvEiLVqB7
	3u9Ci5CMUgz8MXa1V/MEDuhb/Qa58CB5N9g+P6GDQUeisqs+z84YrDSosgbUuYU4mM6aoJbCJHf
	xsUV2qDbHFEU3cXIFRNrWuH7G1sHIpikxH1eV8hYEVFCdMIuJ+dFNGsEGQf85FQb9eFkntrkmgD
	ylenZQcKUGwtYSWidCBs33w9OhE208Po4xaAGzhFhidF4tX9EG4Ot2xJCeMVLb1F/8FfiJb/DdO
	nq0BEtjNetwJERBqwLePr/uw/6hGSIRxAyfYC6GT1rdyCUw=
X-Google-Smtp-Source: AGHT+IF3rCoCu+zrKEAp6pEjJvySTUvUifOvBdVUrbAK8xBJTGqXTP96YZ/RQIeo8ja2gEbN09711w==
X-Received: by 2002:a05:6902:218a:b0:e6b:7a48:b851 with SMTP id 3f1490d57ef6-e6e1fa739f0mr20093696276.36.1744069347267;
        Mon, 07 Apr 2025 16:42:27 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e6e0c8b7c89sm2505675276.8.2025.04.07.16.42.26
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
Subject: [RFC PATCH 05/14] zswap: unify zswap tree for virtualized swap
Date: Mon,  7 Apr 2025 16:42:06 -0700
Message-ID: <20250407234223.1059191-6-nphamcs@gmail.com>
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

Similar to swap cache, the zswap tree code, specifically the range
partition logic, can no longer easily be reused for the new virtual swap
space design. Use a simple unified zswap tree in the new implementation
for now. As in the case of swap cache, range partitioning is planned as
a follow up work.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

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


