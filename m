Return-Path: <cgroups+bounces-7927-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F760AA3CC1
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5314E22E5
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A578D24677B;
	Tue, 29 Apr 2025 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k26FpIr2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1347F2E62D8;
	Tue, 29 Apr 2025 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969946; cv=none; b=Ix8ldi58j6UFZUwfxzzxQUV6iSOny9VTRDEy8GRGvAn7kR0buU6qJNrFT3rotoop9Tcsh4NichW4m5gzKvRMFQKMM+HG8FSssKHltd0JI1vELlWVJzF/3NwoRsja4x9J3RhujFL3co587aug3YQQxNhi6kmmjpPKa5Y2bWgOB68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969946; c=relaxed/simple;
	bh=PrhZu9UGS1Zo3iBepaZyF3RiCrxHnnORdIJ+ZCLi0eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmKPk8FKiiwzaFMWfxj18V/LY8cuVYalYZ9oCQHYKUGjba4Xdz8Zb65CTxTBXMAjmu9TEA32cD5O4VBbWytD5yGYr8jAJ8JB7s/F0n31WmVR4/7sQrSDQlFnMzKWJHUpyabb69KDDlExSLZkftv3Rw0uvKUUqD99VDxwDCSu3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k26FpIr2; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7082ad1355bso56757557b3.1;
        Tue, 29 Apr 2025 16:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969943; x=1746574743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMZjxyYXXDk1gidKnzSq/7a4QhnBooZEU1T9UUeNwgw=;
        b=k26FpIr2TTHTrppxgZmi5qXBcqFOUorYpWlkhI73rC86i+KyfGYf9V8W4RDU4lt24b
         kpXnZ9A8djTGo0wzhCuJ5deWlgky/ov7/xZT+bWm9q/yp+Ef0UVb+iE+3L4k073itHlq
         bTs1seApQp5i20W54TYsh0XX8fatwCeNaS1VukT4eMQVmKDF7KvIeNYSi6auBfEuBAm4
         JzJaFC6Lv2CqLbPVbw4qxU3uU/iWU6LB60b8Ff0pxEIoiGaMuJQkHbLV+dqnEqyxOOTm
         xebB6549DCx/iFskyfAykTiw4Q9LN8vnrE3vzV2OY5zJH6kM6mkw9brlaZ+pwuXWTBMA
         tA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969943; x=1746574743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMZjxyYXXDk1gidKnzSq/7a4QhnBooZEU1T9UUeNwgw=;
        b=TyLpqJKVihY7FmK2oXW8IwLaQWVh0NkejnYhc5vlTiL6VZ4D8Pj8nIem0JfFR8ag8X
         9eSyett2vENpNfs98LcU/2QO16MI8fLS6dBABS7ZmEgR7p666hgXR2G7KzI6LHAosSuc
         NB5chvBqWzGgqrm7t2P65pZCGZnXt9nzAjjhASR9oZcrOT2ZFghcKEz9zxwvNi87JQED
         7SdzUC5VZkrAk/RUoQg+MHZ2WCCWScqjBXbplGRegSVH6BnzffiSJ/STDiXzS+b0tyZC
         1I8sroUCnpn2xO+9LPzydKL3xKyZw9Ra/QAWFL/IerBEXLiO58cSeQ03QbtUMuwayggY
         DqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCjt/ks4LnGd+tFGw+Dd135pagiqS8lRKxDolmaK0pyjhIjIzekYEKRrXzcx7XtN6B54MwEOvWJUA=@vger.kernel.org, AJvYcCWHyk5aZ9DjdlHP+R5rCPQb3Gj18R9TFgnreou+1ngzePZAE/Y9XOx1zvCGzm4JObqnnqjs8zYnZ/sjK5X3@vger.kernel.org, AJvYcCWr5dafU8Cnj5yoDE1jgd2XvWLmMea5qwdNxfUr3RV36YYKYYtTG9Z1QMsLiE0uTmkNb6YK6vsx@vger.kernel.org
X-Gm-Message-State: AOJu0YzNhqGVt658j6EvuWLM2Vj9v1JthtCqHXTUHTuCJzN0s9i/V3rW
	cs5ukmW36RoGyRmQVpUtiNYGeBcUh87mzQdUik+bdAqXLcy7WxXx
X-Gm-Gg: ASbGnculfxJiA/twUQICiU0GMLhY+bYBv7At04/zDDRSi3JwA4gI1+YRCyx1/NnQ4oA
	crGyU92mBPqEqpdebkp2UxRBhBXsY5glIdQ+Zyk+suBBvFiCGSWpB12T4IwaSK9YumpStY8863z
	DHW3lcb4D5fLPHm3uTduRHSN/L1DOnfV8hDuL3NW/A9jtkfpPEt0qzQK9w0hL+Z8koP63JwuWmt
	kvwOA5vrcfZgR86FoWrNmXAtgjv1nau+RovV1jP66+59QiVfso7zwl0GjgatiG7811Lia5PBEjC
	1DZbjPR7iWABfCyYdd5F8tkNu0sGUGI=
