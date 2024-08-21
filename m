Return-Path: <cgroups+bounces-4391-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C7C959270
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 03:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AAC285AB3
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 01:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101B114B96A;
	Wed, 21 Aug 2024 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFPz19o9"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C013B28D;
	Wed, 21 Aug 2024 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205267; cv=none; b=WXSIATev2KJoHIIESi1reajCit0f8VlNi5i0WnN3jceJHWKQQwO2CvXrOHnxZopAN/f9GeoYTD++ViK3BNq4M5rYXJk5fKmYvm94XdWogKIhHb/qaNSTdV5vKNIYwVIsDjD2fC+E/PDCER0Ph42+1fuZVRbTrSFLi5p1tIyqB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205267; c=relaxed/simple;
	bh=unE3aRRGHJcMIIhSOH6RwOlRDMn/b29/KAYyxquVq/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9bqPMDwxHUQFkCfjH73/dhP0wz7WoC2qToNCWO/YDd9lcyiMubvlYBdId0h4sucdXiZfewvrjdU8Ttb8ny43VXKhyOhA44zi1Xm7hPIIO2HPcJV+7d8ZFUSPDKk23mmuYR98xi9nZen1MTVMFgWHllhi0VuVQqda3YlZZkKvbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFPz19o9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205266; x=1755741266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=unE3aRRGHJcMIIhSOH6RwOlRDMn/b29/KAYyxquVq/4=;
  b=nFPz19o9rI/s2kMJiWrPxv/aGvtjl10Xzsup1V2Acl6LvQYxmxc2Brf5
   vxkwp2e6M9BRJvYXXH7z+KslQEXPxRdEpc3nu4/+/30/Q9JCHzCk+Agac
   dlw/5wv02Eziq/BTHIuD7+530WbcS++KITSgQW8x6lfjjPuWxB2iMhvS8
   OEtlDOBZd9J7eanyAdDW8gM3l/2iQBe+uz1SpPrm3RGMUttTHTCObcGMq
   3AkUC7gZ4Ym7QPhxCPrRSNSa8MrXzvLuV8ibNzddzz7xj9LmMi7Qzfr9z
   8hE13vgSZ8HkaeuSeiLs/K5s0RArju3dtkXUlKV+AbdKIWhyTo7KZfx0m
   Q==;
X-CSE-ConnectionGUID: Yl9CAhEaSniFhhJaJO+U5w==
X-CSE-MsgGUID: VQtUs3WqT7WSgP68x0rApQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33107887"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33107887"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:19 -0700
X-CSE-ConnectionGUID: 8m4i7IzhTrqBJxNlQMuiNQ==
X-CSE-MsgGUID: lWsBKfReRzK6pUfAtwNjkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61078598"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:18 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
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
Subject: [PATCH v16 07/16] x86/sgx: Abstract tracking reclaimable pages in LRU
Date: Tue, 20 Aug 2024 18:53:55 -0700
Message-ID: <20240821015404.6038-8-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821015404.6038-1-haitao.huang@linux.intel.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
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
index 45832c9a1e1b..5d5f6baac9c8 100644
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


