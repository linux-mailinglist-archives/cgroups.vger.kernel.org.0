Return-Path: <cgroups+bounces-1355-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C951D84A85A
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 23:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA2728F982
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 22:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9448E14462B;
	Mon,  5 Feb 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUwyv+Rn"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4B1420AF;
	Mon,  5 Feb 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167206; cv=none; b=njntB9HB3fYkuH93iCmZNC97RkvirOK1SHyCCTySzeLhg75IJ3PbUcV5r3DWO7Fr/m7Hhx0iHRX8zLzz5thl07JlEC+Z1dQVTBevrOR1uqplz1qt2iKY3Cu7GkbZGMmVUYFBZWuSILJT14qOZyxbX5ZRlCEDiDWIh5l0wBC19Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167206; c=relaxed/simple;
	bh=CT/6JGPWjxMvj1JlVfSUdNt8xUVPb/vuGjvVCy3cR3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e4kjBPdEaOu8ZmrjmYFDGFUP87jKFHqhb5pviXMOzDN0q+jalTU/l1/wpIOVpLluvOXkU9F+BiUNaXjeX3syUh2mk4b2u7xZ2A1DB0ulqGrSsNlpVt5ZxQeGAZSd1fG5F5JjG/bYSaAW0sOX8aXdu1hsD+wS8+Ray6fRgcbnCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUwyv+Rn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707167205; x=1738703205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CT/6JGPWjxMvj1JlVfSUdNt8xUVPb/vuGjvVCy3cR3A=;
  b=bUwyv+RnH+DRRmqLnpFZgHr+OfrwCta70LbJqLfCBMgZIECsc4X3BDc+
   YHvOEVkbeBBB+86NdLhu5cpbQwQB2scLzHY8WYMDC7NCCWNMjhEwYKXEr
   KAsH7fpFyaZOK09T02P9NubsprXkg/hbnyP5z3nqmPBBVs2nn1Hw8U9Wj
   P+aJXMP+PoVQSLn5787psHlwWhQH1WDENgKuLQTw0QOGrD9GjurkL3HCk
   Wt+xqm71yfK8U5igcGfoRj2TrTqGIpjGzxDkHQREO7Fh2mRr0h6hayvoW
   nQfN/9ZyYZRzER8CJpDp7s+hbTBYDTTtZ0KqGaCjyS3YFj4EV3af+OLRX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11960403"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11960403"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:06:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="38245626"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa001.jf.intel.com with ESMTP; 05 Feb 2024 13:06:41 -0800
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
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
Subject: [PATCH v9 06/15] x86/sgx: Abstract tracking reclaimable pages in LRU
Date: Mon,  5 Feb 2024 13:06:29 -0800
Message-Id: <20240205210638.157741-7-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205210638.157741-1-haitao.huang@linux.intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
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
---
V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/main.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 912959c7ecc9..a131aa985c95 100644
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
@@ -500,25 +505,24 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
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