X-Google-Smtp-Source: AGHT+IGELX37yPB7pWIFLWi40woXsWK753X8DNcmjzLObYxT76mYAq69pGlTXHByb9H+htTw1h1vuw==
X-Received: by 2002:a05:690c:6e01:b0:6fb:a4e6:7d52 with SMTP id 00721157ae682-708abe47dfdmr21530177b3.35.1745969942983;
        Tue, 29 Apr 2025 16:39:02 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708ae1e9ea3sm701667b3.105.2025.04.29.16.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:39:02 -0700 (PDT)
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
Subject: [RFC PATCH v2 15/18] vswap: support THP swapin and batch free_swap_and_cache
Date: Tue, 29 Apr 2025 16:38:43 -0700
Message-ID: <20250429233848.3093350-16-nphamcs@gmail.com>
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

This patch implements the required functionalities for THP swapin and
batched free_swap_and_cache() in the virtual swap space design.

The central requirement is the range of entries we are working with must
have no mixed backing states:

1. For now, zswap-backed entries are not supported for these batched
   operations.
2. All the entries must be backed by the same type.
3. If the swap entries in the batch are backed by in-memory folio, it
   must be the same folio (i.e they correspond to the subpages of that
   folio).
4. If the swap entries in the batch are backed by slots on swapfiles, it
   must be the same swapfile, and these physical swap slots must also be
   contiguous.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  6 +++
 mm/internal.h        | 14 +------
 mm/memory.c          | 16 ++++++--
 mm/vswap.c           | 91 +++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 110 insertions(+), 17 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a65b22de4cdd..c5a16f1ca376 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -773,6 +773,7 @@ bool vswap_folio_backed(swp_entry_t entry, int nr);
 void vswap_store_folio(swp_entry_t entry, struct folio *folio);
 void swap_zeromap_folio_set(struct folio *folio);
 void vswap_assoc_zswap(swp_entry_t entry, struct zswap_entry *zswap_entry);
