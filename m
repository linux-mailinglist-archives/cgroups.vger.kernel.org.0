Return-Path: <cgroups+bounces-13781-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHqMHwMIiWnK1QQAu9opvQ
	(envelope-from <cgroups+bounces-13781-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 23:02:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D451510A5D6
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 23:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44016305BFCD
	for <lists+cgroups@lfdr.de>; Sun,  8 Feb 2026 21:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AAC361DB6;
	Sun,  8 Feb 2026 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrlVNVNv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC23590AC
	for <cgroups@vger.kernel.org>; Sun,  8 Feb 2026 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770587944; cv=none; b=BsORjD2ok2DcriHiNK86A0FwWZVmffYLmPWF6qd0ZVk+Ku7Copdty2xIzzmmE/+cap9yC/1SHgyB7RONogmjrZP+U15C5iC7fVkuD/b/RLClBmRLJcKphyL4WTgjVKB0xDYvlMzgtVopGi7HM7L72ooggUjZFFnNy0gKpPLJjHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770587944; c=relaxed/simple;
	bh=7ZpeUy08Tt7waGoLPUK+KDH/WTBw71RG9IGuJ1VLi3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oqnfo84RictalgeFKaaU2LNVCO5Hsk624B3OFtUKtnG75R9H4tVFnu6AvmuJVqpZ7Nf6uKVs6xSwAWbARIYxziTu1tL3RVYCctHaNKedC8+UbAY+bKaeJkYTV3ncFzuVdGYkXebq1xH+52B12u8mHQckf9NO0WOvZfl+7b8+ju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrlVNVNv; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d1866473b0so2190864a34.1
        for <cgroups@vger.kernel.org>; Sun, 08 Feb 2026 13:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587943; x=1771192743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OU6FG/1ImjDgjh8K5anzkahxddqp677D6NQQqJ3zZIs=;
        b=SrlVNVNvok1opZNrAhrAHaz6xf+vnLfamAj6lRJohkoNWpURkxr6lfNZ3xsZlsz/IY
         dpLfIBD2LLV7fBPUP/mbZlHhtXLYIuGDRqcvKPSydLyFnxYIFVnx37RvcJ1tGt+LiHIB
         Zjv8tbjWw4EblgfoVgSIXORvzkZEl59LLV5b7w7VUC1RN0isfchgXVGtGE7NAhrM6lL8
         vfngYznfGqU0g4uw2KGecfOlmTOj2sP0OzNCqxnRzbBu0yDuXXGSzJ5f7F9SZ/+EEnTV
         eVt4a5yRLWB1EjZrAPXR+Li+SZynt64+0m0QlALTwaF8TLgwCrpiqpWO0UMFTZn4f68k
         6r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587943; x=1771192743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OU6FG/1ImjDgjh8K5anzkahxddqp677D6NQQqJ3zZIs=;
        b=cOfCZ4WVjGtFrtP+4jMxZhMA0SWtMSQUFByWrjUyCWcJOJGYD65/MrheiIg4hjUJrw
         wMCrCfWvaWFvUJpHhbKDX6obTWF/+KLP6yLe5dzRAZbEItThWJPut84M3zPphCVuzkiC
         JXHEwUVbe+SyfCHQHt/SP/LQR/Up3MrUTJWLSHLHM1FL4YNFqZIsF4qcRZ771VEBb+LC
         80RG3827lp8Izm91VrsFAPqUXaLcZ/47X7250LiARkwWV8XfhrqYbKAPUVHPC6sChkh3
         oT3QFHaKZMlgi5ENeCgPFlHyu7+cJeLsp7nRHwbOru/H9FCuPB20LsGaq7SmMTbwMcTw
         qiag==
X-Forwarded-Encrypted: i=1; AJvYcCWIg5NkkN2UPSgfFpv25Hbdu+7NwdgCWl6aM6Dn8DyK8eLLE1OZbfoXUXPhssVEa+TJjNj1k05j@vger.kernel.org
X-Gm-Message-State: AOJu0YztmSPXRDK/qrtsCCbBqIGB3S2X/nTqoEVZTMntLLVKObSSeQnW
	ahDIqn0V4bHsIA9e8OivV89nhSQ5cn6HkORe/K77h1WFAHEbreyhXHx8
X-Gm-Gg: AZuq6aIP+EQ2IOv+gEiKIMkxZMF8zWTPoHK0t8lWj+TD7y/AZFHCqSGXGSREIpPETJ7
	ixE8B9RCzkiQ2gdsz9UyX/0pMc1hoXTbykVSfBnGzISJGq1BME0Ll4s9qZ3d3nlFhyKV4JI5U57
	XkjPVKpjBhYgw0EpLFrPkSrSPtblXUV4qvV0CK1oR3DwtCkGC7lcvuiV1eIZRpqSe0IxGqtFYQp
	1jrJtUmIrWJswf6SF7/bFbA09j14+8G7xTCZUMJLY/q1JqADvpZ0dCyPQOcf5+SVOPzJxfMn3eW
	c3EjCeR7tpNLJzojXSUsWjrJf/6tdsXrt7deps1E7xlsNqFn2gmUscp0RUy5MVHBeGil/XMpVf5
	R1r8CIYosV5TzUM9HG56cbDd6lNPPqgjsoN22sGZEsMmIBpbPAo53AwCv4FWZp78oEN2wWOf+L4
	Xq1J99IlqrQ25N+VoSpFCFYcPFrmdQQpJxJw==
X-Received: by 2002:a05:6830:6518:b0:7c7:8280:9207 with SMTP id 46e09a7af769-7d464689b0amr5463329a34.37.1770587942713;
        Sun, 08 Feb 2026 13:59:02 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d464785f68sm6051602a34.16.2026.02.08.13.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:59:02 -0800 (PST)
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
	shikemeng@huaweicloud.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	bhe@redhat.com,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com,
	riel@surriel.com,
	joshua.hahnjy@gmail.com,
	npache@redhat.com,
	gourry@gourry.net,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	rafael@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v3 10/20] swap: move swap cache to virtual swap descriptor
