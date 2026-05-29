Return-Path: <cgroups+bounces-16427-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPnEGIWFGWouxQgAu9opvQ
	(envelope-from <cgroups+bounces-16427-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:24:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF7C60238D
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29DC930693C2
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 12:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3563A3DF00B;
	Fri, 29 May 2026 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bg/vJ0vD"
X-Original-To: cgroups@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964623DBD53;
	Fri, 29 May 2026 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057186; cv=none; b=hMexri45wr8wHD5sZZ/BYji4OyaSSFvIJwuvyIVVxBvhrqC7UdnVCeMoYQxI71j1XEa8LiUv1S9CJ6f33dyinvWAmWLI1b+82dkq50T5XNT7id8TK8LAJ7NQns9Jzjk2J2QdfIraXJ/eQIYDztaDXUylgYdneJKt8XMFUSgTVhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057186; c=relaxed/simple;
	bh=XIjrOmuzKDqZwfu/U4RkH6jnfzV1A1isv3f+BqgqDpg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=EEqIo00Pqpfvr7iorGtimbdwrCoiBOKKkfwWR56dlCHxH8qt3D3X8+fP0nlxir01yKSlY+YqZtyEVN6ANHqSnghgkxHmtaTcZbTtnqc2MG/g/DJqF11SN3r3i4sa3YQQNlCBY/2B1kojjL/vV9Sxs/QjUxdufM67uoKuAvFZtv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bg/vJ0vD; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780057181; bh=LLCdcZM28LSqnhskCBNjIY/IATM4Pd8LdF/tlghQRJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bg/vJ0vD8Wq0E8xQ9lzRiF2CcmID31e+p9BP697CZf008EDAhLiqgi/G+SyfO1EhC
	 jpiezYKBUAoDoo7KWwZBFkvdR7QdfLPc/tNIhgLI8JXSAii3DfHe/TekIyu78dmIF/
	 nbi5hAtlAIzswGMAolgpOS3lTeuahX2KL+SqvQHA=
Received: from node68.. ([166.111.236.25])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 4DC10017; Fri, 29 May 2026 20:19:28 +0800
X-QQ-mid: xmsmtpt1780057178t8d71qf7g
Message-ID: <tencent_913470853E9B289ECF0379248E24DFB4590A@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgFKeqSv1IeByIiaUnNl54ksdfcW2cSvrmU+UkYbeDznU9ZeKWcW
	 Fa+snv+S5Hh8iRLGeTdFPQy6v/uDbbAxElaP+GdWL1jv1GUoon3bMyomyKlDb2joL4deC9UcFUdh
	 jrdkn+9GB2y7uy8jMSO4LCWrJYqQGdJDfr8aB6b72wsxjDj7tKka3KOqSo6BWX9s7hqEhBZVAPgy
	 1pw3i5IAr3kIYT9bV9ab8m6+4IgWGGl1WWDCWrxWSf3ubJGR0Z+dMQNcK7VU80LdrMqVwQZNklUi
	 X4gLiztR5flLNtzfpqa6lOakdPqCcC7xpvSEfL7oDo4eWtiX1Eg/RdDAwdXEHKwlFn2SCPCI0N97
	 sg4GjU2G5ub0CsBjw1/zGN1nSuwFoI0ghjrq59bSLAeP3vDn5PlvT0Q1sfI+TP8r22UhUpOLvA18
	 K8UF5A5fbdIxWom4TQ6Js1pxoEQ1/lLgQ2J4j9Lfqqnk6ifMuJ6zu4x8OEHsg54zPX2m9Eiy+fVD
	 nh/AXqAxQbyhoMa0DMQfWw3ti7N2vi9FQbsobRalnefxIJ+Dhi8DUaSnZLb1lKxql47IeTggC27y
	 wu92J78jkOkEWMKCB1M7KPEPoEJ6YGNJbpp7UrdVdCtx4bbjBC03uLD9zVNVWpOzEei/UT3ygdHx
	 U5HMqjD1WbgIagPg6JFuenf62rVAoZA21QX3Dvs+g21NLdmVZNiEIgxX4pgW/Cb+FNqB3gG8Kkgj
	 e8VTkq7zSTolqLjFHp1IYBVnwurn9rABUxFkkPkSsu6kw2ep9ZrBXdlwzbnYEKX8hIsars4l9K6M
	 3kPCF6HRnRI32pJ2S39kD8tX6AxN+KwCuOhnfTI2fxXZh8l9TjdjEGlLlh91KfsRILyQfq3ks0Fx
	 brQNXSIztgvz7hIwZ55iTToNhhx+q6tB0LFUeiCaDUl0RNTaazo3ZCrVvI9AT2WGNOq+vHXYvEZQ
	 tUXcB3RfkPaFY8/jt4xGm0ItYEiEj/v7tJg7OCHN3+doHSHZ6UPsYHJaAVXMK0A5PBo+aYufpYAH
	 72vYPw5VAu82yPkzMmsZMq4Z5kYCXYxkvBQ66bPrfog+4FWHHNCUP+McfAgLuzn4OXouHWnQ==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
Subject: [RFC PATCH v2 6/9] mm: provide anon locality evidence for zswap large swapin
Date: Fri, 29 May 2026 12:19:25 +0000
X-OQ-MSGID: <20260529121928.4115683-6-fujunjie1@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16427-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qq.com:email,qq.com:mid,qq.com:dkim]
X-Rspamd-Queue-Id: 7CF7C60238D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The common zswap large-swapin policy needs locality evidence from
callers before it can admit a large folio. For anonymous faults, provide
that evidence from existing VMA hints and from the PTE young state left
by earlier zswap-backed large swapins.

