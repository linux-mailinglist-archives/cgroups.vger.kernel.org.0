Return-Path: <cgroups+bounces-16429-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPC9NM+FGWouxQgAu9opvQ
	(envelope-from <cgroups+bounces-16429-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:25:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 870146023C1
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 122CB3075AD5
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47563352000;
	Fri, 29 May 2026 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="S7/7VMTF"
X-Original-To: cgroups@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8069F3E0240;
	Fri, 29 May 2026 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057196; cv=none; b=Y/OJ0OqzoY3yn0LNyZEd4s7Zl8EtIVCr+i+oKVfrVn/92xeyQzkuz2EWav8xVVdyRJqU/qid3u/nTxVKJceIFxCkzrVGaKWTMG6RTstqPLJmkgniyNSHCwTNpqzlVXd4JG5DncXd8APlDeqV4hLGhT9CW8I7M4YkLaswiaxgPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057196; c=relaxed/simple;
	bh=N3a8S+cu7eF5svVcyWafGORVDlZ1pYeRMLR5WOLvyQc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=B+Dig6TKRzdWKVs9kCuJxj/Ehg8FhMZm6ka8N2eVI/JsMw0m7YfEsx4w/9+otYPWq0kkSRuvAXqcQMnMA00C3poHCRhKRzsPJpxSjLugY5he7GJFHjcsiSaeTK8422iHf5rIwrZIX2S0AFRJaBbhTPJ+X1P9vYObpuvxP2m6xvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=S7/7VMTF; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780057185; bh=kl4wii9J3ChOs7nTTpM79Hhbg1V1e1SmdcBHFxEE0sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S7/7VMTF2p4WUnkjXd9oMK4prBrss/vil+bREisKEI3a5N1ZH3gW+zSUgNKfHt9sV
	 0u510DSEovZt/WtrLm9/01lOWTRQxlMu8DIuu5E44z8ojGgAzjCn9vj8LvUgMkox0O
	 lPXr6nnNrlnAj5aWyiANMSOjmdVI+DMkq36zZCJ4=
Received: from node68.. ([166.111.236.25])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 4DC10017; Fri, 29 May 2026 20:19:28 +0800
X-QQ-mid: xmsmtpt1780057182t9ia4wj44
Message-ID: <tencent_5185ABF4594EB17C1ED5C36F44EE26D2E205@qq.com>
X-QQ-XMAILINFO: MFA3rFz8fXqrL3TcEFDEZcEzucYlFRdI7QXOI63aSlIg61BH/4wc6n0xwKM/Py
	 /yZog2STHLXTXeVT5sNihqGQ3EW/bly5bV8I3/pBmGrkWpHv7jFVitqKgz0zSwhsvwykkUtQFgKR
	 lTwt2i3FLG6weLwapkzFNDygnomcSuPM3HIHhLTrnFQ06mrNTMggEohFvpOtCkA/25jofLNhAdoO
	 IQO+SJwCN+Q0UiYZbjvxzHmk22sWLzg90wIjWCoFHOuVMb14lwU2PtRovbS3V82uBqchkK5Aruok
	 Sjhtz1KxyhuUg8Y1QnZYkehz5CUC0yGQf3EPlAiQp3FIhq/vXZUbYxjda2mm10RCscaUfVJntIgo
	 PbFK0BPq8wuVK2/5kp3igGP28/Db1K1W9on3bcc8PD+kxnxA27hMSXpTfltl3BhXoXzYlPOffBb4
	 kNojrW1XvTetpGjqT+fI9Y7XOEsHSKoJkFeE5NgNQQ7SPA1BKgJpE9F36oyM8QaXVzIoIm54lh1N
	 d0Re30SwdrHWMRKtj0b8dn14bu0CCo3u4BNCNepwoWIRdKg+z8GqvV0CO2Cz3I+1re/guRqVWhyZ
	 Uk++SablSl7mCTNpRLsT1HKRNKYin1Ippfh3fvT8QET/fEa9JHHIvsq3nRFyYviEB/eW+qGxIj7n
	 menDaWqozWKNjv4IH5wsRBNDZg80k3EXc8YgmyQY7SuzxE5CSZ+AgRhLEcgyAW4aPcZ7URWoSRbj
	 RjKk7ZiKUosItWJGBd1eK2n9/fdXk1u6GUdWtZmVSBjOoT2lASijNEBSMf7YJAAwGW1YaolYB+aw
	 lVgzFCmXPJirp7Vhl57fYoc5dgqKXuqEgElk94QTwX+5qpcfvKZuhaiUGjT3W/zda5ssEi+4B+jP
	 r4aCn53Q48dvCzrBh5VBqZIuITbGA7IDcdma4Qb5jM7Zbr0RKhlV/fMRd8dNNF1PfyKz4kezJBaU
	 ATcCukAi4fWL9m1pV/tPlyzBBY6vQZ3xjhs8nr6WRLJDcmoDhaLGg/cibhVxM7fFjo6w3fURW4u6
	 18zh/hJEUBJqyXbmiChsZGmCfovZgCNBhf4Evf5OSQNISaGDouWATATlXsicU=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: fujunjie <fujunjie1@qq.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@meta.com>,
	Kairui Song <kasong@tencent.com>,
	Usama Arif <usamaarif642@gmail.com>
Cc: Chris Li <chrisl@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v2 8/9] mm: try all-zswap large swapin within swap readahead windows
Date: Fri, 29 May 2026 12:19:27 +0000
X-OQ-MSGID: <20260529121928.4115683-8-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16429-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[linux-foundation.org,kvack.org,meta.com,tencent.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,gmail.com,google.com,linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fujunjie1@qq.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ra.win:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 870146023C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The non-synchronous swap fault path already computes either a VMA-based
or cluster-based readahead window. Use that existing window as locality
evidence for zswap-backed large swapin instead of mixing it with the
synchronous anon/shmem evidence.

The path first prepares the normal readahead window. If the faulting
aligned range is fully covered by that window and is still all-zswap, it
may be loaded as one large folio. If the large attempt fails or a backend
race is detected, the precomputed order-0 readahead window is used
without updating readahead state again.

Mixed zswap/disk ranges remain order-0 only. Disk-backed large swapin is
not added by this change.

Signed-off-by: fujunjie <fujunjie1@qq.com>
---
 mm/memory.c     |   6 +-
 mm/swap.h       |   4 +-
 mm/swap_state.c | 434 +++++++++++++++++++++++++++++++++++++++---------
 mm/swapfile.c   |   2 +-
 4 files changed, 360 insertions(+), 86 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7bbb89632000..451375090d83 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5027,13 +5027,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (folio)
 		swap_update_readahead(folio, vma, vmf->address);
 	if (!folio) {
+		unsigned long swapin_orders = thp_swapin_suitable_orders(vmf);
+
 		/*
 		 * Swapin bypasses readahead for SWP_SYNCHRONOUS_IO devices.
 		 * The swap device is pinned while checking the flag, matching
 		 * the existing fault path.
 		 */
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
-			unsigned long swapin_orders = thp_swapin_suitable_orders(vmf);
 			unsigned long locality_orders =
 				swapin_anon_locality_orders(vmf, swapin_orders);
 
@@ -5041,7 +5042,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 					    swapin_orders | BIT(0),
 					    locality_orders, vmf, NULL, 0);
 		} else {
-			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf);
+			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
+						 swapin_orders, vmf);
 		}
 
 		if (IS_ERR_OR_NULL(folio)) {
diff --git a/mm/swap.h b/mm/swap.h
index 5d1c81ab49b9..0e1bf9218b5e 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -323,7 +323,7 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
 struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
-			struct vm_fault *vmf);
+			       unsigned long orders, struct vm_fault *vmf);
 struct folio *swapin_sync(swp_entry_t entry, gfp_t flag, unsigned long orders,
 			  unsigned long locality_orders, struct vm_fault *vmf,
 			  struct mempolicy *mpol, pgoff_t ilx);