Date: Sun,  8 Feb 2026 13:58:23 -0800
Message-ID: <20260208215839.87595-11-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208215839.87595-1-nphamcs@gmail.com>
References: <20260208215839.87595-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13781-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D451510A5D6
X-Rspamd-Action: no action

Move the swap cache (and workingset shadow for anonymous pages) to the
virtual swap descriptor. This effectively range-partitions the swap
cache by virtual swap clusters (of PMD sized), eliminate swap cache lock
contention.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/huge_memory.c |   4 +-
 mm/migrate.c     |   6 +-
 mm/shmem.c       |   4 +-
 mm/swap.h        |  16 +--
 mm/swap_state.c  | 251 +--------------------------------
 mm/vmscan.c      |   6 +-
 mm/vswap.c       | 350 ++++++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 364 insertions(+), 273 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 21215ac870144..dcbd3821d6178 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3825,7 +3825,7 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
 				return -EINVAL;
 			}
 
-			swap_cache_lock();
+			swap_cache_lock(folio->swap);
 		}
 
 		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
@@ -3901,7 +3901,7 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
 			unlock_page_lruvec(lruvec);
 
 		if (folio_test_swapcache(folio))
-			swap_cache_unlock();
+			swap_cache_unlock(folio->swap);
 	} else {
 		split_queue_unlock(ds_queue);
 		return -EAGAIN;
diff --git a/mm/migrate.c b/mm/migrate.c
index 11d9b43dff5d8..e850b05a232de 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -600,13 +600,13 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	newzone = folio_zone(newfolio);
 
 	if (folio_test_swapcache(folio))
-		swap_cache_lock_irq();
+		swap_cache_lock_irq(folio->swap);
 	else
 		xas_lock_irq(&xas);
 
 	if (!folio_ref_freeze(folio, expected_count)) {
 		if (folio_test_swapcache(folio))
-			swap_cache_unlock_irq();
+			swap_cache_unlock_irq(folio->swap);
 		else
 			xas_unlock_irq(&xas);
 		return -EAGAIN;
@@ -652,7 +652,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 
 	/* Leave irq disabled to prevent preemption while updating stats */
 	if (folio_test_swapcache(folio))
-		swap_cache_unlock();
+		swap_cache_unlock(folio->swap);
 	else
 		xas_unlock(&xas);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 13f7469a04c8a..66cf8af6779ca 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2168,12 +2168,12 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	new->swap = entry;
 	folio_set_swapcache(new);
 
-	swap_cache_lock_irq();
+	swap_cache_lock_irq(entry);
 	__swap_cache_replace_folio(old, new);
 	mem_cgroup_replace_folio(old, new);
 	shmem_update_stats(new, nr_pages);
 	shmem_update_stats(old, -nr_pages);
-	swap_cache_unlock_irq();
+	swap_cache_unlock_irq(entry);
 
 	folio_add_lru(new);
 	*foliop = new;
diff --git a/mm/swap.h b/mm/swap.h
index 5eb53758bbd5d..57ed24a2d6356 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -205,10 +205,12 @@ void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug);
 
 /* linux/mm/swap_state.c */
 extern struct address_space swap_space __read_mostly;
-void swap_cache_lock_irq(void);
-void swap_cache_unlock_irq(void);
-void swap_cache_lock(void);
-void swap_cache_unlock(void);
+
+/* linux/mm/vswap.c */
+void swap_cache_lock_irq(swp_entry_t entry);
+void swap_cache_unlock_irq(swp_entry_t entry);
+void swap_cache_lock(swp_entry_t entry);
+void swap_cache_unlock(swp_entry_t entry);
 
 static inline struct address_space *swap_address_space(swp_entry_t entry)
 {
@@ -256,12 +258,11 @@ static inline bool folio_matches_swap_entry(const struct folio *folio,
  */
 struct folio *swap_cache_get_folio(swp_entry_t entry);
 void *swap_cache_get_shadow(swp_entry_t entry);
-int swap_cache_add_folio(struct folio *folio, swp_entry_t entry, gfp_t gfp, void **shadow);
+void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadow);
 void swap_cache_del_folio(struct folio *folio);
 /* Below helpers require the caller to lock the swap cache. */
 void __swap_cache_del_folio(struct folio *folio, swp_entry_t entry, void *shadow);
 void __swap_cache_replace_folio(struct folio *old, struct folio *new);
-void swap_cache_clear_shadow(swp_entry_t entry, int nr_ents);
 
 void show_swap_cache_info(void);
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
@@ -422,9 +423,8 @@ static inline void *swap_cache_get_shadow(swp_entry_t entry)
 	return NULL;
 }
 
-static inline int swap_cache_add_folio(struct folio *folio, swp_entry_t entry, gfp_t gfp, void **shadow)
+static inline void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadow)
 {
-	return 0;
 }
 
 static inline void swap_cache_del_folio(struct folio *folio)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index c5ceccd756699..00fa3e76a5c19 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -41,28 +41,6 @@ struct address_space swap_space __read_mostly = {
 	.a_ops = &swap_aops,
 };
 
