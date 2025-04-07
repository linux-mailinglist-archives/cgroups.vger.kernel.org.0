Return-Path: <cgroups+bounces-7414-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B974A7F164
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 01:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715551899B5D
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A096C255244;
	Mon,  7 Apr 2025 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbbpSh0P"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A180F254AE7;
	Mon,  7 Apr 2025 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069356; cv=none; b=YTqhWzmbyfYfKBNeZej6SSTB2bPKYcgYIZfD0y3XQ3GVrk8Juo4pudy5CgRk4aEz6pfZBNMo3bdkW3Q6JVp399tRvQ1vnA78gMusLNqfX1sZ2dg+wru8bkGz0F/UVSEdTn3jl8pdOPRGPVdeXDaI0Hnh6/PZ91kmmXVLaQXD4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069356; c=relaxed/simple;
	bh=2YQkjhUo7WUNeYTKn8u9eXhw+WcOSVKddEOQJrQYcSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKztQhP6NHt5kiYqFixFXomEaj9JuUEyHTlLJWnvRA48ZDGplI3H57SWRmxIVRQr0glyQ7bL8H9fmGN7QJk14X1q6RRqiL6mc3EsQQDC2FnPasTLcdEDwHOLI2DJJfFlu0/v14jZ9gc8/LYS8VXuKvpliubn5pX/rxITQzR8eX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbbpSh0P; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e6e1cd3f1c5so3251114276.0;
        Mon, 07 Apr 2025 16:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069352; x=1744674152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLJdhqYj+zTYLwyNRCW52GVf6fq8/yyGxPtSSQksBmE=;
        b=gbbpSh0PJ4EeOQ+oVjsmpTDbg1uZ6SDuBcOjpZiv9G9Dn02t6RNq06CCYqohy81mSj
         AgTwl1CUarADAT8pg8aB2ka2TNBaUO2L1NOe6UBdI7ndzQPxBPT1iVczcHKZXJHS1Ve+
         9w+R52DoW7H6hK7oj0PihI39mfdYJpY5HPWbIIyCnx8ZMyV5knxxANEHV2/2S6yO33wJ
         2MZy1txN/HHNcABbAPcIkxkbjqFXh+aRZHRuiAEShj9Pi0XuWcv1hOtZXWN/40jGcxCS
         Fgrwp2rNOqZ88KcjBd7X8d2IMru683Xy3fcTQiN2JPn0/lURUFfXDLml+0/eMBF9UIME
         PtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069352; x=1744674152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLJdhqYj+zTYLwyNRCW52GVf6fq8/yyGxPtSSQksBmE=;
        b=NNzC3fHIR/g5L4gT9q7nhkbXt8vqyS7Pc5umehdOfA9R9srqFtohBzriduRcYMe9GH
         CJpVhkJVFhkLiRdvJ7r1cHCXCdm4mi4pnm7XAih4i8He5y5q0BK0fhVABnL39rrQrDN0
         J3xP89FyhZcOowPjuezSqq75nBnElTv6bYm5coVhvPyVr/W/+VYfC9sPMZdla7UdG3xd
         U8v5R5kuHtSCYb+BY/5NmsuQ//MFwbnSzMHYgjZDLZ1by1TbWIZJurQMJRE4ZXQ63SeD
         TXDP0ZeP8rDGiHS3EI1Y+qzcKcJD+DAdOmtjPZlhd7y5Yt17vGQ3oO52Hlrio7X+ecd7
         dHzg==
X-Forwarded-Encrypted: i=1; AJvYcCW3bRSASg0wOnf0sQDCNImMvT+xeGfXUYmxeB6svBN70PbhBorByZZSigspKg+8Ix0twRuK0vqoCDi+yzqP@vger.kernel.org, AJvYcCWFIQ6a2s3TKUeGqyXWdJM8IzsRRCFI4v5SfKEJM/C1ZWdxHtIoNJci5kKYRWGQjdtrMq8zkddLUfU=@vger.kernel.org, AJvYcCWUFHfsfIPKhk4RDwLl/ISTZIoeDk4qSgAx0sLV5L05X0PFSsDXRJN0AFEWM+arApgUb0pfn8mY@vger.kernel.org
X-Gm-Message-State: AOJu0YwPKcstZ7DVERq4wMelVkRoL3qOQnnf/KAo4aeJa8EmF3yiO2fi
	lOuFl53y9PaPczxbnQ7qRa+DDfKutvRiNdqSTpScnOXIGyIbQFNB
X-Gm-Gg: ASbGnct+pMAW0byV0/uT1p03irWS69Hnu8ddWh2SlPwvz/61RmchlwfYFHjXG8wIB93
	35T6DCWKcAk1eNAyA/Kcw6IksZx92vHDtmehXjAkJsDvDLR8YOORvFIZ00gSCU5wVO0eECxFK64
	A28LZZ2/9YY6iJ6pzfwIJZroWynHQKTVME3wyA3635MybyE6KsmogSedE4+nfSyQ9mi2nBztjjY
	nS82Z/2lC7kG01+SfhtFKGkTUvrmzklXQF2ffnQ1SWmHo68jkZunQxPwC1WiF7wvpmuKGrQ/fOl
	tsLi1kgRBQh/M51iUa7VMC8Id7rhrbnK3KVU
X-Google-Smtp-Source: AGHT+IFYT4abdql8kqgVGeGYJ9Wg2G43qD5+sFoTbpPfUBUetFZ6KN/IufxrelAcp5w2iktxFkJT+Q==
X-Received: by 2002:a05:690c:7207:b0:6f9:7ec7:386a with SMTP id 00721157ae682-703f41bbb6cmr186335597b3.21.1744069352322;
        Mon, 07 Apr 2025 16:42:32 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1e7731fsm28302937b3.58.2025.04.07.16.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:42:32 -0700 (PDT)
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
Subject: [RFC PATCH 12/14] vswap: support THP swapin and batch free_swap_and_cache
Date: Mon,  7 Apr 2025 16:42:13 -0700
Message-ID: <20250407234223.1059191-13-nphamcs@gmail.com>
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
 mm/vswap.c           | 89 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 16 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 98cdfe0c1da7..c3a10c952116 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -763,6 +763,7 @@ bool vswap_folio_backed(swp_entry_t entry, int nr);
 void vswap_store_folio(swp_entry_t entry, struct folio *folio);
 void swap_zeromap_folio_set(struct folio *folio);
 void vswap_assoc_zswap(swp_entry_t entry, struct zswap_entry *zswap_entry);
+bool vswap_can_swapin_thp(swp_entry_t entry, int nr);
 
 static inline bool trylock_swapoff(swp_entry_t entry,
 				struct swap_info_struct **si)
@@ -862,6 +863,11 @@ static inline void vswap_assoc_zswap(swp_entry_t entry,
 {
 }
 
+static inline bool vswap_can_swapin_thp(swp_entry_t entry, int nr)
+{
+	return true;
+}
+
 static inline bool trylock_swapoff(swp_entry_t entry,
 				struct swap_info_struct **si)
 {
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
index c5c34efafa81..5abb464913ef 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4226,10 +4226,8 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
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
@@ -4419,6 +4417,18 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
index fcc7807ba89b..c09a7efc2aeb 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -9,6 +9,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/swap_cgroup.h>
+#include "internal.h"
 #include "swap.h"
 
 /*
@@ -1104,6 +1105,94 @@ bool vswap_folio_backed(swp_entry_t entry, int nr)
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