@@ -413,7 +413,7 @@ static inline struct folio *swap_cluster_readahead(swp_entry_t entry,
 }
 
 static inline struct folio *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
-			struct vm_fault *vmf)
+				unsigned long orders, struct vm_fault *vmf)
 {
 	return NULL;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 80dff6a1ee65..4f1eb0a7f9f5 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -678,20 +678,24 @@ static bool swapin_zswap_admit(swp_entry_t entry,
 static unsigned long swapin_admit_orders(swp_entry_t entry,
 					 unsigned long orders,
 					 struct vm_fault *vmf,
-					 unsigned long locality_orders)
+					 unsigned long locality_orders,
+					 bool zswap_only)
 {
 	unsigned long candidates = orders & ~BIT(0);
-	unsigned long admitted = orders & BIT(0);
+	unsigned long admitted = zswap_only ? 0 : orders & BIT(0);
+	enum zswap_range_state fault_zswap_state = ZSWAP_RANGE_NEVER_ENABLED;
 	struct zswap_admit_ctx zswap_ctx = {};
+	bool fault_zswap_checked = false;
 	int order;
 
 	if (!candidates)
-		return orders;
+		return zswap_only ? 0 : orders;
 
 	while (candidates) {
 		enum zswap_range_state state;
 		unsigned int nr_pages;
 		swp_entry_t range_entry;
+		bool zswap_locality;
 		bool admit = false;
 
 		order = fls_long(candidates) - 1;
@@ -703,6 +707,29 @@ static unsigned long swapin_admit_orders(swp_entry_t entry,
 		nr_pages = 1U << order;
 		range_entry = swp_entry(swp_type(entry),
 					round_down(swp_offset(entry), nr_pages));
+		zswap_locality = order <= SWAPIN_ZSWAP_MAX_ORDER &&
+				 swapin_zswap_locality(vmf, order,
+						       locality_orders);
+		/*
+		 * If the faulting slot is already in zswap but this order has
+		 * no zswap locality evidence, a larger range covering the fault
+		 * cannot be admitted: it is either all-zswap or mixed, and both
+		 * require zswap locality. Avoid scanning the whole range on
+		 * sparse/random zswap refaults. If the faulting slot is not in
+		 * zswap, keep the full classification so all-disk large swapin
+		 * can follow the existing policy.
+		 */
+		if (!zswap_locality) {
+			if (zswap_only)
+				goto next;
+			if (!fault_zswap_checked) {
+				fault_zswap_state = zswap_probe_range(entry, 1);
+				fault_zswap_checked = true;
+			}
+			if (fault_zswap_state == ZSWAP_RANGE_ALL_ZSWAP)
+				goto next;
+		}
+
 		if (!swapin_zeromap_same(range_entry, nr_pages))
 			goto next;
 
@@ -718,7 +745,7 @@ static unsigned long swapin_admit_orders(swp_entry_t entry,
 			break;
 		case ZSWAP_RANGE_NEVER_ENABLED:
 		case ZSWAP_RANGE_NO_ZSWAP:
-			admit = true;
+			admit = !zswap_only;
 			break;
 		}
 
@@ -730,21 +757,32 @@ static unsigned long swapin_admit_orders(swp_entry_t entry,
 		candidates &= ~BIT(order);
 	}
 
-	return admitted ? admitted : BIT(0);
+	return admitted ? admitted : (zswap_only ? 0 : BIT(0));
 }
 
-static bool zswap_needs_order0_retry(struct folio *folio)
+static bool zswap_folio_all_zswap(struct folio *folio)
 {
+	return zswap_probe_range(folio->swap, folio_nr_pages(folio)) ==
+	       ZSWAP_RANGE_ALL_ZSWAP;
+}
+
+static bool zswap_needs_fallback(struct folio *folio, bool zswap_only)
+{
+	enum zswap_range_state state;
+
 	if (!folio_test_large(folio))
 		return false;
 
+	state = zswap_probe_range(folio->swap, folio_nr_pages(folio));
+	if (zswap_only)
+		return state != ZSWAP_RANGE_ALL_ZSWAP;
+
 	/*
 	 * Admission sees only an advisory zswap snapshot. Recheck after the
 	 * large swapcache folio is installed; if the range became mixed, drop
 	 * the fresh folio before IO and let order-0 handle each slot.
 	 */
-	return zswap_probe_range(folio->swap, folio_nr_pages(folio)) ==
-	       ZSWAP_RANGE_MIXED;
+	return state == ZSWAP_RANGE_MIXED;
 }
 
 /*
@@ -758,8 +796,7 @@ bool swapin_fault_only_young(struct folio *folio)
 	if (!folio_test_large(folio) || !folio_test_swapcache(folio))
 		return false;
 
-	return zswap_probe_range(folio->swap, folio_nr_pages(folio)) ==
-	       ZSWAP_RANGE_ALL_ZSWAP;
+	return zswap_folio_all_zswap(folio);
 }
 
 /*
@@ -893,34 +930,15 @@ static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
 	return folio;
 }
 
-/**
- * swapin_sync - swap-in one or multiple entries skipping readahead.
- * @entry: swap entry indicating the target slot
- * @gfp: memory allocation flags
- * @orders: allocation orders
- * @locality_orders: orders with caller-provided locality evidence
- * @vmf: fault information
- * @mpol: NUMA memory allocation policy to be applied
- * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
- *
- * This allocates a folio suitable for given @orders, or returns the
- * existing folio in the swap cache for @entry. This initiates the IO, too,
- * if needed. @entry is rounded down if @orders allow large allocation.
- *
- * Context: Caller must ensure @entry is valid and pin the swap device with
- * refcount.
- * Return: Returns the folio on success, error code if failed.
- */
-struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp,
-			  unsigned long orders,
-			  unsigned long locality_orders,
-			  struct vm_fault *vmf, struct mempolicy *mpol,
-			  pgoff_t ilx)
+static struct folio *swapin_alloc_read(swp_entry_t entry, gfp_t gfp,
+				       unsigned long orders,
+				       struct vm_fault *vmf,
+				       struct mempolicy *mpol, pgoff_t ilx,
+				       bool retry_order0, bool zswap_only)
 {
 	struct folio *folio;
 	int ret;
 
-	orders = swapin_admit_orders(entry, orders, vmf, locality_orders);
 again:
 	do {
 		folio = swap_cache_get_folio(entry);
@@ -931,19 +949,21 @@ struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp,
 	} while (PTR_ERR(folio) == -EEXIST);
 
 	if (IS_ERR(folio))
-		return folio;
+		return retry_order0 ? folio : NULL;
 
-	if (zswap_needs_order0_retry(folio)) {
+	if (zswap_needs_fallback(folio, zswap_only)) {
 		count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN_FALLBACK);
 		/*
 		 * The folio is newly allocated, locked, clean and not uptodate;
 		 * no data has been read into it. Removing it only restores the
-		 * swap table entries so order-0 swapin can resolve a backend
+		 * swap table entries so the fallback path can resolve a backend
 		 * race without attempting speculative large-folio zswapin.
 		 */
 		swap_cache_del_folio(folio);
 		folio_unlock(folio);
 		folio_put(folio);
+		if (!retry_order0)
+			return NULL;
 		orders = BIT(0);
 		goto again;
 	}
@@ -954,12 +974,62 @@ struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp,
 		swap_cache_del_folio(folio);
 		folio_unlock(folio);
 		folio_put(folio);
+		if (!retry_order0)
+			return NULL;
 		orders = BIT(0);
 		goto again;
 	}
 	return folio;
 }
 
+/**
+ * swapin_sync - swap-in one or multiple entries skipping readahead.
+ * @entry: swap entry indicating the target slot
+ * @gfp: memory allocation flags
+ * @orders: allocation orders
+ * @locality_orders: orders with caller-provided locality evidence
+ * @vmf: fault information
+ * @mpol: NUMA memory allocation policy to be applied
+ * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
+ *
+ * This allocates a folio suitable for given @orders, or returns the
+ * existing folio in the swap cache for @entry. This initiates the IO, too,
+ * if needed. @entry is rounded down if @orders allow large allocation.
+ *
+ * Context: Caller must ensure @entry is valid and pin the swap device with
+ * refcount.
+ * Return: Returns the folio on success, error code if failed.
+ */
+struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp,
+			  unsigned long orders,
+			  unsigned long locality_orders,
+			  struct vm_fault *vmf, struct mempolicy *mpol,
+			  pgoff_t ilx)
+{
+	orders = swapin_admit_orders(entry, orders, vmf,
+				     locality_orders, false);
+	return swapin_alloc_read(entry, gfp, orders, vmf, mpol, ilx,
+				 true, false);
+}
+
+static struct folio *swapin_zswap_large(swp_entry_t entry, gfp_t gfp,
+					unsigned long orders,
+					unsigned long locality_orders,
+					struct vm_fault *vmf,
+					struct mempolicy *mpol, pgoff_t ilx)
+{
+	if (READ_ONCE(page_cluster) <= 0)
+		return NULL;
+
+	orders = swapin_admit_orders(entry, orders, vmf,
+				     locality_orders, true);
+	if (!orders)
+		return NULL;
+
+	return swapin_alloc_read(entry, gfp, orders, vmf, mpol, ilx,
+				 false, true);
+}
+
 /*
  * Locate a page of swap in physical memory, reserving swap cache space
  * and reading the disk if it is not already cached.
@@ -1048,12 +1118,88 @@ static unsigned long swapin_nr_pages(unsigned long offset)
 	return pages;
 }
 
+struct swap_cluster_ra {
+	unsigned long start_offset;
+	unsigned long end_offset;
+	bool readahead;
+};
+
+static void swap_cluster_ra_prepare(swp_entry_t entry,
+				    struct swap_cluster_ra *ra)
+{
+	struct swap_info_struct *si = __swap_entry_to_info(entry);
+	unsigned long entry_offset = swp_offset(entry);
+	unsigned long mask;
+
+	mask = swapin_nr_pages(entry_offset) - 1;
+	ra->readahead = !!mask;
+	ra->start_offset = entry_offset;
+	ra->end_offset = entry_offset;
+	if (!mask)
+		return;
+
+	/* Read a page_cluster sized and aligned cluster around offset. */
+	ra->start_offset = entry_offset & ~mask;
+	ra->end_offset = entry_offset | mask;
+	if (!ra->start_offset)	/* First page is swap header. */
+		ra->start_offset++;
+	if (ra->end_offset >= si->max)
+		ra->end_offset = si->max - 1;
+}
+
+static unsigned long swap_cluster_ra_orders(swp_entry_t entry,
+					    unsigned long orders,
+					    const struct swap_cluster_ra *ra)
+{
+	unsigned long admitted = 0;
+	unsigned long candidates = orders & ~BIT(0);
+	unsigned long entry_offset = swp_offset(entry);
+	int order;
+
+	if (!ra->readahead)
+		return 0;
+
+	while (candidates) {
+		unsigned long nr_pages;
+		unsigned long start_offset;
+		unsigned long end_offset;
+
+		order = fls_long(candidates) - 1;
+		if (order > MAX_PAGE_ORDER) {
+			candidates &= ~BIT(order);
+			continue;
+		}
+
+		nr_pages = 1UL << order;
+		start_offset = round_down(entry_offset, nr_pages);
+		end_offset = start_offset + nr_pages - 1;
+		if (start_offset >= ra->start_offset &&
+		    end_offset <= ra->end_offset)
+			admitted |= BIT(order);
+		candidates &= ~BIT(order);
+	}
+
+	return admitted;
+}
+
+static bool swapin_readahead_skip(unsigned long index,
+				  unsigned long skip_start,
+				  unsigned long skip_end)
+{
+	return skip_start < skip_end &&
+	       index >= skip_start && index < skip_end;
+}
+
 /**
- * swap_cluster_readahead - swap in pages in hope we need them soon
+ * swap_cluster_readahead_win - swap in pages from a prepared swap window
  * @entry: swap entry of this memory
  * @gfp_mask: memory allocation flags
  * @mpol: NUMA memory allocation policy to be applied
  * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
+ * @ra: readahead window prepared by swap_cluster_ra_prepare()
+ * @skip_start: first offset already covered by @target_folio
+ * @skip_end: offset after the already covered range
+ * @target_folio: target folio to return after queueing the rest of the window
  *
  * Returns the struct folio for entry and addr, after queueing swapin.
  *
@@ -1066,33 +1212,38 @@ static unsigned long swapin_nr_pages(unsigned long offset)
  * are used for every page of the readahead: neighbouring pages on swap
  * are fairly likely to have been swapped out from the same node.
  */
-struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
-				     struct mempolicy *mpol, pgoff_t ilx)
+static struct folio *swap_cluster_readahead_win(swp_entry_t entry,
+						gfp_t gfp_mask,
+						struct mempolicy *mpol,
+						pgoff_t ilx,
+						const struct swap_cluster_ra *ra,
+						unsigned long skip_start,
+						unsigned long skip_end,
+						struct folio *target_folio)
 {
 	struct folio *folio;
 	unsigned long entry_offset = swp_offset(entry);
-	unsigned long offset = entry_offset;
-	unsigned long start_offset, end_offset;
-	unsigned long mask;
-	struct swap_info_struct *si = __swap_entry_to_info(entry);
+	unsigned long offset;
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
 	swp_entry_t ra_entry;
 
-	mask = swapin_nr_pages(offset) - 1;
-	if (!mask)
+	if (!ra->readahead)
 		goto skip;
 
-	/* Read a page_cluster sized and aligned cluster around offset. */
-	start_offset = offset & ~mask;
-	end_offset = offset | mask;
-	if (!start_offset)	/* First page is swap header. */
-		start_offset++;
-	if (end_offset >= si->max)
-		end_offset = si->max - 1;
+	if (target_folio &&
+	    skip_start <= ra->start_offset && skip_end > ra->end_offset)
+		goto skip;
 
 	blk_start_plug(&plug);
-	for (offset = start_offset; offset <= end_offset ; offset++) {
+	for (offset = ra->start_offset; offset <= ra->end_offset; offset++) {
+		if (swapin_readahead_skip(offset, skip_start, skip_end)) {
+			if (skip_end > ra->end_offset)
+				break;
+			offset = skip_end - 1;
+			continue;
+		}
+
 		/* Ok, do the async read-ahead now */
 		ra_entry = swp_entry(swp_type(entry), offset);
 		folio = swap_cache_read_folio(ra_entry, gfp_mask, mpol, ilx,
@@ -1105,10 +1256,29 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	swap_read_unplug(splug);
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
+	if (target_folio)
+		return target_folio;
+
 	/* The page was likely read above, so no need for plugging here */
 	return swap_cache_read_folio(entry, gfp_mask, mpol, ilx, NULL, false);
 }
 
+struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
+				     struct mempolicy *mpol, pgoff_t ilx)
+{
+	struct swap_cluster_ra ra;
+
+	swap_cluster_ra_prepare(entry, &ra);
+	return swap_cluster_readahead_win(entry, gfp_mask, mpol, ilx, &ra,
+					 0, 0, NULL);
+}
+
+struct swap_vma_ra {
+	unsigned long start;
+	unsigned long end;
+	int win;
+};
+
 static int swap_vma_ra_win(struct vm_fault *vmf, unsigned long *start,
 			   unsigned long *end)
 {
@@ -1147,35 +1317,69 @@ static int swap_vma_ra_win(struct vm_fault *vmf, unsigned long *start,
 	return win;
 }
 
-/**
- * swap_vma_readahead - swap in pages in hope we need them soon
- * @targ_entry: swap entry of the targeted memory
- * @gfp_mask: memory allocation flags
- * @mpol: NUMA memory allocation policy to be applied
- * @targ_ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
- * @vmf: fault information
- *
- * Returns the struct folio for entry and addr, after queueing swapin.
- *
- * Primitive swap readahead code. We simply read in a few pages whose
- * virtual addresses are around the fault address in the same vma.
- *
- * Caller must hold read mmap_lock if vmf->vma is not NULL.
- *
+static unsigned long swap_vma_ra_orders(struct vm_fault *vmf,
+					unsigned long orders,
+					const struct swap_vma_ra *ra)
+{
+	unsigned long admitted = 0;
+	unsigned long candidates = orders & ~BIT(0);
+	int order;
+
+	if (ra->win <= 1)
+		return 0;
+
+	while (candidates) {
+		unsigned long size;
+		unsigned long start;
+		unsigned long end;
+
+		order = fls_long(candidates) - 1;
+		if (order > MAX_PAGE_ORDER) {
+			candidates &= ~BIT(order);
+			continue;
+		}
+
+		size = PAGE_SIZE << order;
+		start = ALIGN_DOWN(vmf->address, size);
+		end = start + size;
+		if (start >= ra->start && end <= ra->end)
+			admitted |= BIT(order);
+		candidates &= ~BIT(order);
+	}
+
+	return admitted;
+}
+
+/*
+ * Queue swapin for a precomputed VMA readahead window. The window has already
+ * been accounted in vma->swap_readahead_info, so fallback after a failed
+ * zswap-large attempt does not update readahead state a second time. If
+ * @target_folio is already populated, queue only the part of the window outside
+ * [@skip_start, @skip_end) and return @target_folio.
  */
-static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
-		struct mempolicy *mpol, pgoff_t targ_ilx, struct vm_fault *vmf)
+static struct folio *swap_vma_readahead_win(swp_entry_t targ_entry,
+					    gfp_t gfp_mask,
+					    struct mempolicy *mpol,
+					    pgoff_t targ_ilx,
+					    struct vm_fault *vmf,
+					    const struct swap_vma_ra *ra,
+					    unsigned long skip_start,
+					    unsigned long skip_end,
+					    struct folio *target_folio)
 {
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
 	struct folio *folio;
 	pte_t *pte = NULL, pentry;
-	int win;
 	unsigned long start, end, addr;
 	pgoff_t ilx = targ_ilx;
 
-	win = swap_vma_ra_win(vmf, &start, &end);
-	if (win == 1)
+	if (ra->win <= 1)
+		goto skip;
+
+	start = ra->start;
+	end = ra->end;
+	if (target_folio && skip_start <= start && skip_end >= end)
 		goto skip;
 
 	ilx = targ_ilx - PFN_DOWN(vmf->address - start);
@@ -1185,6 +1389,18 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		struct swap_info_struct *si = NULL;
 		softleaf_t entry;
 
+		if (swapin_readahead_skip(addr, skip_start, skip_end)) {
+			unsigned long next = min(skip_end, end);
+
+			if (pte) {
+				pte_unmap(pte);
+				pte = NULL;
+			}
+			ilx += PFN_DOWN(next - addr) - 1;
+			addr = next - PAGE_SIZE;
+			continue;
+		}
+
 		if (!pte++) {
 			pte = pte_offset_map(vmf->pmd, addr);
 			if (!pte)
@@ -1220,6 +1436,9 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	swap_read_unplug(splug);
 	lru_add_drain();
 skip:
+	if (target_folio)
+		return target_folio;
+
 	/* The folio was likely read above, so no need for plugging here */
 	folio = swap_cache_read_folio(targ_entry, gfp_mask, mpol, targ_ilx,
 				      NULL, false);
@@ -1230,25 +1449,78 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
  * swapin_readahead - swap in pages in hope we need them soon
  * @entry: swap entry of this memory
  * @gfp_mask: memory allocation flags
+ * @orders: large folio orders suitable for the faulting entry
  * @vmf: fault information
  *
  * Returns the struct folio for entry and addr, after queueing swapin.
  *
- * It's a main entry function for swap readahead. By the configuration,
- * it will read ahead blocks by cluster-based(ie, physical disk based)
- * or vma-based(ie, virtual address based on faulty address) readahead.
+ * This first computes the normal VMA or cluster readahead window. If the
+ * window fully covers an aligned all-zswap range containing the fault, that
+ * range may be swapped in as one large folio. The remaining window is still
+ * queued through the original order-0 readahead path, skipping the already
+ * covered target range and without updating readahead state a second time.
  */
 struct folio *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
-				struct vm_fault *vmf)
+				unsigned long orders, struct vm_fault *vmf)
 {
 	struct mempolicy *mpol;
 	pgoff_t ilx;
 	struct folio *folio;
+	unsigned long ra_orders;
+	bool vma_ra;
 
 	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
-	folio = swap_use_vma_readahead() ?
-		swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
-		swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
+	vma_ra = swap_use_vma_readahead();
+	if (vma_ra) {
+		struct swap_vma_ra ra = {};
+		unsigned long skip_start = 0;
+		unsigned long skip_end = 0;
+
+		ra.win = swap_vma_ra_win(vmf, &ra.start, &ra.end);
+		ra_orders = swap_vma_ra_orders(vmf, orders, &ra);
+		if (ra_orders) {
+			folio = swapin_zswap_large(entry, gfp_mask, ra_orders,
+						   ra_orders, vmf, mpol, ilx);
+			if (folio) {
+				skip_start = ALIGN_DOWN(vmf->address,
+							folio_size(folio));
+				skip_end = skip_start + folio_size(folio);
+				folio = swap_vma_readahead_win(entry, gfp_mask,
+							       mpol, ilx, vmf,
+							       &ra, skip_start,
+							       skip_end, folio);
+				goto out;
+			}
+		}
+		folio = swap_vma_readahead_win(entry, gfp_mask, mpol, ilx,
+					       vmf, &ra, 0, 0, NULL);
+	} else {
+		struct swap_cluster_ra ra;
+		unsigned long skip_start = 0;
+		unsigned long skip_end = 0;
+
+		swap_cluster_ra_prepare(entry, &ra);
+		ra_orders = swap_cluster_ra_orders(entry, orders, &ra);
+		if (ra_orders) {
+			folio = swapin_zswap_large(entry, gfp_mask, ra_orders,
+						   ra_orders, vmf, mpol, ilx);
+			if (folio) {
+				skip_start = swp_offset(folio->swap);
+				skip_end = skip_start + folio_nr_pages(folio);
+				folio = swap_cluster_readahead_win(entry,
+								   gfp_mask,
+								   mpol, ilx,
+								   &ra,
+								   skip_start,
+								   skip_end,
+								   folio);
+				goto out;
+			}
+		}
+		folio = swap_cluster_readahead_win(entry, gfp_mask, mpol, ilx,
+						   &ra, 0, 0, NULL);
+	}
+out:
 	mpol_cond_put(mpol);
 
 	return folio;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 615d90867111..3b7e7d8ae89d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2452,7 +2452,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			};
 
 			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						&vmf);
+						 0, &vmf);
 		}
 		if (!folio) {
 			swp_tb = swap_table_get(__swap_entry_to_cluster(entry),
-- 
2.34.1


