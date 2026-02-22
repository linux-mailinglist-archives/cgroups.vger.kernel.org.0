Return-Path: <cgroups+bounces-14116-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHW4C4TDmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14116-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:51:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C0216EA95
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD9FF3024ED6
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F395F2253EC;
	Sun, 22 Feb 2026 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Kbmng73r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446824466C
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750194; cv=none; b=RZw2WvvTilFqCuYrYa1opoaSvraGwz5G904b0VfuYxjROgRfaGd8maauFd447FwTVZPK8lhOAvWlb9KuR+yo7V7MhZ3v+jupmntYKWNsp0JprhW/bjG8+UOyPDchCQ6p6/4jXr/ls3GCMdJsRmtpZydBJueS6BbsrLbDT3b73Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750194; c=relaxed/simple;
	bh=WQREA0eRzyGSJaLiXYZZmNn1uvwWrj7DPFe0mrMY5SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azez8dvTNSvx0+GF2kG/t0gIvsZgVGAHT8EW5qd1iEa5c1oX+JqL7jDymWFVbUiGdfPAbFidVw44HInojfkCQX53fLBPlNwX2BvuDABnIrdF8kXjC1T/eg1X+HyuWY9eROChzySEVbO9nLPNMN61Kvm5SbCzqnM8CNNvWwvnXm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Kbmng73r; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506bcb23a78so29927331cf.3
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750192; x=1772354992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FaS5B9cAZ3FLbrF/E2Ph8lRS4c3BU4jWIQ83JN7l+U=;
        b=Kbmng73rUtRFb7XHU8CYAyeEqInpftmkWqSS9fFZ8GJVpH12yPjwSWp4mDakNbUSuz
         6+SzEtTi2l90tjqNoFgYo3Gs7DfRfZ9y+FKytSbpYFGFonSRxli4mHmBYOe9gGEyG3HR
         sDq+CbCApJOVNVoFcqkPkmh4TEASIZiwG1Y1ORmzbw70AZ6kJx4bWJQjkRTuczdIys8B
         odFdG9xLwygKbxLzR9UCYF01pBgW4P37cHtJaikHOciEBIu/4I7YRYWfMAisq7US22v/
         Pkyh2/Fu3DfSOWIA7HWoA0EKC66RAR6zQkrXaRRbF0fMy45XTBretkfBTjMq2lssSvXv
         rjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750192; x=1772354992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0FaS5B9cAZ3FLbrF/E2Ph8lRS4c3BU4jWIQ83JN7l+U=;
        b=aQWdsqqbsf1z3dzUi7q8E1DG+BNjeH0AmvfkxAVUzHEI7BxNN6Rg1UhaHPmw5JCRbe
         W3bsznE9shjU8gSziVqjd6itKb4xLNoV6TlSmgO5sJ5+tIeL3E+A/b+8fiZkfTAg1pGd
         XiApPrRcsmx4aS20D6yyj+xUb73ndTMW7bSe1lL9wEOqp8ZsumVa5/X5/gtwOrGzskkc
         usADQqgjClqwn/nxW7cOmAQOeq/pSFAektwhwrnUA9mgx8fHwQrhUi6tOrWk33IbKpS/
         2kYWVKCPGPjeSE62AoSdJ4sH3XpL+2CAxqMBI6cqycJke9tQWLGMDTiW2hzh5koTAndn
         eDsA==
X-Forwarded-Encrypted: i=1; AJvYcCXPu7I3dk+o+C7TibRSdpKKkYleBl/6HEb9Jq5nQvlOjUjWjcvclybinpAlO6hFl7l23ndtMB3N@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5EWFa015hMasKdSgKlwYYDpG0KNHmeTPp0rOy/Gz2UDVTxs6P
	uNDPoQAxCIgef4oQEIv1N9yn1eRARZ4OC4clx6eLUFoAHKs6+gqd6Xw8LjQZapGu/Ek=