Keep non-faulting PTEs old when mapping a speculative all-zswap large
folio. A later fault can then require a dense young previous range before
admitting another large swapin without adding VMA state.

This also removes the old zswap-enabled guard from the THP swapin
candidate scan. The common swapin path now classifies the backend range
and falls back to order-0 for mixed zswap/disk ranges or races.

Signed-off-by: fujunjie <fujunjie1@qq.com>
---
 mm/memory.c     | 234 +++++++++++++++++++++++++++++++++++++++++++-----
 mm/swap.h       |   6 ++
 mm/swap_state.c |  15 ++++
 3 files changed, 235 insertions(+), 20 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 92a82008d583..7bbb89632000 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4556,6 +4556,35 @@ static void memcg1_swapin_retry_folio(struct folio *folio,
 	folio_unlock(folio);
 }
 
+static void set_swapin_ptes(struct vm_area_struct *vma,
+			    unsigned long address, pte_t *ptep, pte_t pte,
+			    unsigned int nr_pages, unsigned int fault_pte_idx,
+			    bool fault_only_young)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pte_t old_pte;
+
+	if (!fault_only_young || nr_pages == 1) {
+		set_ptes(mm, address, ptep, pte, nr_pages);
+		return;
+	}
+
+	old_pte = pte_mkold(pte);
+	if (fault_pte_idx)
+		set_ptes(mm, address, ptep, old_pte, fault_pte_idx);
+
+	set_pte_at(mm, address + fault_pte_idx * PAGE_SIZE,
+		   ptep + fault_pte_idx,
+		   pte_mkyoung(pte_advance_pfn(pte, fault_pte_idx)));
+
+	fault_pte_idx++;
+	if (fault_pte_idx < nr_pages)
+		set_ptes(mm, address + fault_pte_idx * PAGE_SIZE,
+			 ptep + fault_pte_idx,
+			 pte_advance_pfn(old_pte, fault_pte_idx),
+			 nr_pages - fault_pte_idx);
+}
+
 static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
 {
 	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
@@ -4628,6 +4657,157 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define SWAPIN_ANON_YOUNG_MIN_PERCENT		75
+#define SWAPIN_ANON_MAX_FAULT_SKIP_SHIFT	2
+
+static bool swapin_anon_prev_young_dense(struct vm_fault *vmf,
+					 unsigned int order)
+{
+	struct vm_area_struct *vma;
+	unsigned int nr_pages;
+	unsigned int threshold;
+	unsigned long size;
+	unsigned long base, prev, addr;
+	struct folio *first = NULL;
+	unsigned int present = 0;
+	unsigned int young = 0;
+	pmd_t *pmd;
+	pmd_t pmdval;
+	spinlock_t *ptl; /* protects the previous PTE range */
+	pte_t *ptep;
+	unsigned int i;
+
+	if (!IS_ENABLED(CONFIG_MMU) || !arch_has_hw_pte_young() || !vmf ||
+	    !vmf->vma || !vmf->pmd || !order || order > MAX_PAGE_ORDER)
+		return false;
+
+	nr_pages = 1U << order;
+	threshold = DIV_ROUND_UP(nr_pages *
+				 SWAPIN_ANON_YOUNG_MIN_PERCENT, 100);
+	size = PAGE_SIZE << order;
+
+	vma = vmf->vma;
+	base = ALIGN_DOWN(vmf->address, size);
+	if (base < size)
+		return false;
+
+	prev = base - size;
+	if (prev < vma->vm_start || prev + size > vma->vm_end)
+		return false;
+
+	pmd = vmf->pmd;
+	if ((prev & PMD_MASK) != (base & PMD_MASK)) {
+		pmd = mm_find_pmd(vma->vm_mm, prev);
+		if (!pmd)
+			return false;
+	}
+
+	pmdval = pmdp_get_lockless(pmd);
+	if (!pmd_present(pmdval) || pmd_leaf(pmdval))
+		return false;
+
+	ptep = pte_offset_map_lock(vma->vm_mm, pmd, prev, &ptl);
+	if (!ptep)
+		return false;
+
+	for (i = 0, addr = prev; i < nr_pages; i++, addr += PAGE_SIZE) {
+		struct folio *folio;
+		pte_t pte = ptep_get(ptep + i);
+
+		if (!pte_present(pte))
+			break;
+
+		folio = vm_normal_folio(vma, addr, pte);
+		if (!folio || folio_order(folio) != order)
+			break;
+		if (!first)
+			first = folio;
+		else if (folio != first)
+			break;
+
+		present++;
+		if (pte_young(pte))
+			young++;
+	}
+
+	pte_unmap_unlock(ptep, ptl);
+	if (present != nr_pages)
+		return false;
+
+	return young >= threshold;
+}
+
+static bool swapin_anon_accessed_neighbour(struct vm_fault *vmf,
+					   unsigned int order)
+{
+	unsigned long size;
+	unsigned long base;
+	unsigned long fault_idx;
+	unsigned long max_skip;
+
+	if (!vmf || !vmf->vma || !order || order > MAX_PAGE_ORDER)
+		return false;
+
+	size = PAGE_SIZE << order;
+	base = ALIGN_DOWN(vmf->address, size);
+
+	/*
+	 * Without a sequential hint, require prior young-density evidence and
+	 * only allow faults near the start of the candidate range.
+	 */
+	fault_idx = (vmf->address - base) >> PAGE_SHIFT;
+	max_skip = (1UL << order) >> SWAPIN_ANON_MAX_FAULT_SKIP_SHIFT;
+	if (fault_idx > max_skip)
+		return false;
+
+	return swapin_anon_prev_young_dense(vmf, order);
+}
+
+static bool swapin_anon_fault_starts_range(struct vm_fault *vmf,
+					   unsigned int order)
+{
+	struct vm_area_struct *vma;
+	unsigned long size;
+	unsigned long base;
+	unsigned long first;
+
+	if (!vmf || !vmf->vma || !order || order > MAX_PAGE_ORDER)
+		return false;
+
+	vma = vmf->vma;
+	size = PAGE_SIZE << order;
+	base = ALIGN_DOWN(vmf->address, size);
+	first = ALIGN(vma->vm_start, size);
+
+	return base == first && vmf->address == base &&
+	       base + size <= vma->vm_end;
+}
+
+static unsigned long swapin_anon_locality_orders(struct vm_fault *vmf,
+						 unsigned long orders)
+{
+	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
+	unsigned long locality_orders = 0;
+	unsigned long candidates = orders & ~BIT(0);
+	int order;
+
+	if (vma && (vma->vm_flags & VM_RAND_READ))
+		return 0;
+
+	if (vma && (vma->vm_flags & VM_SEQ_READ))
+		return candidates;
+
+	while (candidates) {
+		order = fls_long(candidates) - 1;
+		if (swapin_anon_fault_starts_range(vmf, order) ||
+		    swapin_anon_accessed_neighbour(vmf, order))
+			locality_orders |= BIT(order);
+		candidates &= ~BIT(order);
+	}
+
+	return locality_orders;
+}
+
 /*
  * Check if the PTEs within a range are contiguous swap entries.
  */
@@ -4644,9 +4824,9 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 	if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
 		return false;
 	/*
-	 * swap_read_folio() can't handle the case a large folio is hybridly
-	 * from different backends. And they are likely corner cases. Similar
-	 * things might be added once zswap support large folios.
+	 * swap_read_folio() can't do mixed-backend large folio IO. The common
+	 * synchronous swapin path will recheck backend state and fall back to
+	 * order-0 if a zswap/disk race makes the range mixed.
 	 */
 	if (swap_pte_batch(ptep, nr_pages, pte) != nr_pages)
 		return false;
@@ -4693,14 +4873,6 @@ static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
 	if (unlikely(userfaultfd_armed(vma)))
 		return 0;
 
-	/*
-	 * A large swapped out folio could be partially or fully in zswap. We
-	 * lack handling for such cases, so fallback to swapping in order-0
-	 * folio.
-	 */
-	if (!zswap_never_enabled())
-		return 0;
-
 	entry = softleaf_from_pte(vmf->orig_pte);
 	/*
 	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
@@ -4708,10 +4880,13 @@ static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
 	 */
 	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
 					  BIT(PMD_ORDER) - 1);