-static DEFINE_XARRAY(swap_cache);
-
-void swap_cache_lock_irq(void)
-{
-	xa_lock_irq(&swap_cache);
-}
-
-void swap_cache_unlock_irq(void)
-{
-	xa_unlock_irq(&swap_cache);
-}
-
-void swap_cache_lock(void)
-{
-	xa_lock(&swap_cache);
-}
-
-void swap_cache_unlock(void)
-{
-	xa_unlock(&swap_cache);
-}
-
 static bool enable_vma_readahead __read_mostly = true;
 
 #define SWAP_RA_ORDER_CEILING	5
@@ -94,231 +72,6 @@ void show_swap_cache_info(void)
 	printk("Total swap = %lukB\n", K(total_swap_pages));
 }
 
-/**
- * swap_cache_get_folio - Looks up a folio in the swap cache.
- * @entry: swap entry used for the lookup.
- *
- * A found folio will be returned unlocked and with its refcount increased.
- *
- * Context: Caller must ensure @entry is valid and protect the swap device
- * with reference count or locks.
- * Return: Returns the found folio on success, NULL otherwise. The caller
- * must lock nd check if the folio still matches the swap entry before
- * use (e.g., folio_matches_swap_entry).
- */
-struct folio *swap_cache_get_folio(swp_entry_t entry)
-{
-	void *entry_val;
-	struct folio *folio;
-
-	for (;;) {
-		rcu_read_lock();
-		entry_val = xa_load(&swap_cache, entry.val);
-		if (!entry_val || xa_is_value(entry_val)) {
-			rcu_read_unlock();
-			return NULL;
-		}
-		folio = entry_val;
-		if (likely(folio_try_get(folio))) {
-			rcu_read_unlock();
-			return folio;
-		}
-		rcu_read_unlock();
-	}
-
-	return NULL;
-}
-
-/**
- * swap_cache_get_shadow - Looks up a shadow in the swap cache.
- * @entry: swap entry used for the lookup.
- *
- * Context: Caller must ensure @entry is valid and protect the swap device
- * with reference count or locks.
- * Return: Returns either NULL or an XA_VALUE (shadow).
- */
-void *swap_cache_get_shadow(swp_entry_t entry)
-{
-	void *entry_val;
-
-	rcu_read_lock();
-	entry_val = xa_load(&swap_cache, entry.val);
-	rcu_read_unlock();
-
-	if (xa_is_value(entry_val))
-		return entry_val;
-	return NULL;
-}
-
-/**
- * swap_cache_add_folio - Add a folio into the swap cache.
- * @folio: The folio to be added.
- * @entry: The swap entry corresponding to the folio.
- * @gfp: gfp_mask for XArray node allocation.
- * @shadowp: If a shadow is found, return the shadow.
- *
- * Context: Caller must ensure @entry is valid and protect the swap device
- * with reference count or locks.
- * The caller also needs to update the corresponding swap_map slots with
- * SWAP_HAS_CACHE bit to avoid race or conflict.
- *
- * Return: 0 on success, negative error code on failure.
- */
-int swap_cache_add_folio(struct folio *folio, swp_entry_t entry, gfp_t gfp, void **shadowp)
-{
-	XA_STATE_ORDER(xas, &swap_cache, entry.val, folio_order(folio));
-	unsigned long nr_pages = folio_nr_pages(folio);
-	unsigned long i;
-	void *old;
-
-	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
-	VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
-	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapbacked(folio), folio);
-
-	folio_ref_add(folio, nr_pages);
-	folio_set_swapcache(folio);
-	folio->swap = entry;
-
-	do {
-		xas_lock_irq(&xas);
-		xas_create_range(&xas);
-		if (xas_error(&xas))
-			goto unlock;
-		for (i = 0; i < nr_pages; i++) {
-			VM_BUG_ON_FOLIO(xas.xa_index != entry.val + i, folio);
-			old = xas_load(&xas);
-			if (old && !xa_is_value(old)) {
-				VM_WARN_ON_ONCE_FOLIO(1, folio);
-				xas_set_err(&xas, -EEXIST);
-				goto unlock;
-			}
-			if (shadowp && xa_is_value(old) && !*shadowp)
-				*shadowp = old;
-			xas_store(&xas, folio);
-			xas_next(&xas);
-		}
-		node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
-		lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
-unlock:
-		xas_unlock_irq(&xas);
-	} while (xas_nomem(&xas, gfp));
-
-	if (!xas_error(&xas))
-		return 0;
-
-	folio_clear_swapcache(folio);
-	folio_ref_sub(folio, nr_pages);
-	return xas_error(&xas);
-}
-
-/**
- * __swap_cache_del_folio - Removes a folio from the swap cache.
- * @folio: The folio.
- * @entry: The first swap entry that the folio corresponds to.
- * @shadow: shadow value to be filled in the swap cache.
- *
- * Removes a folio from the swap cache and fills a shadow in place.
- * This won't put the folio's refcount. The caller has to do that.
- *
- * Context: Caller must ensure the folio is locked and in the swap cache
- * using the index of @entry, and lock the swap cache xarray.
- */
-void __swap_cache_del_folio(struct folio *folio, swp_entry_t entry, void *shadow)
-{
-	long nr_pages = folio_nr_pages(folio);
-	XA_STATE(xas, &swap_cache, entry.val);
-	int i;
-
-	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
-	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
-	VM_WARN_ON_ONCE_FOLIO(folio_test_writeback(folio), folio);
-
-	for (i = 0; i < nr_pages; i++) {
-		void *old = xas_store(&xas, shadow);
-		VM_WARN_ON_FOLIO(old != folio, folio);
-		xas_next(&xas);
-	}
-
-	folio->swap.val = 0;
-	folio_clear_swapcache(folio);
-	node_stat_mod_folio(folio, NR_FILE_PAGES, -nr_pages);
-	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr_pages);
-}
-
-/**
- * swap_cache_del_folio - Removes a folio from the swap cache.
- * @folio: The folio.
- *
- * Same as __swap_cache_del_folio, but handles lock and refcount. The
- * caller must ensure the folio is either clean or has a swap count
- * equal to zero, or it may cause data loss.
- *
- * Context: Caller must ensure the folio is locked and in the swap cache.
- */
-void swap_cache_del_folio(struct folio *folio)
-{
-	swp_entry_t entry = folio->swap;
-
-	xa_lock_irq(&swap_cache);
-	__swap_cache_del_folio(folio, entry, NULL);
-	xa_unlock_irq(&swap_cache);
-
-	put_swap_folio(folio, entry);
-	folio_ref_sub(folio, folio_nr_pages(folio));
-}
-
-/**
- * __swap_cache_replace_folio - Replace a folio in the swap cache.
- * @old: The old folio to be replaced.
- * @new: The new folio.
- *
- * Replace an existing folio in the swap cache with a new folio. The
- * caller is responsible for setting up the new folio's flag and swap
- * entries. Replacement will take the new folio's swap entry value as
- * the starting offset to override all slots covered by the new folio.
- *
- * Context: Caller must ensure both folios are locked, and lock the
- * swap cache xarray.
- */
-void __swap_cache_replace_folio(struct folio *old, struct folio *new)
-{
-	swp_entry_t entry = new->swap;
-	unsigned long nr_pages = folio_nr_pages(new);
-	XA_STATE(xas, &swap_cache, entry.val);
-	int i;
-
-	VM_WARN_ON_ONCE(!folio_test_swapcache(old) || !folio_test_swapcache(new));
-	VM_WARN_ON_ONCE(!folio_test_locked(old) || !folio_test_locked(new));
-	VM_WARN_ON_ONCE(!entry.val);
-
-	for (i = 0; i < nr_pages; i++) {
-		void *old_entry = xas_store(&xas, new);
-		WARN_ON_ONCE(!old_entry || xa_is_value(old_entry) || old_entry != old);
-		xas_next(&xas);
-	}
-}
-
-/**
- * swap_cache_clear_shadow - Clears a set of shadows in the swap cache.
- * @entry: The starting index entry.
- * @nr_ents: How many slots need to be cleared.
- *
- * Context: Caller must ensure the range is valid and all in one single cluster,
- * not occupied by any folio.
- */
-void swap_cache_clear_shadow(swp_entry_t entry, int nr_ents)
-{
-	XA_STATE(xas, &swap_cache, entry.val);
-	int i;
-
-	xas_lock(&xas);
-	for (i = 0; i < nr_ents; i++) {
-		xas_store(&xas, NULL);
-		xas_next(&xas);
-	}
-	xas_unlock(&xas);
-}
-
 /*
  * If we are the only user, then try to free up the swap cache.
  *
@@ -497,9 +250,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	if (mem_cgroup_swapin_charge_folio(new_folio, NULL, gfp_mask, entry))
 		goto fail_unlock;
 
-	/* May fail (-ENOMEM) if XArray node allocation failed. */
-	if (swap_cache_add_folio(new_folio, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
-		goto fail_unlock;
+	swap_cache_add_folio(new_folio, entry, &shadow);
 
 	memcg1_swapin(entry, 1);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 558ff7f413786..c9ec1a1458b4e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -712,7 +712,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 	BUG_ON(mapping != folio_mapping(folio));
 
 	if (folio_test_swapcache(folio)) {
-		swap_cache_lock_irq();
+		swap_cache_lock_irq(folio->swap);
 	} else {
 		spin_lock(&mapping->host->i_lock);
 		xa_lock_irq(&mapping->i_pages);
@@ -759,7 +759,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 			shadow = workingset_eviction(folio, target_memcg);
 		__swap_cache_del_folio(folio, swap, shadow);
 		memcg1_swapout(folio, swap);
-		swap_cache_unlock_irq();
+		swap_cache_unlock_irq(swap);
 		put_swap_folio(folio, swap);
 	} else {
 		void (*free_folio)(struct folio *);
@@ -798,7 +798,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 
 cannot_free:
 	if (folio_test_swapcache(folio)) {
-		swap_cache_unlock_irq();
+		swap_cache_unlock_irq(folio->swap);
 	} else {
 		xa_unlock_irq(&mapping->i_pages);
 		spin_unlock(&mapping->host->i_lock);
diff --git a/mm/vswap.c b/mm/vswap.c
index 9aa95558f320a..d44199dc059a3 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -37,9 +37,15 @@
  * Swap descriptor - metadata of a swapped out page.
  *
  * @slot: The handle to the physical swap slot backing this page.
+ * @swap_cache: The folio in swap cache.
+ * @shadow: The shadow entry.
  */
 struct swp_desc {
 	swp_slot_t slot;
+	union {
+		struct folio *swap_cache;
+		void *shadow;
+	};
 };
 
 #define VSWAP_CLUSTER_SHIFT HPAGE_PMD_ORDER
@@ -170,6 +176,24 @@ static int vswap_debug_fs_init(void)
 }
 #endif
 
+/*
+ * Lockless version of vswap_iter - assumes caller holds cluster lock.
+ * Used when iterating within the same cluster with the lock already held.
+ */
+static struct swp_desc *__vswap_iter(struct vswap_cluster *cluster, unsigned long i)
+{
+	unsigned long slot_index;
+
+	lockdep_assert_held(&cluster->lock);
+	VM_WARN_ON(cluster->id != VSWAP_VAL_CLUSTER_IDX(i));
+
+	slot_index = VSWAP_IDX_WITHIN_CLUSTER_VAL(i);
+	if (test_bit(slot_index, cluster->bitmap))
+		return &cluster->descriptors[slot_index];
+
+	return NULL;
+}
+
 static struct swp_desc *vswap_iter(struct vswap_cluster **clusterp, unsigned long i)
 {
 	unsigned long cluster_id = VSWAP_VAL_CLUSTER_IDX(i);
@@ -448,7 +472,6 @@ void vswap_free(swp_entry_t entry, struct swap_cluster_info *ci)
 	if (!entry.val)
 		return;
 
-	swap_cache_clear_shadow(entry, 1);
 	zswap_invalidate(entry);
 	mem_cgroup_uncharge_swap(entry, 1);
 
@@ -460,6 +483,10 @@ void vswap_free(swp_entry_t entry, struct swap_cluster_info *ci)
 		return;
 	}
 
+	/* Clear shadow if present */
+	if (xa_is_value(desc->shadow))
+		desc->shadow = NULL;
+
 	if (desc->slot.val)
 		vswap_rmap_set(ci, desc->slot, 0, 1);
 
@@ -480,7 +507,7 @@ int folio_alloc_swap(struct folio *folio)
 	struct vswap_cluster *cluster = NULL;
 	struct swap_info_struct *si;
 	struct swap_cluster_info *ci;
-	int i, err, nr = folio_nr_pages(folio), order = folio_order(folio);
+	int i, nr = folio_nr_pages(folio), order = folio_order(folio);
 	struct swp_desc *desc;
 	swp_entry_t entry;
 	swp_slot_t slot;
@@ -533,9 +560,7 @@ int folio_alloc_swap(struct folio *folio)
 	if (mem_cgroup_try_charge_swap(folio, entry))
 		goto out_free;
 
-	err = swap_cache_add_folio(folio, entry, __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN, NULL);
-	if (err)
-		goto out_free;
+	swap_cache_add_folio(folio, entry, NULL);
 
 	return 0;
 
@@ -668,6 +693,321 @@ static int vswap_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
+/**
+ * swap_cache_lock - lock the swap cache for a swap entry
+ * @entry: the swap entry
+ *
+ * Locks the vswap cluster spinlock for the given swap entry.
+ */
+void swap_cache_lock(swp_entry_t entry)
+{
+	struct vswap_cluster *cluster;
+	unsigned long cluster_id = VSWAP_CLUSTER_IDX(entry);
+
+	rcu_read_lock();
+	cluster = xa_load(&vswap_cluster_map, cluster_id);
+	VM_WARN_ON(!cluster);
+	spin_lock(&cluster->lock);
+	rcu_read_unlock();
+}
+
+/**
+ * swap_cache_unlock - unlock the swap cache for a swap entry
+ * @entry: the swap entry
+ *
+ * Unlocks the vswap cluster spinlock for the given swap entry.
+ */
+void swap_cache_unlock(swp_entry_t entry)
+{
+	struct vswap_cluster *cluster;
+	unsigned long cluster_id = VSWAP_CLUSTER_IDX(entry);
+
+	rcu_read_lock();
+	cluster = xa_load(&vswap_cluster_map, cluster_id);
+	VM_WARN_ON(!cluster);
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+}
+
+/**
+ * swap_cache_lock_irq - lock the swap cache with interrupts disabled
+ * @entry: the swap entry
+ *
+ * Locks the vswap cluster spinlock and disables interrupts for the given swap entry.
+ */
+void swap_cache_lock_irq(swp_entry_t entry)
+{
+	struct vswap_cluster *cluster;
+	unsigned long cluster_id = VSWAP_CLUSTER_IDX(entry);
+
+	rcu_read_lock();
+	cluster = xa_load(&vswap_cluster_map, cluster_id);
+	VM_WARN_ON(!cluster);
+	spin_lock_irq(&cluster->lock);
+	rcu_read_unlock();
+}
+
+/**
+ * swap_cache_unlock_irq - unlock the swap cache with interrupts enabled
+ * @entry: the swap entry
+ *
+ * Unlocks the vswap cluster spinlock and enables interrupts for the given swap entry.
+ */
+void swap_cache_unlock_irq(swp_entry_t entry)
+{
+	struct vswap_cluster *cluster;
+	unsigned long cluster_id = VSWAP_CLUSTER_IDX(entry);
+
+	rcu_read_lock();
+	cluster = xa_load(&vswap_cluster_map, cluster_id);
+	VM_WARN_ON(!cluster);
+	spin_unlock_irq(&cluster->lock);
+	rcu_read_unlock();
+}
+
+/**
+ * swap_cache_get_folio - Looks up a folio in the swap cache.
+ * @entry: swap entry used for the lookup.
+ *
+ * A found folio will be returned unlocked and with its refcount increased.
+ *
+ * Context: Caller must ensure @entry is valid and protect the cluster with
+ * reference count or locks.
+ *
+ * Return: Returns the found folio on success, NULL otherwise. The caller
+ * must lock and check if the folio still matches the swap entry before
+ * use (e.g., folio_matches_swap_entry).
+ */
+struct folio *swap_cache_get_folio(swp_entry_t entry)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	struct folio *folio;
+
+	for (;;) {
+		rcu_read_lock();
+		desc = vswap_iter(&cluster, entry.val);
+		if (!desc) {
+			rcu_read_unlock();
+			return NULL;
+		}
+
+		/* Check if this is a shadow value (xa_is_value equivalent) */
+		if (xa_is_value(desc->shadow)) {
+			spin_unlock(&cluster->lock);
+			rcu_read_unlock();
+			return NULL;
+		}
+
+		folio = desc->swap_cache;
+		if (!folio) {
+			spin_unlock(&cluster->lock);
+			rcu_read_unlock();
+			return NULL;
+		}
+
+		if (likely(folio_try_get(folio))) {
+			spin_unlock(&cluster->lock);
+			rcu_read_unlock();
+			return folio;
+		}
+		spin_unlock(&cluster->lock);
+		rcu_read_unlock();
+	}
+
+	return NULL;
+}
+
+/**
+ * swap_cache_get_shadow - Looks up a shadow in the swap cache.
+ * @entry: swap entry used for the lookup.
+ *
+ * Context: Caller must ensure @entry is valid and protect the cluster with
+ * reference count or locks.
+ *
+ * Return: Returns either NULL or an XA_VALUE (shadow).
+ */
+void *swap_cache_get_shadow(swp_entry_t entry)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	void *shadow;
+
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	if (!desc) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	shadow = desc->shadow;
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+
+	if (xa_is_value(shadow))
+		return shadow;
+	return NULL;
+}
+
+/**
+ * swap_cache_add_folio - Add a folio into the swap cache.
+ * @folio: The folio to be added.
+ * @entry: The swap entry corresponding to the folio.
+ * @shadowp: If a shadow is found, return the shadow.
+ *
+ * Context: Caller must ensure @entry is valid and protect the cluster with
+ * reference count or locks.
+ *
+ * The caller also needs to update the corresponding swap_map slots with
+ * SWAP_HAS_CACHE bit to avoid race or conflict.
+ */
+void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadowp)
+{
+	struct vswap_cluster *cluster;
+	unsigned long nr_pages = folio_nr_pages(folio);
+	unsigned long cluster_id = VSWAP_CLUSTER_IDX(entry);
+	unsigned long i;
+	struct swp_desc *desc;
+	void *old;
+
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapbacked(folio), folio);
+
+	folio_ref_add(folio, nr_pages);
+	folio_set_swapcache(folio);
+	folio->swap = entry;
+
+	rcu_read_lock();
+	cluster = xa_load(&vswap_cluster_map, cluster_id);
+	VM_WARN_ON(!cluster);
+	spin_lock_irq(&cluster->lock);
+
+	for (i = 0; i < nr_pages; i++) {
+		desc = __vswap_iter(cluster, entry.val + i);
+		VM_WARN_ON(!desc);
+		old = desc->shadow;
+
+		/* Warn if slot is already occupied by a folio */
+		VM_WARN_ON_FOLIO(old && !xa_is_value(old), folio);
+
+		/* Save shadow if found and not yet saved */
+		if (shadowp && xa_is_value(old) && !*shadowp)
+			*shadowp = old;
+
+		desc->swap_cache = folio;
+	}
+
+	spin_unlock_irq(&cluster->lock);
+	rcu_read_unlock();
+
+	node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
+	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
+}
+
+/**
+ * __swap_cache_del_folio - Removes a folio from the swap cache.
+ * @folio: The folio.
+ * @entry: The first swap entry that the folio corresponds to.
+ * @shadow: shadow value to be filled in the swap cache.
+ *
+ * Removes a folio from the swap cache and fills a shadow in place.
+ * This won't put the folio's refcount. The caller has to do that.
+ *
+ * Context: Caller must ensure the folio is locked and in the swap cache
+ * using the index of @entry, and lock the swap cache.
+ */
+void __swap_cache_del_folio(struct folio *folio, swp_entry_t entry, void *shadow)
+{
+	long nr_pages = folio_nr_pages(folio);
+	struct vswap_cluster *cluster;
+	struct swp_desc *desc;
+	unsigned long cluster_id = VSWAP_CLUSTER_IDX(entry);
+	int i;
+
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_test_writeback(folio), folio);
+
+	rcu_read_lock();
+	cluster = xa_load(&vswap_cluster_map, cluster_id);
+	VM_WARN_ON(!cluster);
+
+	for (i = 0; i < nr_pages; i++) {
+		desc = __vswap_iter(cluster, entry.val + i);
+		VM_WARN_ON_FOLIO(!desc || desc->swap_cache != folio, folio);
+		desc->shadow = shadow;
+	}
+	rcu_read_unlock();
+
+	folio->swap.val = 0;
+	folio_clear_swapcache(folio);
+	node_stat_mod_folio(folio, NR_FILE_PAGES, -nr_pages);
+	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr_pages);
+}
+
+/**
+ * swap_cache_del_folio - Removes a folio from the swap cache.
+ * @folio: The folio.
+ *
+ * Same as __swap_cache_del_folio, but handles lock and refcount. The
+ * caller must ensure the folio is either clean or has a swap count
+ * equal to zero, or it may cause data loss.
+ *
+ * Context: Caller must ensure the folio is locked and in the swap cache.
+ */
+void swap_cache_del_folio(struct folio *folio)
+{
+	swp_entry_t entry = folio->swap;
+
+	swap_cache_lock_irq(entry);
+	__swap_cache_del_folio(folio, entry, NULL);
+	swap_cache_unlock_irq(entry);
+
+	put_swap_folio(folio, entry);
+	folio_ref_sub(folio, folio_nr_pages(folio));
+}
+
+/**
+ * __swap_cache_replace_folio - Replace a folio in the swap cache.
+ * @old: The old folio to be replaced.
+ * @new: The new folio.
+ *
+ * Replace an existing folio in the swap cache with a new folio. The
+ * caller is responsible for setting up the new folio's flag and swap
+ * entries. Replacement will take the new folio's swap entry value as
+ * the starting offset to override all slots covered by the new folio.
+ *
+ * Context: Caller must ensure both folios are locked, and lock the
+ * swap cache.
+ */
+void __swap_cache_replace_folio(struct folio *old, struct folio *new)
+{
+	swp_entry_t entry = new->swap;
+	unsigned long nr_pages = folio_nr_pages(new);
+	struct vswap_cluster *cluster;
+	struct swp_desc *desc;
+	unsigned long cluster_id = VSWAP_CLUSTER_IDX(entry);
+	void *old_entry;
+	int i;
+
+	VM_WARN_ON_ONCE(!folio_test_swapcache(old) || !folio_test_swapcache(new));
+	VM_WARN_ON_ONCE(!folio_test_locked(old) || !folio_test_locked(new));
+	VM_WARN_ON_ONCE(!entry.val);
+
+	rcu_read_lock();
+	cluster = xa_load(&vswap_cluster_map, cluster_id);
+	VM_WARN_ON(!cluster);
+
+	for (i = 0; i < nr_pages; i++) {
+		desc = __vswap_iter(cluster, entry.val + i);
+		VM_WARN_ON(!desc);
+		old_entry = desc->swap_cache;
+		VM_WARN_ON(!old_entry || xa_is_value(old_entry) || old_entry != old);
+		desc->swap_cache = new;
+	}
+	rcu_read_unlock();
+}
 
 int vswap_init(void)
 {
-- 
2.47.3


