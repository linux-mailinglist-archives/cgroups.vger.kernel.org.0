Return-Path: <cgroups+bounces-16908-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZQcZFSVgLGp9QAQAu9opvQ
	(envelope-from <cgroups+bounces-16908-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 21:38:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D893667C158
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 21:38:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=G9b3EtT1;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16908-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16908-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44A0C300E036
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 19:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630AD375AD0;
	Fri, 12 Jun 2026 19:37:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6137F8CB
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 19:37:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293070; cv=none; b=BVtCPJk1X7XVv/ezkRNlXlQQFZhGfL6N23LkJus8pavbt8jGujJ6MojWO2bIIHcLO92ZO8mpvp1qqXkECZC/6tsKOwZGnpVfsp0zldSTOOPHUD7TqiKZ8X+7fU8cvxJmjZP4ajmKWxTqHOSpftdAeYx2gJ4s2oXeItn7oHgTKBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293070; c=relaxed/simple;
	bh=7VxFesFQgnUCoVzwLh9/vVk2tlz+Sy0Z2hYZtaMFbP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVz9esgam/gGDBlGNiotAGgnqh5PvGEXSvgGGbW+Kui7ed8jwMbQVx6uvp2WfSzqXqYoHWMiA8MvgsHxr/FAkV9Sp7srtppiJR4sKSLCrqHoBVjmIsCbspOue7b3KfJ7WfRkA/7t2Rf4hGHFUOW0ZKNUvQ2C4U+Sg0e2qIzVlos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9b3EtT1; arc=none smtp.client-ip=209.85.161.44
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69d7e72b052so873448eaf.2
        for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 12:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781293066; x=1781897866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXt9o2FEKArq1iq/mcj6A2cJfg4XXVHzMg7FiOp+2kM=;
        b=G9b3EtT1mPcrgAlm4cQyeZEPy5uTkLRsvkzHLKupIMxkUakoY/Qg1pQjsJw1gjbHNG
         6uBCs1alj8BWjcK3Avwi5fsPmV5kA1t9uWGyu3iMmCo+1iAzru5rGEs9CohiUOMxJcq3
         3vpSw/rZyrI32+ySMvqAol93DL7vx9W8w1LXMfyp91A1gt0QQQ8lYGy4hr1By6eSP5Yz
         6uoFHIraMJ4cJ44EcYFJzB4b3KMfuRfo6jE64w1xcHI3ZH1xdjDnCk0taIGiiek1qnWr
         P4ujhOsV/ohiuDcvT7xaavq2ucVv9ZNtXBgS05TGvq/ATv38Nd4Uh0wxpdhqeRadh1GP
         xFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781293066; x=1781897866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CXt9o2FEKArq1iq/mcj6A2cJfg4XXVHzMg7FiOp+2kM=;
        b=I6ileWPLoS6wwwBLMV2K78ayDXPJk9MjHKt3tRYS9rLNkkWSOoG/GXkEXRfJy0357A
         6zuKymyG6WDg3jFs2piX3G4MorQv6Dszh/OKTHyBCRrczGQ6DF8jaRukk9jdNblSl1AB
         6ItfRJd3pqDsib3wVNOuXO0yh6MeHDyWXkUNbcQZlPmWw2shymNeDCYWtmMlIOpxdbQJ
         BvkOwUcDI4jrG45YlRhQbT3As4q8Ep5CkqyBrBt0wCKGN7oB1SBJ0ZTQWPxSXzkonfI3
         1LQipVJ2CEMqxEDIlCViVWdRqY4F1rVn/TVmFK4iDyhCm3cp3MOg0ys3K840YKyPitH2
         nPag==
X-Forwarded-Encrypted: i=1; AFNElJ+lRy0h6q+P64GWQISn7u14ICwDfYRvR8MG0LVT4L89QMZGl+ZAbPdrAUoWE+ffu0qRrBUcUyZt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fcdwkzfdxEg9VazpCXzwTwQ1tuG4vVJwkix1tGqBwTsR5S2r
	eOWMCar/3qYVoTgsEy2UUAvn4eeYjq9/ChH+XdVqxqB4uZZuDDcoIhAK
X-Gm-Gg: Acq92OEmo2cL/pPuF8S3YJiXoDPsQxjZqf8sZuU7yQkGpbQBUs4DPy4k49Qld4tZObF
	tWXm5/xv0ds2EE2cz8jYLNxSvlJIBQVt3r6SlZkb9Ld87EIDgLIRiSylGlu0KEVOSMUUOn9ErSG
	rftrB1uSV3ZjDfd11QU6ROwOJH85bIVxsQZNB0V5rUxviJ6Gxdl6JMzQxgUkV/d2XluotvccW2q
	h5kbnZJnXrkeUd+7AzEZHS9I2r6D7JgbVtUKWV2/Dn7pC4mtPCvWAY+cDyvlDXdNKuzFBi+aZE7
	EkNZRmqQSeLQJgdu6qzPH5yW+HD8Rs9tuVFqt4f2OBibr+cm1uy2q+etgb9kkT66exAsKyHrij+
	SSGcfxioxb2c8nZlRCSK19y6kWcI85n8TQq5P3xwWwo9G7OArAnPPqxZkTcyfVqZkwilfq7Z4Te
	w1k0WxkcfuIh2GjT698jwYIApJDAyvmSzrnICWZlTgLIlu
X-Received: by 2002:a05:6820:1c9c:b0:69d:dda8:2ee5 with SMTP id 006d021491bc7-69edc5e1b26mr2263812eaf.11.1781293065894;
        Fri, 12 Jun 2026 12:37:45 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69ed839976bsm2242593eaf.5.2026.06.12.12.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:37:45 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	yosry@kernel.org,
	david@kernel.org,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	chengming.zhou@linux.dev,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	qi.zheng@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	riel@surriel.com,
	gourry@gourry.net,
	haowenchao22@gmail.com,
	kernel-team@meta.com,
	nphamcs@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v2 2/7] mm, swap: support zswap and zeroswap as vswap backends
Date: Fri, 12 Jun 2026 12:37:33 -0700
Message-ID: <20260612193738.2183968-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612193738.2183968-1-nphamcs@gmail.com>
References: <20260612193738.2183968-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,lge.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16908-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:yosry@kernel.org,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:nphamcs@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D893667C158

Build the virtual swap layer on top of the swap-table infrastructure.
Virtual swap entries decouple PTE swap entries from physical backing,
allowing pages to be compressed by zswap (or detected as zero-filled)
without pre-allocating a physical swap slot.

This patch only supports zswap and zero-page backends. If zswap_store
fails, the page stays dirty in the swap cache (AOP_WRITEPAGE_ACTIVATE)
- physical disk backing fallback comes in the next patch. Zswap
writeback of vswap-backed entries is also disabled - the shrinker
skips when no physical swap pages are available.

