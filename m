Return-Path: <cgroups+bounces-7404-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD8A7F143
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 01:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAE417B087
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B2922B59C;
	Mon,  7 Apr 2025 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTaGEybq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968BB15B554;
	Mon,  7 Apr 2025 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069347; cv=none; b=NIXURrl7IuIq91xbGs7iGJX24kd5+b0/ls8abtgtJoLzl/zEyeviQsGI9Y5uJSkHJqmga+LLCBmILLx5juyJCnDqB5sLHOpBLu28/NHPWEUbGikpb9zGxCeY5IpGfPuK2ppeTLKVhKcRdAlhPSe2QMti2DCM0hES/HDPFbQxeWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069347; c=relaxed/simple;
	bh=X/w2JwXFg2063diHOIftUTHwc7nq06mZHGwx8FGtAYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkc42n6SC4+8nftRlc9m8MfvhuQ/PLB6JYAlZeiqGd8GKTPGpVL/2EzRY9bok9gfVXllqcD8DuwXXYrlcKWL8Zhp7G4vNoqEmcWseAKvj42ur8mPkxxqy/xhB/07CI8OhTQFO9CftZWllC87sJvWqlzaSN4X4RYy2XxlvkSusz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTaGEybq; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e5dc299dee9so4780101276.3;
        Mon, 07 Apr 2025 16:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069344; x=1744674144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01NE8d4c5rprciUbZX80cCVvuXYrVzb/ghlV1xi5+yQ=;
        b=UTaGEybqNs1YnffeT6jd5v98ZAUx6ADiqUvqzchJO2Wp/Vg9AVDVLAKoMUlYff5xye
         0wjxccNf/I2X/jWHetPx4fzD9OEkv2hDL5L6KYXdEPlcqAb0+Z/JjUFuKxnAfTC5g6eK
         7psEznvmtQHwVb93o4B4fj1VGEoyUT8vfTLgE0xZa7p+/TTT8J7BzFfCxlYTHfZQnU9Q
         w1yiGyIIZJM4A4OhbRTnxi01OGuKUME7tUywHNH/7mDPn1y3Bnt0iMxy43My+10K7Xe5
         C8Kz+Zvs1Th5Px004Zp9bCg9OofGOHZMpnl96sT222P+U2hsMwUWG5G1rMTwyker9JuE
         7ITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069344; x=1744674144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01NE8d4c5rprciUbZX80cCVvuXYrVzb/ghlV1xi5+yQ=;
        b=NVLYOv05eI87NBs3LctoX4UYW2T7htjAgX8CtsT0UTW/zrIA7Ap1J6HuiPhwheoDbC
         FFS3qNXZq6rWSy/bdGORsThjPPVJMhj7JqHGGDxCpea2pBiyFsL+QNj/yrfNeDx9ytP+
         YgI6Lg/TVaob6ZDG4+VKRabL5O31fCrF6AlLgbELVl8RHpNId+1lrZ/T4DHyyMHsOa1p
         U+I9nidvv2xFyD2U7FdXurWXkfPA0H6j0rIuAAcA15EBS+AVzu0Xb7ME0xhCWArWj9Aw
         xpBg/AEPhLAAYR9EPjj4xu89AzSYoAckQECwSk/mC5fd8Ht5P+OnxWv4fMwU64YFAk6J
         Oypg==
X-Forwarded-Encrypted: i=1; AJvYcCVRuE1GZItEgfuCiHlfZSltlPboaPoGg46ZPRV+27e9p+hmXh7NsAAEKJMa4PQ45pvllovStpX5RUirj9nR@vger.kernel.org, AJvYcCXBri9OLbph5sJYjkJbjyStc0+W1aC8399g+BIucMb5F1apdu+p6O44DnPSL4CTz/NOXzLVqR1Z@vger.kernel.org, AJvYcCXc6JpMIeH1sq1qxuKeXlnTKFNtDteTHmMYsjEYbl5huRxZSSI1qWs6oifFRJki0w19H3yGIWu5iNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT6YRF59BSOnPtIiku/lKqYsoYtjRlFdneJdZSFvvgyVMBA1TF
	MNtgb5LWNDypCllN0dZJJM28OsopAlEIBhEpnk8QON+FZ2ooVj4P
X-Gm-Gg: ASbGncu/CH+6fQuHtJELLp2bpo+TDOMePx2Q2Lj8GGQMjbdO5xDnHJsa/vPUejji/so
	KYzdI5e1Wkz14/84MFAMuLJQl7Dz0u5Pe8Bd792RND2+IyvYYCLp7/omVfv27Xup3nwXiZbVnGV
	kyDtTZGteAkT1uQdVYSj4JqagRKX9ooHuo3YDRJnFfb2QQQ91nRehtoeQ3qfRPDJcbrAHi8BV4I
	3+4Vla/A3ZVX0r2PasXylAKXzTOFxPNGQqAks3g1VDYDp7Fe7LhVEjeWHp6TGgFtc22jRyWbXb+
	/31EFrg07kJzGRqubAaJGOPqY9W2t1yy5OMZ048OdkOpxQ==