X-Gm-Gg: AZuq6aKoryci8g/YD2OVQtjE8sCT2gtsUq8TcRK8IJOyVomdqaxIZdnVpUiEzLo1XGp
	VrhJicv06f4UsUjjBWG4FIFw3YsIY9b5J2wWria8jE60VHD+nBARGf5kPmXibbT8imAJtq1VCdH
	3v8ATQe2/WSipc/ztyZTSmQRs8IiJc8AbX0reQHHFt8R4V811t8yGLY4vRQM3kAGDLH85m5/JaF
	zu2leBf//W8GQ6Ksg0b8eCfyxuHM7R5cjIF04klhf3hNAwc5kwFQyNYbgtVZNcmIjyIR6XjhdmH
	4DUi/2eGo7FZK9Hn1uP6L3ZTP8nqQTKdJPhVhXX0BxIDBZzAXcVkow6y7iFt0X+hx9wj5rLLQYo
	yRVcH1D2t0ovvsqYCgYuA9ydFtemWDthACA4kDuzeiKB7ZxbUY/qmO0tc5B64S7g6967sgn94L3
	BQfRDEQvINWwY0lIUMzMBNwJ8Kx4lLB+4w+kx7u/VcOB4vN9p+rXuON96K3KI1aNp+zn/Da48tx
	5kSsjBcube2Pm8=
X-Received: by 2002:a05:622a:19a1:b0:4ff:c04c:3d75 with SMTP id d75a77b69052e-5070bc4b9ddmr74426531cf.43.1771750191585;
        Sun, 22 Feb 2026 00:49:51 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:51 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 15/27] mm/mprotect: NP_OPS_PROTECT_WRITE - gate PTE/PMD write-upgrades
Date: Sun, 22 Feb 2026 03:48:30 -0500
Message-ID: <20260222084842.1824063-16-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14116-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gourry.net:mid,gourry.net:dkim,gourry.net:email]
X-Rspamd-Queue-Id: C0C0216EA95
X-Rspamd-Action: no action

Services that intercept write faults (e.g., for promotion tracking)
need PTEs to stay read-only. This requires preventing mprotect
from silently upgrade the PTE, bypassing the service's handle_fault
callback.

Add NP_OPS_PROTECT_WRITE and folio_managed_wrprotect().

In change_pte_range() and change_huge_pmd(), suppress PTE write-upgrade
when MM_CP_TRY_CHANGE_WRITABLE is sees the folio is write-protected.

In handle_pte_fault() and do_huge_pmd_wp_page(), dispatch to the node's
ops->handle_fault callback when set, allowing the service to handle write
faults with promotion or other custom logic.

NP_OPS_MEMPOLICY is incompatible with NP_OPS_PROTECT_WRITE to avoid the
footgun of binding a writable VMA to a write-protected node.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/node.c          |  4 ++
 include/linux/node_private.h | 22 ++++++++
 mm/huge_memory.c             | 17 ++++++-
 mm/internal.h                | 99 ++++++++++++++++++++++++++++++++++++
 mm/memory.c                  | 15 ++++++
 mm/migrate.c                 | 14 +----
 mm/mprotect.c                |  4 +-
 7 files changed, 159 insertions(+), 16 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index c08b5a948779..a4955b9b5b93 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -957,6 +957,10 @@ int node_private_set_ops(int nid, const struct node_private_ops *ops)
 	    !(ops->flags & NP_OPS_MIGRATION))
 		return -EINVAL;
 
+	if ((ops->flags & NP_OPS_MEMPOLICY) &&
+	    (ops->flags & NP_OPS_PROTECT_WRITE))
+		return -EINVAL;
+
 	mutex_lock(&node_private_lock);
 	np = rcu_dereference_protected(NODE_DATA(nid)->node_private,
 				       lockdep_is_held(&node_private_lock));
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index e254e36056cd..27d6e5d84e61 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -70,6 +70,24 @@ struct vm_fault;
  *     PFN-based metadata (compression tables, device page tables, DMA
  *     mappings, etc.) before any access through the page tables.
  *
