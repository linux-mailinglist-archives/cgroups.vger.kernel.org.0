Return-Path: <cgroups+bounces-16426-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMQkAuuEGWphxQgAu9opvQ
	(envelope-from <cgroups+bounces-16426-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:22:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 731F16022EA
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22A2A3016497
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 12:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC2D352000;
	Fri, 29 May 2026 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="M7hGKodZ"
X-Original-To: cgroups@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868173E00BA;
	Fri, 29 May 2026 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057184; cv=none; b=pybA6eqq9aDNNG3nxM5M6M9eWapPSe4T8cavL3X51X+gno/ZU9SjNHFmIdFptxSd5s2Va0yvw3AXTJLggWzs3X5aXn0yNeb+940gmOuSoCqhLq8LgIddqXsZNUXYemaj2rXvOl/TZT+gTdbbIW+MHvU+M3akU22C/RqdcMQARWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057184; c=relaxed/simple;
	bh=/K2wG6zQbNZTvESItts/W7FuL5ZTh3gamKmzdrcQRVM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HsTrGrLaJhFIOw+ekWO5NVk1EWyTZKM1nR4xBkaDSj6o69WxGGyOrlJ+ndM2LztZTqnIeIIeD+iVVZajW/kWEJyDmULeYuE2DB3iHgHuB5sKbxBRIFiDHGOAyDTrYEEkUT7fWBO9dptZbg7l6nS7Ur/bwC1ppxIUniieMLCq1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=M7hGKodZ; arc=none smtp.client-ip=43.163.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780057175; bh=xut7uEA2LcmM4LrlZiZ/byyWZ1r0WI1YSP1vZ4Egj64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M7hGKodZsqPkt26jzW2LkQsc6xsh6OEcmg69gQ4tmGWLrp4MG/I8hglTllW2D/G6I
	 hJYW3mcxbVoEaTUTBlDhm/wscJUy0CZq0IvnfiT+rCGPsbS8LQLTRJMzJVtFrvPmcH
	 lZ3jATB+1ppOf+u95kPUyGtBEDxKAsX+KNDcWsI0=
Received: from node68.. ([166.111.236.25])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 4DC10017; Fri, 29 May 2026 20:19:28 +0800
X-QQ-mid: xmsmtpt1780057172tac6i9zgh
Message-ID: <tencent_7D186EDC2C9AB9009F9915C1E68F3CF44609@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uNEtWMEQWZx4ULda/MSJcXY82UGEO/ENJfG6dAYdIxvNqNQ/4b5
	 NHjOLjOuuAhYF6UBBQoNqJg19p5N8mZHmqoquhVxAR/rlpLMCNtE3cRRk9CUve/AaHFTV6ZXFrU3
	 yeqjsTFYNmxR+Z6ruyX+zd/HCdJUErIf/ytbubdXHsfjzdlwKC1+WwOAEbqwvha+9rvrow2rlZ2r
	 de35kdqnkk62m40gvQ4nKczdt55wpV+TC4gARpND2xGdEurKCsJ8ux8fsuUiB7GEdHs/C5viEize
	 xmxKjD++Fcux8yvlWSQsA+J8j8RkKagftsl+/BnbAxzpWzPs02kQMxZ+nhwPWT6L62yhP7VIEvbz
	 CkqqQPROLBg6XEQolIGukrp1iM98/n44SQQIILHJ5fjF1SInNRBDHJosBvHLYwqAf6x03xGGvZs4
	 A7QAvojdiXMbu4s6ZgPuGbcFWgt3PZQZvy4LTi03VfZdMn1ON+rEupb+q2TmFCuGGCM3FLnyg8O+
	 BrqU2yUT9YIXuLRkkjnDgpeIGjYYHBcj11odwImoAlTec1N+FbGQYCTAiClAYDu+9W5PMQvC66LE
	 ZbqeY6hgPE25rj8FfQ3JgHzKe9zepNn7LcyjFNIIVz0mfZvkvS6GVDM+KVt6IHDAKV7cGqnC7Hu7
	 8HF0j5RzVfZKlrIV30lt/445qaD/GXFN/Y4Q/gfCHl40YOw8FOSQP53iNY/9c8LZ5YbbFSxsU3UA
	 25Y7kBdc/3U64ORJ+85DGz0ruorUU8kHUl+0iNtnmJMMadp8+U/ivsXcbmbAXawixcUSqoSBKJ6j
	 rJcqAsEFIf63tN7SZdkbIP/DApDQW43Kf6872Ux5u3nWN6ihONCF+JR2GfLg+0CXpX+weqLikMAJ
	 1gQ/QN5S0UITTDoA7uJfSDz6pM2/u0J79ZiI0FKqKF41ZN20jVKFqt7R4WzMgjmBgB+1b4+z9fHJ
	 9NGej8Q9WFPgKD80I4VxxNc0qkjqriULetfmT1SM8IHDf83DRec0I18+2d8zcnDVlTsvTz+0O91n
	 OkhSF9Zac1BqRyUOPDKLT3IJa6Fe6SIy/9nQlOyxcwYknlSNNh
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
Subject: [RFC PATCH v2 3/9] mm/zswap: support fully zswap-backed large folio loads
Date: Fri, 29 May 2026 12:19:22 +0000
X-OQ-MSGID: <20260529121928.4115683-3-fujunjie1@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16426-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,qq.com:mid,qq.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 731F16022EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

zswap currently refuses large swapcache folios. That is correct for mixed
backend ranges, but it also prevents the common swapin path from loading a
range that is still fully backed by zswap.

Teach zswap_load() to fill a locked large swapcache folio by decompressing
each base-page entry into the matching folio offset, then flushing the
folio once. A missing entry after zswap data has been seen is reported as
-EAGAIN so the caller can drop the speculative large folio and retry
order-0.

The large load keeps the zswap entries in place. It is a clean speculative
fill: until the swap slots are freed, zswap remains the backing copy if
reclaim drops the large folio before PTEs are installed.

Signed-off-by: fujunjie <fujunjie1@qq.com>
---
 mm/zswap.c | 105 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 87 insertions(+), 18 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index da5297f7bd69..94ba112a2982 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -15,6 +15,8 @@
 
 #include <linux/module.h>
 #include <linux/cpu.h>
+#include <linux/mm.h>
+#include <linux/huge_mm.h>
 #include <linux/highmem.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -934,7 +936,8 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
-static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
+static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio,
+			     unsigned int page_idx, bool flush_dcache)
 {
 	struct zswap_pool *pool = entry->pool;
 	struct scatterlist input[2]; /* zsmalloc returns an SG list 1-2 entries */
@@ -952,14 +955,15 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 
 		WARN_ON_ONCE(input->length != PAGE_SIZE);
 
-		dst = kmap_local_folio(folio, 0);
+		dst = kmap_local_folio(folio, page_idx * PAGE_SIZE);
 		memcpy_from_sglist(dst, input, 0, PAGE_SIZE);
 		dlen = PAGE_SIZE;
 		kunmap_local(dst);
-		flush_dcache_folio(folio);
+		if (flush_dcache)
+			flush_dcache_folio(folio);
 	} else {
 		sg_init_table(&output, 1);
-		sg_set_folio(&output, folio, PAGE_SIZE, 0);
+		sg_set_folio(&output, folio, PAGE_SIZE, page_idx * PAGE_SIZE);
 		acomp_request_set_params(acomp_ctx->req, input, &output,
 					 entry->length, PAGE_SIZE);
 		ret = crypto_acomp_decompress(acomp_ctx->req);
@@ -1042,7 +1046,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 		goto out;
 	}
 