+	if (!orders)
+		return 0;
 	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
+	if (!orders)
+		return 0;
 	orders = thp_swap_suitable_orders(swp_offset(entry),
 					  vmf->address, orders);
-
 	if (!orders)
 		return 0;
 
@@ -4741,6 +4916,12 @@ static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
 {
 	return 0;
 }
+
+static unsigned long swapin_anon_locality_orders(struct vm_fault *vmf,
+						 unsigned long orders)
+{
+	return 0;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /* Sanity check that a folio is fully exclusive */
@@ -4777,6 +4958,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	unsigned long page_idx;
 	unsigned long address;
 	pte_t *ptep;
+	bool fault_only_young = false;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -4845,13 +5027,22 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (folio)
 		swap_update_readahead(folio, vma, vmf->address);
 	if (!folio) {
-		/* Swapin bypasses readahead for SWP_SYNCHRONOUS_IO devices */
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO))
+		/*
+		 * Swapin bypasses readahead for SWP_SYNCHRONOUS_IO devices.
+		 * The swap device is pinned while checking the flag, matching
+		 * the existing fault path.
+		 */
+		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
+			unsigned long swapin_orders = thp_swapin_suitable_orders(vmf);
+			unsigned long locality_orders =
+				swapin_anon_locality_orders(vmf, swapin_orders);
+
 			folio = swapin_sync(entry, GFP_HIGHUSER_MOVABLE,
-					    thp_swapin_suitable_orders(vmf) | BIT(0),
-					    0, vmf, NULL, 0);
-		else
+					    swapin_orders | BIT(0),
+					    locality_orders, vmf, NULL, 0);
+		} else {
 			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf);