+ * @handle_fault: Handle fault on folio on this private node.
+ *   [folio-referenced callback, PTL held on entry]
+ *
+ *   Called from handle_pte_fault() (PTE level) or do_huge_pmd_wp_page()
+ *   (PMD level) after lock acquisition and entry verification.
+ *   @folio is the faulting folio, @level indicates the page table level.
+ *
+ *   For PGTABLE_LEVEL_PTE: vmf->pte is mapped and vmf->ptl is the
+ *   PTE lock.  Release via pte_unmap_unlock(vmf->pte, vmf->ptl).
+ *
+ *   For PGTABLE_LEVEL_PMD: vmf->pte is NULL and vmf->ptl is the
+ *   PMD lock.  Release via spin_unlock(vmf->ptl).
+ *
+ *   The callback MUST release PTL on ALL paths.
+ *   The caller will NOT touch the page table entry after this returns.
+ *
+ *   Returns: vm_fault_t result (0, VM_FAULT_RETRY, etc.)
+ *
  * @flags: Operation exclusion flags (NP_OPS_* constants).
  *
  */
@@ -81,6 +99,8 @@ struct node_private_ops {
 				  enum migrate_reason reason,
 				  unsigned int *nr_succeeded);
 	void (*folio_migrate)(struct folio *src, struct folio *dst);
+	vm_fault_t (*handle_fault)(struct folio *folio, struct vm_fault *vmf,
+				   enum pgtable_level level);
 	unsigned long flags;
 };
 
@@ -90,6 +110,8 @@ struct node_private_ops {
 #define NP_OPS_MEMPOLICY		BIT(1)
 /* Node participates as a demotion target in memory-tiers */
 #define NP_OPS_DEMOTION			BIT(2)
+/* Prevent mprotect/NUMA from upgrading PTEs to writable on this node */
+#define NP_OPS_PROTECT_WRITE		BIT(3)
 
 /**
  * struct node_private - Per-node container for N_MEMORY_PRIVATE nodes
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2ecae494291a..d9ba6593244d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2063,12 +2063,14 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	pmd_t orig_pmd = vmf->orig_pmd;
+	vm_fault_t ret;
+
 
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
 	VM_BUG_ON_VMA(!vma->anon_vma, vma);
 
 	if (is_huge_zero_pmd(orig_pmd)) {
-		vm_fault_t ret = do_huge_zero_wp_pmd(vmf);
+		ret = do_huge_zero_wp_pmd(vmf);
 
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
@@ -2088,6 +2090,13 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	folio = page_folio(page);
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 
+	/* Private-managed write-protect: let the service handle the fault */
+	if (unlikely(folio_is_private_managed(folio))) {
+		if (folio_managed_handle_fault(folio, vmf,
+					      PGTABLE_LEVEL_PMD, &ret))
+			return ret;
+	}
+
 	/* Early check when only holding the PT lock. */
 	if (PageAnonExclusive(page))
 		goto reuse;
@@ -2633,7 +2642,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 	/* See change_pte_range(). */
 	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pmd_write(entry) &&
-	    can_change_pmd_writable(vma, addr, entry))
+	    can_change_pmd_writable(vma, addr, entry) &&
+	    !folio_managed_wrprotect(pmd_folio(entry)))
 		entry = pmd_mkwrite(entry, vma);
 
 	ret = HPAGE_PMD_NR;
@@ -4943,6 +4953,9 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	if (folio_test_dirty(folio) && softleaf_is_migration_dirty(entry))
 		pmde = pmd_mkdirty(pmde);
 
