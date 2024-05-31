Return-Path: <cgroups+bounces-3055-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66B98D6C6D
	for <lists+cgroups@lfdr.de>; Sat,  1 Jun 2024 00:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C04D288590
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2024 22:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7E413210A;
	Fri, 31 May 2024 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFAtrEdY"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254D9839E2;
	Fri, 31 May 2024 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717194399; cv=none; b=g7+44Me5/tFAebnS2RqBV2AnuxzoW6jEf/VbLRyOMJxSC4uE8LixFgCxGlvzG1GeUAA+XD3pYmaQCMrHioi/4ATxC6bt03VBcMR2Zzffqcz5iP71qge0Erloisv7qME0l5UOAKDWubw9/8IVobhyfOwOzLdqY+qfEPzGAP+aYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717194399; c=relaxed/simple;
	bh=E42w3c+6Y5YrvHQsNc8yLjQB5Qr3qeGM4uvZtGJ21I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NDWv2riKwsU96cmzJz9YV6LFC6fnRznv4sGPpnxbrgAo0nVFG3pyhr44P9D68yhqBeI1ZEM+4QxmlsQQl1CtSulLHs1BfuQv7eaTrfX+ivOddyHbo722Oaiv2CdDeqFYFpxqoChgIFIE+tlvSBwjVMAyDddysjqzPwHy4H7QuRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFAtrEdY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717194397; x=1748730397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E42w3c+6Y5YrvHQsNc8yLjQB5Qr3qeGM4uvZtGJ21I4=;
  b=SFAtrEdYWwK7YQ8k9hinOJK8hiPAxQH2tl9CAOk+zd3Niyxo8JeFl/VB
   KFBNk+cLkobG/+VLLNf/OyXr4VdTVbrf/udM0JMcuzOB61uQ3AIU+JSPj
   RyWC7DbGorWKC/ZcuH9wJ61kDtG68Ox7WLBHCo55h8LZuNy678+OmSyap
   V4Hq9zLsiy3TB2MThze27kzsHq7LgusjxxCMEo0EcqiWu2jpFURaHhCrO
   tvNqnYfXJPCzMX7iNJWE4QXMYTjCXccDG/9QY0DM96NhWxlKkcwts8zqf
   PN17Y0IhbSOQH6kQ6Zmm8EGn8hz0N3G3I1k8Eq+zf6VwKgj69fGdOGahv
   Q==;
X-CSE-ConnectionGUID: v5cem1KfQIifacZpYhOUpQ==
X-CSE-MsgGUID: vtYNQoQ7SbeCJPUCbams9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13949785"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13949785"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 15:26:35 -0700
X-CSE-ConnectionGUID: GWG2+tU0SEW0gFQN+ELnMw==
X-CSE-MsgGUID: fwvSUvxSTnCmc81uEgMRuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="40736933"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmviesa005.fm.intel.com with ESMTP; 31 May 2024 15:26:35 -0700
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
Subject: [PATCH v14 07/14] x86/sgx: Abstract tracking reclaimable pages in LRU
Date: Fri, 31 May 2024 15:26:23 -0700
Message-Id: <20240531222630.4634-8-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240531222630.4634-1-haitao.huang@linux.intel.com>
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
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
index 75d6ce72b9b8..1fa73250e2b9 100644
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
2.25.1