+bool vswap_can_swapin_thp(swp_entry_t entry, int nr);
 #else /* CONFIG_VIRTUAL_SWAP */
 static inline int vswap_init(void)
 {
@@ -839,6 +840,11 @@ static inline void vswap_assoc_zswap(swp_entry_t entry,
 				struct zswap_entry *zswap_entry)
 {
 }
+
+static inline bool vswap_can_swapin_thp(swp_entry_t entry, int nr)
+{
+	return true;
+}
 #endif /* CONFIG_VIRTUAL_SWAP */
 
 static inline bool trylock_swapoff(swp_entry_t entry,
diff --git a/mm/internal.h b/mm/internal.h
index 51061691a731..6694e7a14745 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -268,14 +268,7 @@ static inline swp_entry_t swap_nth(swp_entry_t entry, long n)
 	return (swp_entry_t) { entry.val + n };
 }
 
-/* temporary disallow batched swap operations */
-static inline swp_entry_t swap_move(swp_entry_t entry, long delta)
-{
-	swp_entry_t next_entry;
-
-	next_entry.val = 0;
-	return next_entry;
-}
+swp_entry_t swap_move(swp_entry_t entry, long delta);
 #else
 static inline swp_entry_t swap_nth(swp_entry_t entry, long n)
 {
@@ -344,8 +337,6 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
  * max_nr must be at least one and must be limited by the caller so scanning
  * cannot exceed a single page table.
  *
- * Note that for virtual swap space, we will not batch anything for now.
- *
  * Return: the number of table entries in the batch.
  */
 static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
@@ -360,9 +351,6 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 	VM_WARN_ON(!is_swap_pte(pte));
 	VM_WARN_ON(non_swap_entry(entry));
 
-	if (IS_ENABLED(CONFIG_VIRTUAL_SWAP))
-		return 1;
-
 	cgroup_id = lookup_swap_cgroup_id(entry);
 	while (ptep < end_ptep) {
 		pte = ptep_get(ptep);
diff --git a/mm/memory.c b/mm/memory.c
index d9c382a5e157..b0b23348d9be 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4230,10 +4230,8 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	 * A large swapped out folio could be partially or fully in zswap. We
 	 * lack handling for such cases, so fallback to swapping in order-0
 	 * folio.
-	 *
-	 * We also disable THP swapin on the virtual swap implementation, for now.
 	 */
-	if (!zswap_never_enabled() || IS_ENABLED(CONFIG_VIRTUAL_SWAP))
+	if (!zswap_never_enabled())
 		goto fallback;
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
@@ -4423,6 +4421,18 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				}
 				need_clear_cache = true;
 
+				/*
+				 * Recheck to make sure the entire range is still
+				 * THP-swapin-able. Note that before we call
+				 * swapcache_prepare(), entries in the range can
+				 * still have their backing status changed.
+				 */
+				if (IS_ENABLED(CONFIG_VIRTUAL_SWAP) &&
+						!vswap_can_swapin_thp(entry, nr_pages)) {
+					schedule_timeout_uninterruptible(1);
+					goto out_page;
+				}
+
 				mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
 
 				shadow = get_shadow_from_swap_cache(entry);
diff --git a/mm/vswap.c b/mm/vswap.c
index c51ff5c54480..4aeb144921b8 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -9,6 +9,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/swap_cgroup.h>
+#include "internal.h"
 #include "swap.h"
 
 /*
@@ -984,7 +985,7 @@ void swap_zeromap_folio_set(struct folio *folio)
  *
  * Note that this check is racy unless we can ensure that the entire range
  * has their backing state stable - for instance, if the caller was the one
- * who set the in_swapcache flag of the entire field.
+ * who set the swap cache pin.
  */
 static int vswap_check_backing(swp_entry_t entry, enum swap_type *type, int nr)
 {
@@ -1067,6 +1068,94 @@ bool vswap_folio_backed(swp_entry_t entry, int nr)
 				&& type == VSWAP_FOLIO;
 }
 
+/**
+ * vswap_can_swapin_thp - check if the swap entries can be swapped in as a THP.
+ * @entry: the first virtual swap slot in the range.
+ * @nr: the number of slots in the range.
+ *
+ * For now, we can only swap in a THP if the entire range is zero-filled, or if
+ * the entire range is backed by a contiguous range of physical swap slots on a
+ * swapfile.
+ */
+bool vswap_can_swapin_thp(swp_entry_t entry, int nr)
+{
+	enum swap_type type;
+
+	return vswap_check_backing(entry, &type, nr) == nr &&
+		(type == VSWAP_ZERO || type == VSWAP_SWAPFILE);
+}
+
+/**
+ * swap_move - increment the swap slot by delta, checking the backing state and
+ *             return 0 if the backing state does not match (i.e wrong backing
+ *             state type, or wrong offset on the backing stores).
+ * @entry: the original virtual swap slot.
+ * @delta: the offset to increment the original slot.
+ *
+ * Note that this function is racy unless we can pin the backing state of these
+ * swap slots down with swapcache_prepare().
+ *
+ * Caller should only rely on this function as a best-effort hint otherwise,
+ * and should double-check after ensuring the whole range is pinned down.
+ *
+ * Return: the incremented virtual swap slot if the backing state matches, or
+ *         0 if the backing state does not match.
+ */
+swp_entry_t swap_move(swp_entry_t entry, long delta)
+{
+	struct swp_desc *desc, *next_desc;
+	swp_entry_t next_entry;
+	bool invalid = true;
+	struct folio *folio;
+	enum swap_type type;
+	swp_slot_t slot;
+
+	next_entry.val = entry.val + delta;
+
+	rcu_read_lock();
+	desc = xa_load(&vswap_map, entry.val);
+	next_desc = xa_load(&vswap_map, next_entry.val);
+
+	if (!desc || !next_desc) {
+		rcu_read_unlock();
+		return (swp_entry_t){0};
+	}
+
+	read_lock(&desc->lock);
+	if (desc->type == VSWAP_ZSWAP) {
+		read_unlock(&desc->lock);
+		goto rcu_unlock;
+	}
+
+	type = desc->type;
+	if (type == VSWAP_FOLIO)
+		folio = desc->folio;
+
+	if (type == VSWAP_SWAPFILE)
+		slot = desc->slot;
+	read_unlock(&desc->lock);
+
+	read_lock(&next_desc->lock);
+	if (next_desc->type != type)
+		goto next_unlock;
+
+	if (type == VSWAP_SWAPFILE &&
+			(swp_slot_type(next_desc->slot) != swp_slot_type(slot) ||
+				swp_slot_offset(next_desc->slot) !=
+							swp_slot_offset(slot) + delta))
+		goto next_unlock;
+
+	if (type == VSWAP_FOLIO && next_desc->folio != folio)
+		goto next_unlock;
+
+	invalid = false;
+next_unlock:
+	read_unlock(&next_desc->lock);
+rcu_unlock:
+	rcu_read_unlock();
+	return invalid ? (swp_entry_t){0} : next_entry;
+}
+
 /*
  * Return the count of contiguous swap entries that share the same
  * VSWAP_ZERO status as the starting entry. If is_zeromap is not NULL,
-- 
2.47.1