+	if (folio_managed_wrprotect(folio))
+		pmde = pmd_wrprotect(pmde);
+
 	if (folio_is_device_private(folio)) {
 		swp_entry_t entry;
 
diff --git a/mm/internal.h b/mm/internal.h
index 5950e20d4023..ae4ff86e8dc6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -11,6 +11,7 @@
 #include <linux/khugepaged.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
+#include <linux/node_private.h>
 #include <linux/pagemap.h>
 #include <linux/pagewalk.h>
 #include <linux/rmap.h>
@@ -18,6 +19,7 @@
 #include <linux/leafops.h>
 #include <linux/swap_cgroup.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/node_private.h>
 
 /* Internal core VMA manipulation functions. */
 #include "vma.h"
@@ -1449,6 +1451,103 @@ static inline bool folio_managed_on_free(struct folio *folio)
 	return false;
 }
 
+/*
+ * folio_managed_handle_fault - Dispatch fault on managed-memory folio
+ * @folio: the faulting folio (must not be NULL)
+ * @vmf: the vm_fault descriptor (PTL held: vmf->ptl locked)
+ * @level: page table level (PGTABLE_LEVEL_PTE or PGTABLE_LEVEL_PMD)
+ * @ret: output fault result if handled
+ *
+ * Called with PTL held.  If a handle_fault callback exists, it is invoked
+ * with PTL still held.  The callback is responsible for releasing PTL on
+ * all paths.
+ *
+ * Returns true if the service handled the fault (PTL released by callback,
+ * caller returns *ret).  Returns false if no handler exists (PTL still held,
+ * caller continues with normal fault handling).
+ */
+static inline bool folio_managed_handle_fault(struct folio *folio,
+					      struct vm_fault *vmf,
+					      enum pgtable_level level,
+					      vm_fault_t *ret)
+{
+	/* Zone device pages use swap entries; handled in do_swap_page */
+	if (folio_is_zone_device(folio))
+		return false;
+
+	if (folio_is_private_node(folio)) {
+		const struct node_private_ops *ops =
+			folio_node_private_ops(folio);
+
+		if (ops && ops->handle_fault) {
+			*ret = ops->handle_fault(folio, vmf, level);
+			return true;
+		}
+	}
+	return false;
+}
+
+/**
+ * folio_managed_wrprotect - Should this folio's mappings stay write-protected?
+ * @folio: the folio to check
+ *
+ * Returns true if the folio is on a private node with NP_OPS_PROTECT_WRITE,
+ * meaning page table entries (PTE or PMD) should not be made writable.
+ * Write faults are intercepted by the service's handle_fault callback
+ * to promote the folio to DRAM.
+ *
+ * Used by:
+ *   - change_pte_range() / change_huge_pmd(): prevent mprotect write-upgrade
+ *   - remove_migration_pte() / remove_migration_pmd(): strip write after migration
+ *   - do_huge_pmd_wp_page(): dispatch to fault handler instead of reuse
+ */
+static inline bool folio_managed_wrprotect(struct folio *folio)
+{
+	return unlikely(folio_is_private_node(folio) &&
+			folio_private_flags(folio, NP_OPS_PROTECT_WRITE));
+}
+
+/**
+ * folio_managed_fixup_migration_pte - Fixup PTE after migration for
+ *                                     managed memory pages.
+ * @new: the destination page
+ * @pte: the PTE being installed (normal PTE built by caller)
+ * @old_pte: the original PTE (before migration, for swap entry flags)
+ * @vma: the VMA
+ *
+ * For MEMORY_DEVICE_PRIVATE pages: replaces the PTE with a device-private
+ * swap entry, preserving soft_dirty and uffd_wp from old_pte.
+ *
+ * For N_MEMORY_PRIVATE pages with NP_OPS_PROTECT_WRITE: strips the write
+ * bit so the next write triggers the fault handler for promotion.
+ *
+ * For normal pages: returns pte unmodified.
+ */
+static inline pte_t folio_managed_fixup_migration_pte(struct page *new,
+						      pte_t pte,
+						      pte_t old_pte,
+						      struct vm_area_struct *vma)
+{
+	if (unlikely(is_device_private_page(new))) {
+		softleaf_t entry;
+
+		if (pte_write(pte))
+			entry = make_writable_device_private_entry(
+						page_to_pfn(new));
+		else
+			entry = make_readable_device_private_entry(
+						page_to_pfn(new));
+		pte = softleaf_to_pte(entry);
+		if (pte_swp_soft_dirty(old_pte))
+			pte = pte_swp_mksoft_dirty(pte);
+		if (pte_swp_uffd_wp(old_pte))
+			pte = pte_swp_mkuffd_wp(pte);
+	} else if (folio_managed_wrprotect(page_folio(new))) {
+		pte = pte_wrprotect(pte);
+	}
+	return pte;
+}
+
 /**
  * folio_managed_migrate_notify - Notify service that a folio changed location
  * @src: the old folio (about to be freed)
diff --git a/mm/memory.c b/mm/memory.c
index 2a55edc48a65..0f78988befef 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6079,6 +6079,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * Make it present again, depending on how arch implements
 	 * non-accessible ptes, some can allow access by kernel mode.
 	 */
