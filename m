Return-Path: <cgroups+bounces-3199-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE1E90AE4A
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 14:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22EDB22688
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB07198E72;
	Mon, 17 Jun 2024 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLeIuv7A"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF591198837;
	Mon, 17 Jun 2024 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628825; cv=none; b=memPgCJJGvNzkkO8rVnS3+Dkokk4DrnNJtMO9qglo8Ue/T7PmQJeBiKsoBIOehOj0y3olbkMTS+yHVjQcTxVjb/w2sGjl3DbOD6UM51djGcuQ7LpmDI8NzBDs4vCH1HMXb5WYmfuFIocOU/s2Z9BV09Fo1E+rBnK4qxs0BypGZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628825; c=relaxed/simple;
	bh=+MAcawKc/gjbuplAmJtmejdD/mb4Cb1IAw29OxD5KOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuCMfVxvSmi1K88gsuKmFZZHvnjJ8gBryI390Fmch0nWXq6R6d8nkaxrE8d1ivq4bwiyJecxnm+w8DqP07QHnBCCRGOhCBxy108dpOz/YSz6HVo37SZr5J8wALDXqzdQlB56+7sNdri8E8CSLjx/5CoM6VEE7zOnG6zaQ8QB9ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLeIuv7A; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718628824; x=1750164824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+MAcawKc/gjbuplAmJtmejdD/mb4Cb1IAw29OxD5KOo=;
  b=gLeIuv7AizMl72KY6KUEOwRZM6veRUAb8bGyN8OB8W9acp3Jq9YlUsL5
   FEqmhHvKUDPa3d5KAhG2oXNat0ByYCcGtHNHQeMlM7M8ZbZ4lEx1x1EHU
   VK4YLGemNGD8W7N2QKkChdp3FOweskNHz9vVhuM3EmWQvqd6YLCyc/32H
   4SQ/02jSZHXj+k2SRF2azKm7R4RLC6PDUAcgfxkVvCz8qkoyj4Wkm2YT5
   p3k3dbgNptZ/q5l4JMQjOZLXHrLsEFrHA6HCQW5MTCB8s8LOJZg8GEVPE
   gBSujWFJ3zXVt4LQh4GP5dcdj1aVU8Hsf0u68T2qVJSvEsNJ4IH5qmRJq
   A==;
X-CSE-ConnectionGUID: TjN8HjdBTRmx7Vy+vWT8GA==
X-CSE-MsgGUID: nti3+ngRQteq4/l+A3FnFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15570894"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15570894"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:42 -0700
X-CSE-ConnectionGUID: kwimhzsoRe+VlMpv2PkYew==
X-CSE-MsgGUID: JBYTbJVkReax+KpwipllCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="72387532"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:41 -0700
From: "Huang, Haitao" <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	chenridong@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	x86@kernel.org,
	cgroups@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	sohil.mehta@intel.com,
	tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	chrisyan@microsoft.com
Subject: [PATCH v15 07/14] x86/sgx: Abstract tracking reclaimable pages in LRU
Date: Mon, 17 Jun 2024 05:53:14 -0700
Message-ID: <20240617125321.36658-8-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617125321.36658-1-haitao.huang@linux.intel.com>
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristen Carlson Accardi <kristen@linux.intel.com>

The SGX driver tracks reclaimable EPC pages by adding a newly allocated
page into the global LRU list in sgx_mark_page_reclaimable(), and doing
the opposite in sgx_unmark_page_reclaimable().

To support SGX EPC cgroup, the SGX driver will need to maintain an LRU
list for each cgroup, and each newly allocated EPC page will need to be
added to the LRU of associated cgroup, not always the global LRU list.

When sgx_mark_page_reclaimable() is called, the cgroup that the newly
allocated EPC page belongs to is already known, i.e., it has been set to
the 'struct sgx_epc_page'.

Add a helper, sgx_epc_page_lru(), to return the LRU that the EPC page
should be added to for the given EPC page.  Currently it just returns
the global LRU. Change sgx_{mark|unmark}_page_reclaimable() to use the
helper function to get the LRU from the EPC page instead of referring to
the global LRU directly.

This allows EPC page being able to be tracked in "per-cgroup" LRU when
that becomes ready.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V13:
- Revise commit log (Kai)
- Rename sgx_lru_list() to sgx_epc_page_lru()

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/main.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 8ad6040953e6..1eadf4c39678 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -32,6 +32,11 @@ static DEFINE_XARRAY(sgx_epc_address_space);
  */
 static struct sgx_epc_lru_list sgx_global_lru;
 
+static inline struct sgx_epc_lru_list *sgx_epc_page_lru(struct sgx_epc_page *epc_page)
+{
+	return &sgx_global_lru;
+}
+
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
 /* Nodes with one or more EPC sections. */
@@ -500,25 +505,24 @@ static struct sgx_epc_page *__sgx_alloc_epc_page(void)
 }
 
 /**
- * sgx_mark_page_reclaimable() - Mark a page as reclaimable
+ * sgx_mark_page_reclaimable() - Mark a page as reclaimable and track it in a LRU.
  * @page:	EPC page
- *
- * Mark a page as reclaimable and add it to the active page list. Pages
- * are automatically removed from the active list when freed.
  */
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
 {
-	spin_lock(&sgx_global_lru.lock);
+	struct sgx_epc_lru_list *lru = sgx_epc_page_lru(page);
+
+	spin_lock(&lru->lock);
 	page->flags |= SGX_EPC_PAGE_RECLAIMER_TRACKED;
-	list_add_tail(&page->list, &sgx_global_lru.reclaimable);
-	spin_unlock(&sgx_global_lru.lock);
+	list_add_tail(&page->list, &lru->reclaimable);
+	spin_unlock(&lru->lock);
 }
 
 /**
- * sgx_unmark_page_reclaimable() - Remove a page from the reclaim list
+ * sgx_unmark_page_reclaimable() - Remove a page from its tracking LRU
  * @page:	EPC page
  *
- * Clear the reclaimable flag and remove the page from the active page list.
+ * Clear the reclaimable flag if set and remove the page from its LRU.
  *
  * Return:
  *   0 on success,
@@ -526,18 +530,20 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
  */
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
 {
-	spin_lock(&sgx_global_lru.lock);
+	struct sgx_epc_lru_list *lru = sgx_epc_page_lru(page);
+
+	spin_lock(&lru->lock);
 	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
 		/* The page is being reclaimed. */
 		if (list_empty(&page->list)) {
-			spin_unlock(&sgx_global_lru.lock);
+			spin_unlock(&lru->lock);
 			return -EBUSY;
 		}
 
 		list_del(&page->list);
 		page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 	}
-	spin_unlock(&sgx_global_lru.lock);
+	spin_unlock(&lru->lock);
 
 	return 0;
 }
-- 
2.43.0