Suggested-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/zswap.h |   3 +
 mm/memory.c           |  22 ++-
 mm/page_io.c          |  39 ++++--
 mm/swap.h             |   4 +-
 mm/swap_state.c       |  17 +++
 mm/swapfile.c         | 262 ++++++++++++++++++++++++++++++-----
 mm/vmscan.c           |  14 +-
 mm/vswap.h            | 307 +++++++++++++++++++++++++++++++++++++++++-
 mm/zswap.c            |  93 +++++++------
 9 files changed, 664 insertions(+), 97 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 30c193a1207e..4b4f211f3301 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -6,6 +6,7 @@
 #include <linux/mm_types.h>
 
 struct lruvec;
+struct zswap_entry;
 
 extern atomic_long_t zswap_stored_pages;
 
@@ -28,6 +29,7 @@ unsigned long zswap_total_pages(void);
 bool zswap_store(struct folio *folio);
 int zswap_load(struct folio *folio);
 void zswap_invalidate(swp_entry_t swp);
+void zswap_entry_free(struct zswap_entry *entry);
 int zswap_swapon(int type, unsigned long nr_pages);
 void zswap_swapoff(int type);
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
@@ -50,6 +52,7 @@ static inline int zswap_load(struct folio *folio)
 }
 
 static inline void zswap_invalidate(swp_entry_t swp) {}
+static inline void zswap_entry_free(struct zswap_entry *entry) {}
 static inline int zswap_swapon(int type, unsigned long nr_pages)
 {
 	return 0;
diff --git a/mm/memory.c b/mm/memory.c
index 56be920c56d7..9d6f78d04fd2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -89,6 +89,7 @@
 #include "pgalloc-track.h"
 #include "internal.h"
 #include "swap.h"
+#include "vswap.h"
 
 #if defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS) && !defined(CONFIG_COMPILE_TEST)
 #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
@@ -4525,6 +4526,12 @@ static inline bool should_try_to_free_swap(struct swap_info_struct *si,
 	 */
 	if (data_race(si->flags & SWP_SYNCHRONOUS_IO))
 		return true;
+	/*
+	 * Non-swapfile backends cannot be reused for future swapouts.
+	 * Free the swap slot unless backed by contiguous physical swap.
+	 */
+	if (is_vswap_entry(folio->swap))
+		return true;
 	if (mem_cgroup_swap_full(folio) || (vma->vm_flags & VM_LOCKED) ||
 	    folio_test_mlocked(folio))
 		return true;
@@ -4675,15 +4682,20 @@ static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
 	if (unlikely(userfaultfd_armed(vma)))
 		return 0;
 
+	entry = softleaf_from_pte(vmf->orig_pte);
+
 	/*
-	 * A large swapped out folio could be partially or fully in zswap. We
-	 * lack handling for such cases, so fallback to swapping in order-0
-	 * folio.
+	 * A large swapped out folio could be partially or fully in zswap.
+	 * For vswap entries the THP-amenability of the backing is checked
+	 * later under the cluster lock in __swap_cache_add_check, which
+	 * rejects ZSWAP and mixed batches via -EBUSY and triggers
+	 * order-fallback. For non-vswap entries we still need the
+	 * zswap_never_enabled() bail - zswap_load rejects large folios
+	 * with -EINVAL, which would SIGBUS the fault.
 	 */
-	if (!zswap_never_enabled())
+	if (!is_vswap_entry(entry) && !zswap_never_enabled())
 		return 0;
 
-	entry = softleaf_from_pte(vmf->orig_pte);
 	/*
 	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
 	 * and suitable for swapping THP.
diff --git a/mm/page_io.c b/mm/page_io.c
index 8126be6e4cfb..784531060746 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -27,6 +27,7 @@
 #include <linux/zswap.h>
 #include "swap.h"
 #include "swap_table.h"
+#include "vswap.h"
 
 static void __end_swap_bio_write(struct bio *bio)
 {
@@ -207,14 +208,19 @@ static void swap_zeromap_folio_set(struct folio *folio)
 	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
 	int nr_pages = folio_nr_pages(folio);
 	struct swap_cluster_info *ci;
+	unsigned int voff, i;
 	swp_entry_t entry;
-	unsigned int i;
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 
 	ci = swap_cluster_get_and_lock(folio);
-	for (i = 0; i < folio_nr_pages(folio); i++) {
+	if (is_vswap_entry(folio->swap)) {
+		/* Free any prior backing (e.g. ZSWAP entry from earlier swapout) */
+		voff = swp_cluster_offset(folio->swap);
+		__vswap_release_backing(ci, voff, nr_pages);
+	}
+	for (i = 0; i < nr_pages; i++) {
 		entry = page_swap_entry(folio_page(folio, i));
 		__swap_table_set_zero(ci, swp_cluster_offset(entry));
 	}
@@ -282,6 +288,9 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 	 */
 	swap_zeromap_folio_clear(folio);
 
+	if (is_vswap_entry(folio->swap))
+		folio_release_vswap_backing(folio);
+
 	if (zswap_store(folio)) {
 		count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
 		goto out_unlock;
@@ -295,6 +304,11 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 	}
 	rcu_read_unlock();
 
+	if (is_vswap_entry(folio->swap)) {
+		folio_mark_dirty(folio);
+		return AOP_WRITEPAGE_ACTIVATE;
+	}
+
 	return __swap_writepage(folio, swap_plug);
 out_unlock:
 	folio_unlock(folio);
@@ -537,23 +551,26 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 static int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 			      bool *is_zerop)
 {
-	int i;
-	bool is_zero;
-	unsigned int ci_start = swp_cluster_offset(entry);
 	struct swap_cluster_info *ci = __swap_entry_to_cluster(entry);
+	unsigned int ci_start = swp_cluster_offset(entry), ci_off, ci_end;
+	bool is_zero;
 
 	VM_WARN_ON_ONCE(ci_start + max_nr > SWAPFILE_CLUSTER);
 
+	ci_off = ci_start;
+	ci_end = ci_off + max_nr;
+
 	rcu_read_lock();
-	is_zero = __swap_table_test_zero(ci, ci_start);
-	for (i = 1; i < max_nr; i++)
-		if (is_zero != __swap_table_test_zero(ci, ci_start + i))
-			break;
-	rcu_read_unlock();
+	is_zero = __swap_table_test_zero(ci, ci_off);
 	if (is_zerop)
 		*is_zerop = is_zero;
+	while (++ci_off < ci_end) {
+		if (is_zero != __swap_table_test_zero(ci, ci_off))
+			break;
+	}
+	rcu_read_unlock();
 
-	return i;
+	return ci_off - ci_start;
 }
 
 static bool swap_read_folio_zeromap(struct folio *folio)