+	if (unlikely(folio && folio_managed_wrprotect(folio))) {
+		writable = false;
+		ignore_writable = true;
+	}
 	if (folio && folio_test_large(folio))
 		numa_rebuild_large_mapping(vmf, vma, folio, pte, ignore_writable,
 					   pte_write_upgrade);
@@ -6228,6 +6232,7 @@ static void fix_spurious_fault(struct vm_fault *vmf,
  */
 static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
+	struct folio *folio;
 	pte_t entry;
 
 	if (unlikely(pmd_none(*vmf->pmd))) {
@@ -6284,6 +6289,16 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
 		goto unlock;
 	}
+
+	folio = vm_normal_folio(vmf->vma, vmf->address, entry);
+	if (unlikely(folio && folio_is_private_managed(folio))) {
+		vm_fault_t fault_ret;
+
+		if (folio_managed_handle_fault(folio, vmf, PGTABLE_LEVEL_PTE,
+					       &fault_ret))
+			return fault_ret;
+	}
+
 	if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!pte_write(entry))
 			return do_wp_page(vmf);
diff --git a/mm/migrate.c b/mm/migrate.c
index a54d4af04df3..f632e8b03504 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -398,19 +398,7 @@ static bool remove_migration_pte(struct folio *folio,
 		if (folio_test_anon(folio) && !softleaf_is_migration_read(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
 
-		if (unlikely(is_device_private_page(new))) {
-			if (pte_write(pte))
-				entry = make_writable_device_private_entry(
-							page_to_pfn(new));
-			else
-				entry = make_readable_device_private_entry(
-							page_to_pfn(new));
-			pte = softleaf_to_pte(entry);
-			if (pte_swp_soft_dirty(old_pte))
-				pte = pte_swp_mksoft_dirty(pte);
-			if (pte_swp_uffd_wp(old_pte))
-				pte = pte_swp_mkuffd_wp(pte);
-		}
+		pte = folio_managed_fixup_migration_pte(new, pte, old_pte, vma);
 
 #ifdef CONFIG_HUGETLB_PAGE
 		if (folio_test_hugetlb(folio)) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 283889e4f1ce..830be609bc24 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -30,6 +30,7 @@
 #include <linux/mm_inline.h>
 #include <linux/pgtable.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/node_private.h>
 #include <uapi/linux/mman.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
@@ -290,7 +291,8 @@ static long change_pte_range(struct mmu_gather *tlb,
 			 * COW or special handling is required.
 			 */
 			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
-			     !pte_write(ptent))
+			     !pte_write(ptent) &&
+			     !(folio && folio_managed_wrprotect(folio)))
 				set_write_prot_commit_flush_ptes(vma, folio, page,
 				addr, pte, oldpte, ptent, nr_ptes, tlb);
 			else
-- 
2.53.0


