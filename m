Return-Path: <cgroups+bounces-2732-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8986D8B80D4
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2024 21:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95561C241F3
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2024 19:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5121C0DD1;
	Tue, 30 Apr 2024 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDQboc9l"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84311BED61;
	Tue, 30 Apr 2024 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506677; cv=none; b=VmqAIdNDujbYH9A80ChYJpDCX+iuu0bNe3OyOgAio8RLykTPTocZEvbsowr3sd/4IB8pcDLhb9i7UhssfJMDu+p8bzDpCn+Zd+YpYtAZ/o16QBkUcsBJ6cwPV4d9SeK+agfaMS0KWLHu0fT2jW0OP5vhlYL7np/4o4/2VKezKBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506677; c=relaxed/simple;
	bh=8yj/lS6EpRslsBVdm+2I5U+2edHK+4A85pLtHuDrUTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dGc5irtRkHQDNKAR2G9JoMlZVEAPRdjGFpV2sSMKiy/SuX3jdGXi0jDYTYHpLOudQDTr+LJv6SE2ZDswbjbLkqk6ZShYJm1D9O+6/7OglBrU7PJ8eRzYWlB7Km8cL4SP0il+BDD7M5DJpqbmY3fR7qqFpKZ38umgJovzjPLMGRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDQboc9l; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714506676; x=1746042676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8yj/lS6EpRslsBVdm+2I5U+2edHK+4A85pLtHuDrUTk=;
  b=TDQboc9loioYkYY8/DSgFx5+1Huzsz2M8Kkhod8SjoYU+Zx5t4/xWTtr
   EeEevPfh6H5iU5fHuLBQTxDDwZ0aLbDXQWwHhujcdQtgd0vwrMjhgCiHq
   xzW/dmZlthh3QluMf45545g3dtpwVf55/gFMzfBqz9y9i+HVG/uNFUcNy
   7pSyWeCbGcI/wyeDRkHh2AoLTc7E4axpvJEpsKqjAFCBl7OAtZGpq5tQr
   caNfDw7p7PDMPc23w8jtSkTfswOAXh8zs2IqVRBFTq65S4mHWdsO6cdRh
   BzCSy3o1+0VyCPmQz4vSjYS12KkZCOOi3M3C3ImdAXZ5d0n2RY+nfipvf
   g==;
X-CSE-ConnectionGUID: 5NQLWrIFTgGs7Xe334FZjQ==
X-CSE-MsgGUID: yB6g2oRCSrKJhW73sE7Vbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10355616"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10355616"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 12:51:11 -0700
X-CSE-ConnectionGUID: BKvdZbL5QsmrVP/AtFEu4g==
X-CSE-MsgGUID: T0Y47VMqRXG16cPUKqCySw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31280316"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa003.jf.intel.com with ESMTP; 30 Apr 2024 12:51:09 -0700
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
Subject: [PATCH v13 07/14] x86/sgx: Abstract tracking reclaimable pages in LRU
Date: Tue, 30 Apr 2024 12:51:01 -0700
Message-Id: <20240430195108.5676-8-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430195108.5676-1-haitao.huang@linux.intel.com>
References: <20240430195108.5676-1-haitao.huang@linux.intel.com>
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
index 59736dd02ca7..2bf9cca3be21 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -31,6 +31,11 @@ static DEFINE_XARRAY(sgx_epc_address_space);
  */
 static struct sgx_epc_lru_list sgx_global_lru;
 
+static inline struct sgx_epc_lru_list *sgx_epc_page_lru(struct sgx_epc_page *epc_page)
+{
+	return &sgx_global_lru;
+}
+
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
 /* Nodes with one or more EPC sections. */
@@ -499,25 +504,24 @@ static struct sgx_epc_page *__sgx_alloc_epc_page(void)
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
@@ -525,18 +529,20 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
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
2.25.1