diff --git a/mm/swap.h b/mm/swap.h
index 97493551edbd..2f17c2003e43 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -69,7 +69,9 @@ struct swap_cluster_info_dynamic {
 	struct swap_cluster_info ci;	/* Underlying cluster info */
 	unsigned int index;		/* for cluster_index() */
 	struct rcu_head rcu;		/* For kfree_rcu deferred free */
-	/* Backend pointers (virtual_table) added in a later patch. */
+#ifdef CONFIG_VSWAP
+	atomic_long_t *virtual_table;	/* Backing pointers for vswap slots */
+#endif
 };
 
 /* All on-list cluster must have a non-zero flag. */
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 341ca8826507..f47758ac46b0 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -25,6 +25,7 @@
 #include "internal.h"
 #include "swap_table.h"
 #include "swap.h"
+#include "vswap.h"
 
 /*
  * swapper_space is a fiction, retained to simplify the path through
@@ -167,6 +168,9 @@ static int __swap_cache_add_check(struct swap_cluster_info *ci,
 	unsigned int ci_off, ci_end;
 	unsigned long old_tb;
 	bool is_zero;
+	struct swap_cluster_info_dynamic *ci_dyn;
+	enum vswap_backing_type type;
+	int ret;
 
 	lockdep_assert_held(&ci->lock);
 
@@ -191,6 +195,19 @@ static int __swap_cache_add_check(struct swap_cluster_info *ci,
 	if (nr == 1)
 		return 0;
 
+	/*
+	 * For a vswap entry batch, reject if the backing is not THP-amenable
+	 * (e.g. uniformly ZSWAP, or mixed). The order-fallback loop in
+	 * swap_cache_alloc_folio will retry with a smaller order on -EBUSY.
+	 */
+	if (is_vswap_entry(targ_entry)) {
+		ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+		ret = __vswap_check_backing(ci_dyn, round_down(ci_off, nr),
+					    nr, &type);
+		if (ret != nr || type == VSWAP_ZSWAP)
+			return -EBUSY;
+	}
+
 	is_zero = __swap_table_test_zero(ci, ci_off);
 	ci_off = round_down(ci_off, nr);
 	ci_end = ci_off + nr;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 352c5fb2ab75..a79373db45df 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -131,6 +131,26 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
 	.lock = INIT_LOCAL_LOCK(),
 };
 