X-Google-Smtp-Source: AGHT+IFOp3tUm8iPf6YKwMSQa4oxKFyoh7IrPg9EFNWwYJEdbSfmFgU00UV1NVJA+nwj/GXIF2HQZA==
X-Received: by 2002:a05:690c:650f:b0:702:4eac:175f with SMTP id 00721157ae682-703f42fabfemr190896357b3.31.1744069344383;
        Mon, 07 Apr 2025 16:42:24 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1f6f402sm27825447b3.86.2025.04.07.16.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:42:24 -0700 (PDT)
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
Subject: [RFC PATCH 01/14] swapfile: rearrange functions
Date: Mon,  7 Apr 2025 16:42:02 -0700
Message-ID: <20250407234223.1059191-2-nphamcs@gmail.com>
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

Rearrange some functions in preparation for the rest of the series. No
functional change intended.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swapfile.c | 230 +++++++++++++++++++++++++-------------------------
 1 file changed, 115 insertions(+), 115 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index df7c4e8b089c..27cf985e08ac 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -124,11 +124,6 @@ static struct swap_info_struct *swap_type_to_swap_info(int type)
 	return READ_ONCE(swap_info[type]); /* rcu_dereference() */
 }
 
-static inline unsigned char swap_count(unsigned char ent)
-{
-	return ent & ~SWAP_HAS_CACHE;	/* may include COUNT_CONTINUED flag */
-}
-
 /*
  * Use the second highest bit of inuse_pages counter as the indicator
  * if one swap device is on the available plist, so the atomic can
@@ -161,6 +156,11 @@ static long swap_usage_in_pages(struct swap_info_struct *si)
 /* Reclaim directly, bypass the slot cache and don't touch device lock */
 #define TTRS_DIRECT		0x8
 
+static inline unsigned char swap_count(unsigned char ent)
+{
+	return ent & ~SWAP_HAS_CACHE;	/* may include COUNT_CONTINUED flag */
+}
+
 static bool swap_is_has_cache(struct swap_info_struct *si,
 			      unsigned long offset, int nr_pages)
 {
@@ -1326,46 +1326,6 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 	return NULL;
 }
 
-static unsigned char __swap_entry_free_locked(struct swap_info_struct *si,
-					      unsigned long offset,
-					      unsigned char usage)
-{
-	unsigned char count;
-	unsigned char has_cache;
-
-	count = si->swap_map[offset];
-
-	has_cache = count & SWAP_HAS_CACHE;
-	count &= ~SWAP_HAS_CACHE;
-
-	if (usage == SWAP_HAS_CACHE) {
-		VM_BUG_ON(!has_cache);
-		has_cache = 0;
-	} else if (count == SWAP_MAP_SHMEM) {
-		/*
-		 * Or we could insist on shmem.c using a special
-		 * swap_shmem_free() and free_shmem_swap_and_cache()...
-		 */
-		count = 0;
-	} else if ((count & ~COUNT_CONTINUED) <= SWAP_MAP_MAX) {
-		if (count == COUNT_CONTINUED) {
-			if (swap_count_continued(si, offset, count))
-				count = SWAP_MAP_MAX | COUNT_CONTINUED;
-			else
-				count = SWAP_MAP_MAX;
-		} else
-			count--;
-	}
-
-	usage = count | has_cache;
-	if (usage)
-		WRITE_ONCE(si->swap_map[offset], usage);
-	else
-		WRITE_ONCE(si->swap_map[offset], SWAP_HAS_CACHE);
-
-	return usage;
-}
-
 /*
  * When we get a swap entry, if there aren't some other ways to
  * prevent swapoff, such as the folio in swap cache is locked, RCU
@@ -1432,6 +1392,46 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	return NULL;
 }
 
+static unsigned char __swap_entry_free_locked(struct swap_info_struct *si,
+					      unsigned long offset,
+					      unsigned char usage)
+{
+	unsigned char count;
+	unsigned char has_cache;
+
+	count = si->swap_map[offset];
+
+	has_cache = count & SWAP_HAS_CACHE;
+	count &= ~SWAP_HAS_CACHE;
+
+	if (usage == SWAP_HAS_CACHE) {
+		VM_BUG_ON(!has_cache);
+		has_cache = 0;
+	} else if (count == SWAP_MAP_SHMEM) {
+		/*
+		 * Or we could insist on shmem.c using a special
+		 * swap_shmem_free() and free_shmem_swap_and_cache()...
+		 */
+		count = 0;
+	} else if ((count & ~COUNT_CONTINUED) <= SWAP_MAP_MAX) {
+		if (count == COUNT_CONTINUED) {
+			if (swap_count_continued(si, offset, count))
+				count = SWAP_MAP_MAX | COUNT_CONTINUED;
+			else
+				count = SWAP_MAP_MAX;
+		} else
+			count--;
+	}
+
+	usage = count | has_cache;
+	if (usage)
+		WRITE_ONCE(si->swap_map[offset], usage);
+	else
+		WRITE_ONCE(si->swap_map[offset], SWAP_HAS_CACHE);
+
+	return usage;
+}
+
 static unsigned char __swap_entry_free(struct swap_info_struct *si,
 				       swp_entry_t entry)
 {
@@ -1585,25 +1585,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	unlock_cluster(ci);
 }
 