-	if (!zswap_decompress(entry, folio)) {
+	if (!zswap_decompress(entry, folio, 0, true)) {
 		ret = -EIO;
 		goto out;
 	}
@@ -1615,10 +1619,9 @@ enum zswap_range_state zswap_probe_range(swp_entry_t swp,
  *  NOT marked up-to-date, so that an IO error is emitted (e.g. do_swap_page()
  *  will SIGBUS).
  *
- *  -EINVAL: if the swapped out content was in zswap, but the page belongs
- *  to a large folio, which is not supported by zswap. The folio is unlocked,
- *  but NOT marked up-to-date, so that an IO error is emitted (e.g.
- *  do_swap_page() will SIGBUS).
+ *  -EAGAIN: if the swapped out content belongs to a large folio, but the
+ *  range is mixed or raced with writeback. The folio remains locked so the
+ *  caller can drop the large swapcache folio and retry order-0.
  *
  *  -ENOENT: if the swapped out content was not in zswap. The folio remains
  *  locked on return.
@@ -1626,9 +1629,12 @@ enum zswap_range_state zswap_probe_range(swp_entry_t swp,
 int zswap_load(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
+	unsigned int nr_pages = folio_nr_pages(folio);
+	unsigned int type = swp_type(swp);
 	pgoff_t offset = swp_offset(swp);
-	struct xarray *tree = swap_zswap_tree(swp);
+	struct xarray *tree;
 	struct zswap_entry *entry;
+	unsigned int i;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1636,21 +1642,84 @@ int zswap_load(struct folio *folio)
 	if (zswap_never_enabled())
 		return -ENOENT;
 
-	/*
-	 * Large folios should not be swapped in while zswap is being used, as
-	 * they are not properly handled. Zswap does not properly load large
-	 * folios, and a large folio may only be partially in zswap.
-	 */
-	if (WARN_ON_ONCE(folio_test_large(folio))) {
+	if (folio_test_large(folio)) {
+		struct obj_cgroup *first_objcg = NULL;
+		bool same_objcg = true;
+		bool saw_zswap = false;
+		bool saw_non_zswap = false;
+
+		/*
+		 * The locked large swapcache folio now covers the range and
+		 * conflicts with zswap writeback's order-0 swapcache allocation.
+		 * If the range is mixed or an entry disappears, retry order-0.
+		 */
+		for (i = 0; i < nr_pages; i++) {
+			tree = swap_zswap_tree(swp_entry(type, offset + i));
+			entry = xa_load(tree, offset + i);
+			if (!entry) {
+				if (saw_zswap)
+					return -EAGAIN;
+				saw_non_zswap = true;
+				continue;
+			}
+			if (saw_non_zswap)
+				return -EAGAIN;
+
+			if (!saw_zswap)
+				first_objcg = entry->objcg;
+			else if (entry->objcg != first_objcg)
+				same_objcg = false;
+			saw_zswap = true;
+		}
+		if (!saw_zswap)
+			return -ENOENT;
+
+		for (i = 0; i < nr_pages; i++) {
+			tree = swap_zswap_tree(swp_entry(type, offset + i));
+			entry = xa_load(tree, offset + i);
+			if (!entry)
+				return -EAGAIN;
+
+			if (!zswap_decompress(entry, folio, i, false)) {
+				folio_unlock(folio);
+				return -EIO;
+			}
+		}
+
+		flush_dcache_folio(folio);
+		/*
+		 * Keep zswap entries until swap slots are freed. This is a clean
+		 * speculative fill; zswap remains the backing copy if reclaim
+		 * drops the large folio before PTEs are installed.
+		 */
+		folio_mark_uptodate(folio);
+		count_vm_events(ZSWPIN, nr_pages);
+		count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
+
+		if (same_objcg) {
+			if (first_objcg)
+				count_objcg_events(first_objcg, ZSWPIN, nr_pages);
+		} else {
+			for (i = 0; i < nr_pages; i++) {
+				tree = swap_zswap_tree(swp_entry(type, offset + i));
+				entry = xa_load(tree, offset + i);
+				if (WARN_ON_ONCE(!entry))
+					continue;
+				if (entry->objcg)
+					count_objcg_events(entry->objcg, ZSWPIN, 1);
+			}
+		}
+
 		folio_unlock(folio);
-		return -EINVAL;
+		return 0;
 	}
 
+	tree = swap_zswap_tree(swp);
 	entry = xa_load(tree, offset);
 	if (!entry)
 		return -ENOENT;
 
-	if (!zswap_decompress(entry, folio)) {
+	if (!zswap_decompress(entry, folio, 0, true)) {
 		folio_unlock(folio);
 		return -EIO;
 	}
-- 
2.34.1