+#ifdef CONFIG_VSWAP
+struct percpu_vswap_cluster {
+	unsigned long offset[SWAP_NR_ORDERS];
+	local_lock_t lock;
+};
+
+static DEFINE_PER_CPU(struct percpu_vswap_cluster, percpu_vswap_cluster) = {
+	.offset = { [0 ... SWAP_NR_ORDERS - 1] = SWAP_ENTRY_INVALID },
+	.lock = INIT_LOCAL_LOCK(),
+};
+
+static bool vswap_alloc(struct folio *folio);
+static void vswap_free_cluster(struct swap_info_struct *si,
+			       struct swap_cluster_info *ci);
+#else
+static inline bool vswap_alloc(struct folio *folio) { return false; }
+static inline void vswap_free_cluster(struct swap_info_struct *si,
+				      struct swap_cluster_info *ci) {}
+#endif
+
 /* May return NULL on invalid type, caller must check for NULL return */
 static struct swap_info_struct *swap_type_to_info(int type)
 {
@@ -236,7 +256,8 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 
 	need_reclaim = ((flags & TTRS_ANYWAY) ||
 			((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
-			((flags & TTRS_FULL) && mem_cgroup_swap_full(folio)));
+			((flags & TTRS_FULL) && mem_cgroup_swap_full(folio) &&
+			 !is_vswap_entry(folio->swap)));
 	if (!need_reclaim || !folio_swapcache_freeable(folio))
 		goto out_unlock;
 
@@ -537,7 +558,12 @@ swap_cluster_populate(struct swap_info_struct *si,
 	 * Only cluster isolation from the allocator does table allocation.
 	 * Swap allocator uses percpu clusters and holds the local lock.
 	 */
-	lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
+#ifdef CONFIG_VSWAP
+	if (swap_is_vswap(si))
+		lockdep_assert_held(&this_cpu_ptr(&percpu_vswap_cluster)->lock);
+#endif
+	if (!swap_is_vswap(si))
+		lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
 	if (!(si->flags & SWP_SOLIDSTATE))
 		lockdep_assert_held(&si->global_cluster_lock);
 	lockdep_assert_held(&ci->lock);
@@ -554,7 +580,12 @@ swap_cluster_populate(struct swap_info_struct *si,
 	spin_unlock(&ci->lock);
 	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_unlock(&si->global_cluster_lock);
-	local_unlock(&percpu_swap_cluster.lock);
+#ifdef CONFIG_VSWAP
+	if (swap_is_vswap(si))
+		local_unlock(&percpu_vswap_cluster.lock);
+#endif
+	if (!swap_is_vswap(si))
+		local_unlock(&percpu_swap_cluster.lock);
 
 	ret = swap_cluster_alloc_table(ci, __GFP_HIGH | __GFP_NOMEMALLOC |
 					   GFP_KERNEL);
@@ -567,7 +598,12 @@ swap_cluster_populate(struct swap_info_struct *si,
 	 * could happen with ignoring the percpu cluster is fragmentation,
 	 * which is acceptable since this fallback and race is rare.
 	 */
-	local_lock(&percpu_swap_cluster.lock);
+#ifdef CONFIG_VSWAP
+	if (swap_is_vswap(si))
+		local_lock(&percpu_vswap_cluster.lock);
+#endif
+	if (!swap_is_vswap(si))
+		local_lock(&percpu_swap_cluster.lock);
 	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_lock(&si->global_cluster_lock);
 	spin_lock(&ci->lock);
@@ -737,19 +773,12 @@ static void free_cluster(struct swap_info_struct *si, struct swap_cluster_info *
 		return;
 	}
 
+	/*
+	 * Vswap dynamic clusters need explicit cleanup (xarray erase,
+	 * kfree_rcu, virtual_table free if allocated).
+	 */
 	if (si->flags & SWP_VSWAP) {
-		struct swap_cluster_info_dynamic *ci_dyn;
-
-		ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
-		if (ci->flags != CLUSTER_FLAG_NONE) {
-			spin_lock(&si->lock);
-			list_del(&ci->list);
-			spin_unlock(&si->lock);
-		}
-		swap_cluster_free_table(ci);
-		xa_erase(&si->cluster_info_pool, ci_dyn->index);
-		ci->flags = CLUSTER_FLAG_DEAD;
-		kfree_rcu(ci_dyn, rcu);
+		vswap_free_cluster(si, ci);
 		return;
 	}
 
@@ -930,7 +959,8 @@ static bool cluster_scan_range(struct swap_info_struct *si,
 		if (swp_tb_is_null(swp_tb))
 			continue;
 		if (swp_tb_is_folio(swp_tb) && !__swp_tb_get_count(swp_tb)) {
-			if (!vm_swap_full())
+			/* vswap slots are unlimited; never reclaim to reuse one */
+			if (swap_is_vswap(si) || !vm_swap_full())
 				return false;
 			*need_reclaim = true;
 			continue;
@@ -998,11 +1028,12 @@ static bool __swap_cluster_alloc_entries(struct swap_info_struct *si,
 /* Try use a new cluster for current CPU and allocate from it. */
 static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 					    struct swap_cluster_info *ci,
-					    struct folio *folio, unsigned long offset)
+					    struct folio *folio,
+					    unsigned long offset)
 {
 	unsigned int next = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
 	unsigned long start = ALIGN_DOWN(offset, SWAPFILE_CLUSTER);
-	unsigned int order = likely(folio) ? folio_order(folio) : 0;
+	unsigned int order = folio ? folio_order(folio) : 0;
 	unsigned long end = start + SWAPFILE_CLUSTER;
 	unsigned int nr_pages = 1 << order;
 	bool need_reclaim, ret, usable;
@@ -1041,6 +1072,12 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 		relocate_cluster(si, ci);
 		swap_cluster_unlock(ci);
 	}
+#ifdef CONFIG_VSWAP
+	if (swap_is_vswap(si)) {
+		this_cpu_write(percpu_vswap_cluster.offset[order], next);
+		return found;
+	}
+#endif
 	if (si->flags & SWP_SOLIDSTATE) {
 		this_cpu_write(percpu_swap_cluster.offset[order], next);
 		this_cpu_write(percpu_swap_cluster.si[order], si);
@@ -1093,10 +1130,17 @@ static unsigned int alloc_swap_scan_dynamic(struct swap_info_struct *si,
 		return SWAP_ENTRY_INVALID;
 	}
 
+	if (vswap_cluster_alloc_vtable(ci_dyn)) {
+		swap_cluster_free_table(&ci_dyn->ci);
+		kfree(ci_dyn);
+		return SWAP_ENTRY_INVALID;
+	}
+
 	if (xa_alloc(&si->cluster_info_pool, &ci_dyn->index, ci_dyn,
 		     XA_LIMIT(1, DIV_ROUND_UP(si->max, SWAPFILE_CLUSTER) - 1),
 		     GFP_ATOMIC)) {
 		swap_cluster_free_table(&ci_dyn->ci);
+		vswap_cluster_free_vtable(&ci_dyn->ci);
 		kfree(ci_dyn);
 		return SWAP_ENTRY_INVALID;
 	}
@@ -1168,15 +1212,16 @@ static void swap_reclaim_work(struct work_struct *work)
 static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 					      struct folio *folio)
 {
+	unsigned int order = folio ? folio_order(folio) : 0;
 	struct swap_cluster_info *ci;
-	unsigned int order = likely(folio) ? folio_order(folio) : 0;
 	unsigned int offset = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
 
 	/*
-	 * Swapfile is not block device so unable
-	 * to allocate large entries.
+	 * File-based swap can't do large contiguous IO. vswap has no IO
+	 * here (large entries are fine; THP swapin gates on backing via
+	 * __vswap_check_backing() in __swap_cache_add_check()).
 	 */
-	if (order && !(si->flags & SWP_BLKDEV))
+	if (order && !(si->flags & SWP_BLKDEV) && !swap_is_vswap(si))
 		return 0;
 
 	if (!(si->flags & SWP_SOLIDSTATE)) {
@@ -1229,7 +1274,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 	}
 
 	/* Try reclaim full clusters if free and nonfull lists are drained */
-	if (vm_swap_full())
+	if (!swap_is_vswap(si) && vm_swap_full())
 		swap_reclaim_full_clusters(si, false);
 
 	if (order < PMD_ORDER) {
@@ -1363,10 +1408,11 @@ static bool swap_usage_add(struct swap_info_struct *si, unsigned int nr_entries)
 	long val = atomic_long_add_return_relaxed(nr_entries, &si->inuse_pages);
 
 	/*
-	 * If device is full, and SWAP_USAGE_OFFLIST_BIT is not set,
-	 * remove it from the plist.
+	 * If a physical device is full, and SWAP_USAGE_OFFLIST_BIT is not
+	 * set, remove it from the plist. Vswap is never on the avail list,
+	 * so skip it.
 	 */
-	if (unlikely(val == si->pages)) {
+	if (unlikely(val == si->pages) && !swap_is_vswap(si)) {
 		del_from_avail_list(si, false);
 		return true;
 	}
@@ -1393,7 +1439,8 @@ static void swap_range_alloc(struct swap_info_struct *si,
 		if (vm_swap_full())
 			schedule_work(&si->reclaim_work);
 	}
-	atomic_long_sub(nr_entries, &nr_swap_pages);
+	if (!swap_is_vswap(si))
+		atomic_long_sub(nr_entries, &nr_swap_pages);
 }
 
 static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
@@ -1403,8 +1450,10 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
 	unsigned int i;
 
-	for (i = 0; i < nr_entries; i++)
-		zswap_invalidate(swp_entry(si->type, offset + i));
+	if (!swap_is_vswap(si)) {
+		for (i = 0; i < nr_entries; i++)
+			zswap_invalidate(swp_entry(si->type, offset + i));
+	}
 
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
@@ -1423,7 +1472,8 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	 * only after the above cleanups are done.
 	 */
 	smp_wmb();
-	atomic_long_add(nr_entries, &nr_swap_pages);
+	if (!swap_is_vswap(si))
+		atomic_long_add(nr_entries, &nr_swap_pages);
 	swap_usage_sub(si, nr_entries);
 }
 
@@ -1825,6 +1875,46 @@ static int swap_dup_entries_cluster(struct swap_info_struct *si,
  * Context: Caller needs to hold the folio lock.
  * Return: Whether the folio was added to the swap cache.
  */
+#ifdef CONFIG_VSWAP
+static bool vswap_alloc(struct folio *folio)
+{
+	unsigned int order = folio_order(folio);
+	struct swap_cluster_info *ci;
+	unsigned long offset;
+
+	/* vswap_init failed: fall back to direct physical swap */
+	if (!vswap_si)
+		return false;
+
+	local_lock(&percpu_vswap_cluster.lock);
+	offset = this_cpu_read(percpu_vswap_cluster.offset[order]);
+
+	if (offset != SWAP_ENTRY_INVALID) {
+		ci = swap_cluster_lock(vswap_si, offset);
+		if (ci && cluster_is_usable(ci, order)) {
+			if (cluster_is_empty(ci))
+				offset = cluster_offset(vswap_si, ci);
+			alloc_swap_scan_cluster(vswap_si, ci, folio, offset);
+		} else if (ci) {
+			swap_cluster_unlock(ci);
+		}
+	}
+
+	if (!folio_test_swapcache(folio))
+		cluster_alloc_swap_entry(vswap_si, folio);
+
+	if (folio_test_swapcache(folio)) {
+		/* alloc_swap_scan_cluster updated percpu offset already */
+		local_unlock(&percpu_vswap_cluster.lock);
+		return true;
+	}
+
+	this_cpu_write(percpu_vswap_cluster.offset[order], SWAP_ENTRY_INVALID);
+	local_unlock(&percpu_vswap_cluster.lock);
+	return false;
+}
+#endif
+
 int folio_alloc_swap(struct folio *folio)
 {
 	unsigned int order = folio_order(folio);
@@ -1852,12 +1942,21 @@ int folio_alloc_swap(struct folio *folio)
 		}
 	}
 
+	/*
+	 * Skip vswap when zswap is disabled - without zswap, vswap entries
+	 * have nowhere to go on writeout (no physical fallback yet; that
+	 * arrives in the next patch).
+	 */
+	if (zswap_is_enabled() && vswap_alloc(folio))
+		goto done;
+
 again:
 	local_lock(&percpu_swap_cluster.lock);
 	if (!swap_alloc_fast(folio))
 		swap_alloc_slow(folio);
 	local_unlock(&percpu_swap_cluster.lock);
 
+done:
 	if (!order && unlikely(!folio_test_swapcache(folio))) {
 		if (swap_sync_discard())
 			goto again;
@@ -1873,6 +1972,92 @@ int folio_alloc_swap(struct folio *folio)
 	return 0;
 }
 
+#ifdef CONFIG_VSWAP
+static void vswap_free_cluster(struct swap_info_struct *si,
+			       struct swap_cluster_info *ci)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	if (ci->flags != CLUSTER_FLAG_NONE) {
+		spin_lock(&si->lock);
+		list_del(&ci->list);
+		spin_unlock(&si->lock);
+	}
+	swap_cluster_free_table(ci);
+	vswap_cluster_free_vtable(ci);
+	/*
+	 * Ordering vs the RCU cluster lookup: erase from the xarray first
+	 * (new lookups miss it), mark DEAD under the held ci->lock (a lookup
+	 * that already has ci sees DEAD on relock and bails), then kfree_rcu
+	 * so the cluster outlives any reader still in its RCU section.
+	 */
+	xa_erase(&si->cluster_info_pool, ci_dyn->index);
+	ci->flags = CLUSTER_FLAG_DEAD;
+	kfree_rcu(ci_dyn, rcu);
+}
+
+void __vswap_release_backing(struct swap_cluster_info *ci,
+			     unsigned int ci_start, unsigned int nr)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+	unsigned int ci_off;
+	unsigned long vt;
+
+	lockdep_assert_held(&ci->lock);
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+
+	for (ci_off = ci_start; ci_off < ci_start + nr; ci_off++) {
+		vt = __vtable_get(ci_dyn, ci_off);
+
+		switch (vtable_type(vt)) {
+		case VSWAP_ZSWAP:
+			zswap_entry_free(vtable_to_zswap(vt));
+			break;
+		case VSWAP_SWAPFILE:
+		case VSWAP_NONE:
+			break;
+		default:
+			/* VSWAP_ZERO/VSWAP_FOLIO are return-only, not vtable tags */
+			break;
+		}
+
+		__vtable_set(ci_dyn, ci_off, vtable_mk_none());
+		/* Zero-backed state lives in swap_table; clear it too. */
+		if (__swap_table_test_zero(ci, ci_off))
+			__swap_table_clear_zero(ci, ci_off);
+	}
+}
+
+/**
+ * folio_release_vswap_backing() - Drop all backing for a folio's vswap entry.
+ * @folio: the folio, occupying a virtual swap entry.
+ *
+ * Release whatever backing the folio's virtual swap slots currently hold and
+ * reset them to empty, so a fresh backing can be installed. Used when a
+ * folio's swap backend is replaced.
+ *
+ * Context: Caller must hold the folio lock; @folio must be in the swap cache
+ * and occupy a virtual swap entry.
+ */
+void folio_release_vswap_backing(struct folio *folio)
+{
+	struct swap_cluster_info *ci;
+	int nr = folio_nr_pages(folio);
+	unsigned int voff;
+
+	ci = __swap_entry_to_cluster(folio->swap);
+	if (!ci)
+		return;
+	voff = swp_cluster_offset(folio->swap);
+
+	spin_lock(&ci->lock);
+	__vswap_release_backing(ci, voff, nr);
+	spin_unlock(&ci->lock);
+}
+
+#endif /* CONFIG_VSWAP */
+
 /**
  * folio_dup_swap() - Increase swap count of swap entries of a folio.
  * @folio: folio with swap entries bounded.
@@ -2014,6 +2199,9 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 
 	VM_WARN_ON(ci->count < nr_pages);
 
+	if (swap_is_vswap(si))
+		__vswap_release_backing(ci, ci_start, nr_pages);
+
 	ci->count -= nr_pages;
 	do {
 		old_tb = __swap_table_get(ci, ci_off);
@@ -2879,6 +3067,7 @@ static int try_to_unuse(unsigned int type)
 	       (i = find_next_to_unuse(si, i)) != 0) {
 
 		entry = swp_entry(type, i);
+
 		folio = swap_cache_get_folio(entry);
 		if (!folio)
 			continue;
@@ -4111,8 +4300,11 @@ static int __init vswap_init(void)
 	int err;
 
 	si = alloc_swap_info();
-	if (IS_ERR(si))
-		return PTR_ERR(si);
+	if (IS_ERR(si)) {
+		pr_warn("vswap: alloc_swap_info failed (%ld); vswap disabled, swapout falls back to direct physical swap\n",
+			PTR_ERR(si));
+		return 0;
+	}
 
 	maxpages = min(swapfile_maximum_size,
 		       ALIGN_DOWN((unsigned long)UINT_MAX, SWAPFILE_CLUSTER));
@@ -4137,10 +4329,12 @@ static int __init vswap_init(void)
 	return 0;
 
 fail:
+	pr_warn("vswap: setup_swap_clusters_info failed (%d); vswap disabled, swapout falls back to direct physical swap\n",
+		err);
 	spin_lock(&swap_lock);
 	si->flags = 0;
 	spin_unlock(&swap_lock);
-	return err;
+	return 0;
 }
 late_initcall(vswap_init);
 #endif
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 299b5d9e8836..288d3787e6d4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -67,6 +67,7 @@
 
 #include "internal.h"
 #include "swap.h"
+#include "vswap.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/vmscan.h>
@@ -350,6 +351,9 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 		 */
 		if (get_nr_swap_pages() > 0)
 			return true;
+		/* vswap doesn't contribute to nr_swap_pages */
+		if (IS_ENABLED(CONFIG_VSWAP) && zswap_is_enabled())
+			return true;
 	} else {
 		/* Is the memcg below its swap limit? */
 		if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
@@ -1524,9 +1528,13 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			nr_pages = 1;
 		}
 activate_locked:
-		/* Not a candidate for swapping, so reclaim swap space. */
+		/*
+		 * Not a candidate for swapping, so reclaim physical swap
+		 * space if we are running out.
+		 */
 		if (folio_test_swapcache(folio) &&
-		    (mem_cgroup_swap_full(folio) || folio_test_mlocked(folio)))
+		    ((mem_cgroup_swap_full(folio) && !is_vswap_entry(folio->swap)) ||
+		     folio_test_mlocked(folio)))
 			folio_free_swap(folio);
 		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
 		if (!folio_test_mlocked(folio)) {
@@ -2614,7 +2622,7 @@ static bool can_age_anon_pages(struct lruvec *lruvec,
 			       struct scan_control *sc)
 {
 	/* Aging the anon LRU is valuable if swap is present: */
-	if (total_swap_pages > 0)
+	if (total_swap_pages > 0 || (IS_ENABLED(CONFIG_VSWAP) && zswap_is_enabled()))
 		return true;
 
 	/* Also valuable if anon pages can be demoted: */
diff --git a/mm/vswap.h b/mm/vswap.h
index a1fd7f7e568f..25d6094af6af 100644
--- a/mm/vswap.h
+++ b/mm/vswap.h
@@ -7,24 +7,321 @@
 #ifndef _MM_VSWAP_H
 #define _MM_VSWAP_H
 
+
 #include <linux/swap.h>
 
+struct zswap_entry;
+
+static inline bool swap_is_vswap(struct swap_info_struct *si)
+{
+	return si->flags & SWP_VSWAP;
+}
+
+/*
+ * Backing type enum. The first three are stored in the vtable per slot;
+ * the last two are return-only and synthesized by vswap_check_backing()
+ * from swap_table state.
+ */
+enum vswap_backing_type {
+	VSWAP_NONE	= 0,
+	VSWAP_SWAPFILE	= 1,
+	VSWAP_ZSWAP	= 2,
+	VSWAP_ZERO,
+	VSWAP_FOLIO,
+};
+
 #ifdef CONFIG_VSWAP
 
+#include "swap.h"
+#include "swap_table.h"
+
 extern struct swap_info_struct *vswap_si;
 
-static inline bool swap_is_vswap(struct swap_info_struct *si)
+/*
+ * Virtual table entry encoding for vswap clusters.
+ *
+ * Each entry in ci_dyn->virtual_table stores the backing type and
+ * pointer for a virtual swap slot. Tag in low 3 bits, payload in
+ * upper 61 bits.
+ *
+ *   NONE:   |----- 0000 ------|000|  - no separate backend pointer
+ *   PHYS:   |-- (type:5,off:N)|001|  - on a physical swapfile (shifted)
+ *   ZSWAP:  |--- zswap_entry* |010|  - compressed in zswap (tag in low bits)
+ *
+ * PHYS payloads are shifted left by 3. Pointer payloads (ZSWAP) are
+ * stored directly with the tag OR'd into the low bits (kernel pointers
+ * are >= 8-byte aligned, same approach as xarray).
+ *
+ * vtable[i] = NONE does not by itself mean "free". The swap_table entry
+ * and the per-slot zero flag carry the rest of the state. The full
+ * per-slot state table is:
+ *
+ *   vtable[i] | swap_table[i] | zero  | meaning
+ *   ----------+---------------+-------+--------------------------------
+ *   NONE      | NULL          | clear | truly free / unbacked
+ *   NONE      | PFN           | clear | folio cached, no backing
+ *   NONE      | shadow        | clear | folio evicted, no backing (bug)
+ *   NONE      | *             | set   | zero-backed; cached if PFN set
+ *   ZSWAP     | PFN           | clear | folio cached + zswap entry
+ *   ZSWAP     | shadow / NULL | clear | evicted, only in zswap
+ *   SWAPFILE  | PFN           | clear | folio cached + phys backing
+ *   SWAPFILE  | shadow / NULL | clear | evicted, only on phys swap
+ *
+ * Zero-backed slots use the swap_table per-slot zero flag (same as
+ * direct-mapped physical swap), since CONFIG_VSWAP requires 64BIT and
+ * SWAP_TABLE_HAS_ZEROFLAG is always true on 64-bit. Cached folios are
+ * read out of the swap_table PFN entry; there is no separate FOLIO
+ * vtable type because the folio pointer would duplicate that PFN and
+ * would go stale on folio migration / split.
+ *
+ * enum vswap_backing_type is declared above. VSWAP_ZERO and VSWAP_FOLIO
+ * are return-only synthesized values from vswap_check_backing(); they are
+ * never used as vtable tags.
+ */
+
+#define VTABLE_TAG_BITS		3
+#define VTABLE_TAG_MASK		((1UL << VTABLE_TAG_BITS) - 1)
+
+static inline enum vswap_backing_type vtable_type(unsigned long vt)
 {
-	return si->flags & SWP_VSWAP;
+	return vt & VTABLE_TAG_MASK;
 }
 
-#else
+static inline unsigned long vtable_payload(unsigned long vt)
+{
+	return vt >> VTABLE_TAG_BITS;
+}
 
-static inline bool swap_is_vswap(struct swap_info_struct *si)
+static inline unsigned long vtable_mk(enum vswap_backing_type type,
+				       unsigned long payload)
 {
-	return false;
+	return (payload << VTABLE_TAG_BITS) | type;
+}
+
+static inline unsigned long vtable_mk_none(void)
+{
+	return 0;
+}
+
+static inline unsigned long vtable_mk_phys(swp_entry_t entry)
+{
+	return vtable_mk(VSWAP_SWAPFILE, entry.val);
+}
+
+static inline swp_entry_t vtable_to_phys(unsigned long vt)
+{
+	swp_entry_t entry;
+
+	VM_WARN_ON(vtable_type(vt) != VSWAP_SWAPFILE);
+	entry.val = vtable_payload(vt);
+	return entry;
+}
+
+static inline struct zswap_entry *vtable_to_zswap(unsigned long vt)
+{
+	VM_WARN_ON(vtable_type(vt) != VSWAP_ZSWAP);
+	return (struct zswap_entry *)(vt & ~VTABLE_TAG_MASK);
+}
+
+/* Virtual table accessors */
+
+static inline unsigned long __vtable_get(struct swap_cluster_info_dynamic *ci_dyn,
+					 unsigned int off)
+{
+	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
+	return atomic_long_read(&ci_dyn->virtual_table[off]);
+}
+
+static inline void __vtable_set(struct swap_cluster_info_dynamic *ci_dyn,
+				unsigned int off, unsigned long vt)
+{
+	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
+	atomic_long_set(&ci_dyn->virtual_table[off], vt);
+}
+
+/*
+ * Lock a vswap cluster and return the dynamic info + slot offset.
+ * Returns NULL if cluster not found.
+ * Caller must spin_unlock(&ci_dyn->ci.lock) when done.
+ */
+static inline struct swap_cluster_info_dynamic *
+vswap_lock_cluster(swp_entry_t entry, unsigned int *voff)
+{
+	struct swap_cluster_info *ci;
+	struct swap_cluster_info_dynamic *ci_dyn;
+
+	ci = __swap_entry_to_cluster(entry);
+	if (!ci)
+		return NULL;
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	*voff = swp_cluster_offset(entry);
+	spin_lock(&ci->lock);
+	return ci_dyn;
+}
+
+void __vswap_release_backing(struct swap_cluster_info *ci,
+			     unsigned int ci_start, unsigned int nr);
+
+static inline void vswap_zswap_store(swp_entry_t entry,
+				     struct zswap_entry *ze)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+	unsigned int voff;
+
+	ci_dyn = vswap_lock_cluster(entry, &voff);
+	if (!ci_dyn)
+		return;
+	__vswap_release_backing(&ci_dyn->ci, voff, 1);
+	__vtable_set(ci_dyn, voff, (unsigned long)ze | VSWAP_ZSWAP);
+	spin_unlock(&ci_dyn->ci.lock);
+}
+
+static inline struct zswap_entry *vswap_zswap_load(swp_entry_t entry)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+	unsigned int voff;
+	unsigned long vt;
+
+	ci_dyn = vswap_lock_cluster(entry, &voff);
+	if (!ci_dyn)
+		return NULL;
+	vt = __vtable_get(ci_dyn, voff);
+	spin_unlock(&ci_dyn->ci.lock);
+
+	if (vtable_type(vt) != VSWAP_ZSWAP)
+		return NULL;
+	return vtable_to_zswap(vt);
+}
+
+
+void folio_release_vswap_backing(struct folio *folio);
+
+/*
+ * Walk nr vtable slots starting at voff in ci_dyn. Returns the prefix
+ * length of slots sharing one effective backing type. For SWAPFILE,
+ * the prefix is also restricted to contiguous offsets in the same
+ * swapfile.
+ *
+ * Effective type per slot (zero flag takes precedence over PFN since
+ * zero is a backend state and the cached folio is just an overlay):
+ *   vtable=NONE + zero flag set       -> VSWAP_ZERO
+ *   vtable=NONE + swap_table PFN tag  -> VSWAP_FOLIO
+ *   vtable=NONE + neither             -> VSWAP_NONE
+ *   vtable=SWAPFILE                   -> VSWAP_SWAPFILE
+ *   vtable=ZSWAP                      -> VSWAP_ZSWAP
+ *
+ * *typep returns the effective type of slot 0. Caller holds
+ * ci_dyn->ci.lock.
+ */
+static inline int __vswap_check_backing(struct swap_cluster_info_dynamic *ci_dyn,
+					unsigned int voff, int nr,
+					enum vswap_backing_type *typep)
+{
+	enum vswap_backing_type first_type = VSWAP_NONE;
+	enum vswap_backing_type slot_type;
+	swp_entry_t first_phys = {};
+	unsigned long vt, swap_tb;
+	int i;
+
+	lockdep_assert_held(&ci_dyn->ci.lock);
+
+	for (i = 0; i < nr; i++) {
+		vt = __vtable_get(ci_dyn, voff + i);
+		if (vtable_type(vt) == VSWAP_NONE) {
+			swap_tb = __swap_table_get(&ci_dyn->ci, voff + i);
+			if (__swap_table_test_zero(&ci_dyn->ci, voff + i))
+				slot_type = VSWAP_ZERO;
+			else if (swp_tb_is_folio(swap_tb))
+				slot_type = VSWAP_FOLIO;
+			else
+				slot_type = VSWAP_NONE;
+		} else {
+			slot_type = vtable_type(vt);
+		}
+
+		if (!i) {
+			first_type = slot_type;
+			if (first_type == VSWAP_SWAPFILE)
+				first_phys = vtable_to_phys(vt);
+		} else if (slot_type != first_type) {
+			break;
+		} else if (first_type == VSWAP_SWAPFILE &&
+			   vtable_to_phys(vt).val != first_phys.val + i) {
+			break;
+		}
+	}
+
+	if (typep)
+		*typep = first_type;
+	return i;
+}
+
+static inline int vswap_check_backing(swp_entry_t entry, int nr,
+				      enum vswap_backing_type *typep)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+	unsigned int voff;
+	int ret;
+
+	ci_dyn = vswap_lock_cluster(entry, &voff);
+	if (!ci_dyn) {
+		if (typep)
+			*typep = VSWAP_NONE;
+		return 0;
+	}
+	ret = __vswap_check_backing(ci_dyn, voff, nr, typep);
+	spin_unlock(&ci_dyn->ci.lock);
+	return ret;
+}
+
+static inline int vswap_cluster_alloc_vtable(struct swap_cluster_info_dynamic *ci_dyn)
+{
+	ci_dyn->virtual_table = kcalloc(SWAPFILE_CLUSTER,
+					sizeof(*ci_dyn->virtual_table),
+					GFP_ATOMIC);
+	return ci_dyn->virtual_table ? 0 : -ENOMEM;
+}
+
+static inline void vswap_cluster_free_vtable(struct swap_cluster_info *ci)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	kfree(ci_dyn->virtual_table);
+	ci_dyn->virtual_table = NULL;
+}
+
+#else /* !CONFIG_VSWAP */
+
+static inline void __vswap_release_backing(struct swap_cluster_info *ci,
+					   unsigned int ci_start,
+					   unsigned int nr) {}
+
+static inline void vswap_zswap_store(swp_entry_t entry,
+				     struct zswap_entry *ze) {}
+
+static inline struct zswap_entry *vswap_zswap_load(swp_entry_t entry)
+{
+	return NULL;
 }
 
+static inline void folio_release_vswap_backing(struct folio *folio) {}
+
+struct swap_cluster_info_dynamic;
+static inline int __vswap_check_backing(struct swap_cluster_info_dynamic *ci_dyn,
+					unsigned int voff, int nr,
+					enum vswap_backing_type *typep)
+{
+	return 0;
+}
+
+static inline int vswap_cluster_alloc_vtable(struct swap_cluster_info_dynamic *ci_dyn)
+{
+	return 0;
+}
+
+static inline void vswap_cluster_free_vtable(struct swap_cluster_info *ci) {}
+
 #endif /* CONFIG_VSWAP */
 
 #ifdef CONFIG_SWAP
diff --git a/mm/zswap.c b/mm/zswap.c
index 993406074d58..466f8a182716 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -38,6 +38,7 @@
 #include <linux/zsmalloc.h>
 
 #include "swap.h"
+#include "vswap.h"
 #include "internal.h"
 
 /*********************************
@@ -762,7 +763,7 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
  * Carries out the common pattern of freeing an entry's zsmalloc allocation,
  * freeing the entry itself, and decrementing the number of stored pages.
  */
-static void zswap_entry_free(struct zswap_entry *entry)
+void zswap_entry_free(struct zswap_entry *entry)
 {
 	zswap_lru_del(&zswap_list_lru, entry);
 	zs_free(entry->pool->zs_pool, entry->handle);
@@ -994,16 +995,21 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct swap_info_struct *si;
 	int ret = 0;
 
+	/* try to allocate swap cache folio */
 	si = get_swap_device(swpentry);
 	if (!si)
 		return -EEXIST;
 
+	/*
+	 * Vswap entries have no physical backing - writeback would fail
+	 * and SIGBUS the caller. Bail before we waste a swap-cache folio
+	 * allocation.
+	 */
 	if (si->flags & SWP_VSWAP) {
 		put_swap_device(si);
 		return -EINVAL;
 	}
 
-	/* try to allocate swap cache folio */
 	mpol = get_task_policy(current);
 	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NULL, mpol,
 				       NO_INTERLEAVE_INDEX);
@@ -1416,25 +1422,25 @@ static bool zswap_store_page(struct page *page,
 	if (!zswap_compress(page, entry, pool))
 		goto compress_failed;
 
-	old = xa_store(swap_zswap_tree(page_swpentry),
-		       swp_offset(page_swpentry),
-		       entry, GFP_KERNEL);
-	if (xa_is_err(old)) {
-		int err = xa_err(old);
+	if (is_vswap_entry(page_swpentry)) {
+		vswap_zswap_store(page_swpentry, entry);
+	} else {
+		old = xa_store(swap_zswap_tree(page_swpentry),
+			       swp_offset(page_swpentry),
+			       entry, GFP_KERNEL);
+		if (xa_is_err(old)) {
+			int err = xa_err(old);
+
+			WARN_ONCE(err != -ENOMEM,
+				  "unexpected xarray error: %d\n", err);
+			zswap_reject_alloc_fail++;
+			goto store_failed;
+		}
 
-		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
-		zswap_reject_alloc_fail++;
-		goto store_failed;
+		if (old)
+			zswap_entry_free(old);
 	}
 
-	/*
-	 * We may have had an existing entry that became stale when
-	 * the folio was redirtied and now the new version is being
-	 * swapped out. Get rid of the old.
-	 */
-	if (old)
-		zswap_entry_free(old);
-
 	/*
 	 * The entry is successfully compressed and stored in the tree, there is
 	 * no further possibility of failure. Grab refs to the pool and objcg,
@@ -1487,6 +1493,7 @@ bool zswap_store(struct folio *folio)
 	struct mem_cgroup *memcg = NULL;
 	struct zswap_pool *pool;
 	bool ret = false;
+	bool partial_store = false;
 	long index;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
@@ -1524,8 +1531,10 @@ bool zswap_store(struct folio *folio)
 	for (index = 0; index < nr_pages; ++index) {
 		struct page *page = folio_page(folio, index);
 
-		if (!zswap_store_page(page, objcg, pool))
+		if (!zswap_store_page(page, objcg, pool)) {
+			partial_store = index > 0;
 			goto put_pool;
+		}
 	}
 
 	if (objcg)
@@ -1548,7 +1557,9 @@ bool zswap_store(struct folio *folio)
 	 * offsets corresponding to each page of the folio. Otherwise,
 	 * writeback could overwrite the new data in the swapfile.
 	 */
-	if (!ret) {
+	if (partial_store && is_vswap_entry(swp))
+		folio_release_vswap_backing(folio);
+	else if (!ret && !is_vswap_entry(swp)) {
 		unsigned type = swp_type(swp);
 		pgoff_t offset = swp_offset(swp);
 		struct zswap_entry *entry;
@@ -1588,8 +1599,7 @@ bool zswap_store(struct folio *folio)
 int zswap_load(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
-	pgoff_t offset = swp_offset(swp);
-	struct xarray *tree = swap_zswap_tree(swp);
+	struct swap_info_struct *si = __swap_entry_to_info(swp);
 	struct zswap_entry *entry;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
@@ -1599,16 +1609,25 @@ int zswap_load(struct folio *folio)
 		return -ENOENT;
 
 	/*
-	 * Large folios should not be swapped in while zswap is being used, as
-	 * they are not properly handled. Zswap does not properly load large
-	 * folios, and a large folio may only be partially in zswap.
+	 * zswap_load() does not support large folios. For non-vswap
+	 * entries this is unexpected on the swapin path: WARN and
+	 * sigbus. For vswap entries __swap_cache_add_check() has already
+	 * filtered out ZSWAP-backed THPs under the cluster lock, so the
+	 * large folio here is zero- or phys-backed; return -ENOENT to
+	 * fall through to the phys/zero IO path.
 	 */
-	if (WARN_ON_ONCE(folio_test_large(folio))) {
-		folio_unlock(folio);
-		return -EINVAL;
+	if (folio_test_large(folio)) {
+		if (WARN_ON_ONCE(!swap_is_vswap(si))) {
+			folio_unlock(folio);
+			return -EINVAL;
+		}
+		return -ENOENT;
 	}
 
-	entry = xa_load(tree, offset);
+	if (swap_is_vswap(si))
+		entry = vswap_zswap_load(swp);
+	else
+		entry = xa_load(swap_zswap_tree(swp), swp_offset(swp));
 	if (!entry)
 		return -ENOENT;
 
@@ -1623,16 +1642,14 @@ int zswap_load(struct folio *folio)
 	if (entry->objcg)
 		count_objcg_events(entry->objcg, ZSWPIN, 1);
 
-	/*
-	 * We are reading into the swapcache, invalidate zswap entry.
-	 * The swapcache is the authoritative owner of the page and
-	 * its mappings, and the pressure that results from having two
-	 * in-memory copies outweighs any benefits of caching the
-	 * compression work.
-	 */
 	folio_mark_dirty(folio);
-	xa_erase(tree, offset);
-	zswap_entry_free(entry);
+
+	if (swap_is_vswap(si)) {
+		folio_release_vswap_backing(folio);
+	} else {
+		xa_erase(swap_zswap_tree(swp), swp_offset(swp));
+		zswap_entry_free(entry);
+	}
 
 	folio_unlock(folio);
 	return 0;
-- 
2.53.0-Meta