-void swapcache_free_entries(swp_entry_t *entries, int n)
-{
-	int i;
-	struct swap_cluster_info *ci;
-	struct swap_info_struct *si = NULL;
-
-	if (n <= 0)
-		return;
-
-	for (i = 0; i < n; ++i) {
-		si = _swap_info_get(entries[i]);
-		if (si) {
-			ci = lock_cluster(si, swp_offset(entries[i]));
-			swap_entry_range_free(si, ci, entries[i], 1);
-			unlock_cluster(ci);
-		}
-	}
-}
-
 int __swap_count(swp_entry_t entry)
 {
 	struct swap_info_struct *si = swp_swap_info(entry);
@@ -1717,57 +1698,6 @@ static bool folio_swapped(struct folio *folio)
 	return swap_page_trans_huge_swapped(si, entry, folio_order(folio));
 }
 
-static bool folio_swapcache_freeable(struct folio *folio)
-{
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-
-	if (!folio_test_swapcache(folio))
-		return false;
-	if (folio_test_writeback(folio))
-		return false;
-
-	/*
-	 * Once hibernation has begun to create its image of memory,
-	 * there's a danger that one of the calls to folio_free_swap()
-	 * - most probably a call from __try_to_reclaim_swap() while
-	 * hibernation is allocating its own swap pages for the image,
-	 * but conceivably even a call from memory reclaim - will free
-	 * the swap from a folio which has already been recorded in the
-	 * image as a clean swapcache folio, and then reuse its swap for
-	 * another page of the image.  On waking from hibernation, the
-	 * original folio might be freed under memory pressure, then
-	 * later read back in from swap, now with the wrong data.
-	 *
-	 * Hibernation suspends storage while it is writing the image
-	 * to disk so check that here.
-	 */
-	if (pm_suspended_storage())
-		return false;
-
-	return true;
-}
-
-/**
- * folio_free_swap() - Free the swap space used for this folio.
- * @folio: The folio to remove.
- *
- * If swap is getting full, or if there are no more mappings of this folio,
- * then call folio_free_swap to free its swap space.
- *
- * Return: true if we were able to release the swap space.
- */
-bool folio_free_swap(struct folio *folio)
-{
-	if (!folio_swapcache_freeable(folio))
-		return false;
-	if (folio_swapped(folio))
-		return false;
-
-	delete_from_swap_cache(folio);
-	folio_set_dirty(folio);
-	return true;
-}
-
 /**
  * free_swap_and_cache_nr() - Release reference on range of swap entries and
  *                            reclaim their cache if no more references remain.
@@ -1842,6 +1772,76 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	put_swap_device(si);
 }
 
+void swapcache_free_entries(swp_entry_t *entries, int n)
+{
+	int i;
+	struct swap_cluster_info *ci;
+	struct swap_info_struct *si = NULL;
+
+	if (n <= 0)
+		return;
+
+	for (i = 0; i < n; ++i) {
+		si = _swap_info_get(entries[i]);
+		if (si) {
+			ci = lock_cluster(si, swp_offset(entries[i]));
+			swap_entry_range_free(si, ci, entries[i], 1);
+			unlock_cluster(ci);
+		}
+	}
+}
+
+static bool folio_swapcache_freeable(struct folio *folio)
+{
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
+	if (!folio_test_swapcache(folio))
+		return false;
+	if (folio_test_writeback(folio))
+		return false;
+
+	/*
+	 * Once hibernation has begun to create its image of memory,
+	 * there's a danger that one of the calls to folio_free_swap()
+	 * - most probably a call from __try_to_reclaim_swap() while
+	 * hibernation is allocating its own swap pages for the image,
+	 * but conceivably even a call from memory reclaim - will free
+	 * the swap from a folio which has already been recorded in the
+	 * image as a clean swapcache folio, and then reuse its swap for
+	 * another page of the image.  On waking from hibernation, the
+	 * original folio might be freed under memory pressure, then
+	 * later read back in from swap, now with the wrong data.
+	 *
+	 * Hibernation suspends storage while it is writing the image
+	 * to disk so check that here.
+	 */
+	if (pm_suspended_storage())
+		return false;
+
+	return true;
+}
+
+/**
+ * folio_free_swap() - Free the swap space used for this folio.
+ * @folio: The folio to remove.
+ *
+ * If swap is getting full, or if there are no more mappings of this folio,
+ * then call folio_free_swap to free its swap space.
+ *
+ * Return: true if we were able to release the swap space.
+ */
+bool folio_free_swap(struct folio *folio)
+{
+	if (!folio_swapcache_freeable(folio))
+		return false;
+	if (folio_swapped(folio))
+		return false;
+
+	delete_from_swap_cache(folio);
+	folio_set_dirty(folio);
+	return true;
+}
+
 #ifdef CONFIG_HIBERNATION
 
 swp_entry_t get_swap_page_of_type(int type)
-- 
2.47.1


