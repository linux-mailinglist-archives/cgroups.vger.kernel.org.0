Return-Path: <cgroups+bounces-2501-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7A38A618D
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 05:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13EF6B220B3
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 03:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7483B2A6;
	Tue, 16 Apr 2024 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fe9rsNBd"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490B42E403;
	Tue, 16 Apr 2024 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237618; cv=none; b=ThnFVBGrz5Xs2IUG4FCnCn/icibeUQRb1Db43PLfqkZRlVZzAlIZBvjP3xdGxDs7FHQ4WH0YCT05qHqvUvUKMDdizeYezY1JFRJbqNU7vwZUCY7yfserfwqU0yzGuhDc38njd6Vz+Jiruh/YripFFFJzEPsh5h9pXgg25ZqcytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237618; c=relaxed/simple;
	bh=9du0qDfZTGbkbG0LY7QYxW2+6choZ6ZI3fp8nxI6tzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LyYh0+NtJ1RO6g2KJvgQ4WgGuZmhi80z/AiOHZiFzChx4kNyAqysB5tI5jj90RLxy1NpLuj+fz6xs1B5lsqvGqiqtPZoDmn252pEhJNgxIRPh2BM3iGvrR4ppFQ67MErGn9csitMbe/JYXKHuNzNdszImaBLes4xrHVjo6VjySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fe9rsNBd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713237617; x=1744773617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9du0qDfZTGbkbG0LY7QYxW2+6choZ6ZI3fp8nxI6tzk=;
  b=Fe9rsNBdr0W3z+thjQsd7THn11VumygsZep7clMbEXJjg7Vtru1dcNLE
   ZKuRBpcGvIumA3jzeYP+GU1OcW9lIHg03bzkagf8iiX8VAH2hZ4u9ugkn
   wHW1C7RiziPuBo7Ewp4fmH0Bp2icRUuaKtXKEU3Wcx4BurHJBIxWvh2IL
   +6zjjTusfb+mPOUCBjpYa0LI1YXB9oiZYIDZ3pePKNNHgGHPZYM2Sf47+
   qJfPvUNuWNll3yAOmfz5sOsvD3JfcEZbxDh7veynf/YEsld1mKD88ElE5
   DHR/nHnIziRUcdrAtyCrZmDveQM/sJya4hTXFqcEspMIHToQoo/28A5gO
   g==;
X-CSE-ConnectionGUID: RkujwFxUTG2zHyZPos2qKg==
X-CSE-MsgGUID: bxJ7XOPQRiiWi0RehJZiZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="34043374"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="34043374"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 20:20:16 -0700
X-CSE-ConnectionGUID: 30d2p9ZmSuuo0F12oEFc0g==
X-CSE-MsgGUID: v9Fwcr7RSRWR0AeNst9EFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22193614"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmviesa008.fm.intel.com with ESMTP; 15 Apr 2024 20:20:16 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
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
Subject: [PATCH v12 07/14] x86/sgx: Abstract tracking reclaimable pages in LRU
Date: Mon, 15 Apr 2024 20:20:04 -0700
Message-Id: <20240416032011.58578-8-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416032011.58578-1-haitao.huang@linux.intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristen Carlson Accardi <kristen@linux.intel.com>

The functions, sgx_{mark,unmark}_page_reclaimable(), manage the tracking
of reclaimable EPC pages: sgx_mark_page_reclaimable() adds a newly
allocated page into the global LRU list while
sgx_unmark_page_reclaimable() does the opposite. Abstract the hard coded
global LRU references in these functions to make them reusable when
pages are tracked in per-cgroup LRUs.

Create a helper, sgx_lru_list(), that returns the LRU that tracks a given
EPC page. It simply returns the global LRU now, and will later return
the LRU of the cgroup within which the EPC page was allocated. Replace
the hard coded global LRU with a call to this helper.

Next patches will first get the cgroup reclamation flow ready while
keeping pages tracked in the global LRU and reclaimed by ksgxd before we
make the switch in the end for sgx_lru_list() to return per-cgroup
LRU.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/main.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index b782207d41b6..552455365761 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -32,6 +32,11 @@ static DEFINE_XARRAY(sgx_epc_address_space);
  */
 static struct sgx_epc_lru_list sgx_global_lru;
 
+static inline struct sgx_epc_lru_list *sgx_lru_list(struct sgx_epc_page *epc_page)
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
+	struct sgx_epc_lru_list *lru = sgx_lru_list(page);
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
+	struct sgx_epc_lru_list *lru = sgx_lru_list(page);
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
2.25.1