+		}
 
 		if (IS_ERR_OR_NULL(folio)) {
 			/*
@@ -5110,9 +5301,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	VM_BUG_ON(!folio_test_anon(folio) ||
 			(pte_write(pte) && !PageAnonExclusive(page)));
-	set_ptes(vma->vm_mm, address, ptep, pte, nr_pages);
-	arch_do_swap_page_nr(vma->vm_mm, vma, address,
-			pte, pte, nr_pages);
+	if (folio == swapcache && nr_pages == folio_nr_pages(folio) &&
+	    arch_has_hw_pte_young())
+		fault_only_young = swapin_fault_only_young(folio);
+	set_swapin_ptes(vma, address, ptep, pte, nr_pages, page_idx,
+			fault_only_young);
+	arch_do_swap_page_nr(vma->vm_mm, vma, address, pte, pte, nr_pages);
 
 	/*
 	 * Remove the swap entry and conditionally try to free up the swapcache.
diff --git a/mm/swap.h b/mm/swap.h
index dd35a310d06d..5d1c81ab49b9 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -327,6 +327,7 @@ struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
 struct folio *swapin_sync(swp_entry_t entry, gfp_t flag, unsigned long orders,
 			  unsigned long locality_orders, struct vm_fault *vmf,
 			  struct mempolicy *mpol, pgoff_t ilx);
+bool swapin_fault_only_young(struct folio *folio);
 void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
 			   unsigned long addr);
 
@@ -430,6 +431,11 @@ static inline void swap_update_readahead(struct folio *folio,
 {
 }
 
+static inline bool swapin_fault_only_young(struct folio *folio)
+{
+	return false;
+}
+
 static inline int swap_writeout(struct folio *folio,
 		struct swap_iocb **swap_plug)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 5a4ca289009a..80dff6a1ee65 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -747,6 +747,21 @@ static bool zswap_needs_order0_retry(struct folio *folio)
 	       ZSWAP_RANGE_MIXED;
 }
 
+/*
+ * A speculative large swapin may install PTEs for pages that did not fault.
+ * Keep those non-faulting PTEs old so a later anon fault can report
+ * PTE-young density as caller-provided locality evidence without storing
+ * state in the VMA.
+ */
+bool swapin_fault_only_young(struct folio *folio)
+{
+	if (!folio_test_large(folio) || !folio_test_swapcache(folio))
+		return false;
+
+	return zswap_probe_range(folio->swap, folio_nr_pages(folio)) ==
+	       ZSWAP_RANGE_ALL_ZSWAP;
+}
+
 /*
  * If we are the only user, then try to free up the swap cache.
  *
-- 
2.34.1


