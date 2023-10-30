Return-Path: <cgroups+bounces-127-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A92C7DBFB2
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 19:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB36D1C20AD2
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C811A29C;
	Mon, 30 Oct 2023 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/sf7+/e"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B519BAC
	for <cgroups@vger.kernel.org>; Mon, 30 Oct 2023 18:20:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAC3D3;
	Mon, 30 Oct 2023 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698690035; x=1730226035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VrZIxRi+B6VM0vEJc0eFxB36W9ZoesT26irs+zOqumk=;
  b=G/sf7+/e6nzt8AywJHy9DmV+26eMBYx5JB0Vus/1aDngIyDvXmZjG6a/
   3htt19r3via0fty4ToQf2wuRu8WjEWEfT7/rONu0o9Pe0/xRNQ5KGwsWf
   8asTWJHvAnArkLhhqkC7kYffcKkEzLXdSS38E1qBo7Cp5uLtzNnIZ9JTz
   IGeHLMkuSq44wO00QUU/9C57HIkXe4Xsd/2e2Nd/iso6rkbg1Ja+dEVLG
   zBzTyRttNS6W8c3EBrnzef/X9nBFBSZCmIvGnc8B3xKb0gk+O/zNzOG/1
   AtYCevhN0C8lu3crAUOvEaLDG7uvrJ418x0eSmu80MEwmYkvYtnXZEqkb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367479581"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="367479581"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 11:20:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="789529520"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="789529520"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2023 11:20:29 -0700
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
	sohil.mehta@intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	Haitao Huang <haitao.huang@linux.intel.com>,
	Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v6 07/12] x86/sgx: Introduce EPC page states
Date: Mon, 30 Oct 2023 11:20:08 -0700
Message-Id: <20231030182013.40086-8-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231030182013.40086-1-haitao.huang@linux.intel.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the lower 2 bits in the flags field of sgx_epc_page struct to track
EPC states and define an enum for possible states for EPC pages tracked
for reclamation.

Add the RECLAIM_IN_PROGRESS state to explicitly indicate a page that is
identified as a candidate for reclaiming, but has not yet been
reclaimed, instead of relying on list_empty(&epc_page->list). A later
patch will replace the array on stack with a temporary list to store the
candidate pages, so list_empty() should no longer be used for this
purpose.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
V6:
- Drop UNRECLAIMABLE and use only 2 bits for states (Kai)
- Combine the patch for RECLAIM_IN_PROGRESS
- Style fixes (Jarkko and Kai)
---
 arch/x86/kernel/cpu/sgx/encl.c |  2 +-
 arch/x86/kernel/cpu/sgx/main.c | 33 +++++++++---------
 arch/x86/kernel/cpu/sgx/sgx.h  | 62 +++++++++++++++++++++++++++++++---
 3 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 279148e72459..17dc108d3ff7 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -1315,7 +1315,7 @@ void sgx_encl_free_epc_page(struct sgx_epc_page *page)
 {
 	int ret;
 
-	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
+	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_STATE_MASK);
 
 	ret = __eremove(sgx_get_epc_virt_addr(page));
 	if (WARN_ONCE(ret, EREMOVE_ERROR_MESSAGE, ret, ret))
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index d347acd717fd..e27ac73d8843 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -315,13 +315,14 @@ static void sgx_reclaim_pages(void)
 		list_del_init(&epc_page->list);
 		encl_page = epc_page->owner;
 
-		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0)
+		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0) {
+			sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
 			chunk[cnt++] = epc_page;
-		else
+		} else
 			/* The owner is freeing the page. No need to add the
 			 * page back to the list of reclaimable pages.
 			 */
-			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+			sgx_epc_page_reset_state(epc_page);
 	}
 	spin_unlock(&sgx_global_lru.lock);
 
@@ -347,6 +348,7 @@ static void sgx_reclaim_pages(void)
 
 skip:
 		spin_lock(&sgx_global_lru.lock);
+		sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
 		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
 		spin_unlock(&sgx_global_lru.lock);
 
@@ -370,7 +372,7 @@ static void sgx_reclaim_pages(void)
 		sgx_reclaimer_write(epc_page, &backing[i]);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
-		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+		sgx_epc_page_reset_state(epc_page);
 
 		sgx_free_epc_page(epc_page);
 	}
@@ -509,7 +511,8 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
 {
 	spin_lock(&sgx_global_lru.lock);
-	page->flags |= SGX_EPC_PAGE_RECLAIMER_TRACKED;
+	WARN_ON_ONCE(sgx_epc_page_reclaimable(page->flags));
+	page->flags |= SGX_EPC_PAGE_RECLAIMABLE;
 	list_add_tail(&page->list, &sgx_global_lru.reclaimable);
 	spin_unlock(&sgx_global_lru.lock);
 }
@@ -527,16 +530,13 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
 {
 	spin_lock(&sgx_global_lru.lock);
-	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
-		/* The page is being reclaimed. */
-		if (list_empty(&page->list)) {
-			spin_unlock(&sgx_global_lru.lock);
-			return -EBUSY;
-		}
-
-		list_del(&page->list);
-		page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+	if (sgx_epc_page_reclaim_in_progress(page->flags)) {
+		spin_unlock(&sgx_global_lru.lock);
+		return -EBUSY;
 	}
+
+	list_del(&page->list);
+	sgx_epc_page_reset_state(page);
 	spin_unlock(&sgx_global_lru.lock);
 
 	return 0;
@@ -623,6 +623,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
 	struct sgx_numa_node *node = section->node;
 
+	WARN_ON_ONCE(page->flags & (SGX_EPC_PAGE_STATE_MASK));
 	if (page->epc_cg) {
 		sgx_epc_cgroup_uncharge(page->epc_cg);
 		page->epc_cg = NULL;
@@ -635,7 +636,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 		list_add(&page->list, &node->sgx_poison_page_list);
 	else
 		list_add_tail(&page->list, &node->free_page_list);
-	page->flags = SGX_EPC_PAGE_IS_FREE;
+	page->flags = SGX_EPC_PAGE_FREE;
 
 	spin_unlock(&node->lock);
 	atomic_long_inc(&sgx_nr_free_pages);
@@ -737,7 +738,7 @@ int arch_memory_failure(unsigned long pfn, int flags)
 	 * If the page is on a free list, move it to the per-node
 	 * poison page list.
 	 */
-	if (page->flags & SGX_EPC_PAGE_IS_FREE) {
+	if (page->flags == SGX_EPC_PAGE_FREE) {
 		list_move(&page->list, &node->sgx_poison_page_list);
 		goto out;
 	}
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 0fbe6a2a159b..dd7ab65b5b27 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -23,11 +23,44 @@
 #define SGX_NR_LOW_PAGES		32
 #define SGX_NR_HIGH_PAGES		64
 
-/* Pages, which are being tracked by the page reclaimer. */
-#define SGX_EPC_PAGE_RECLAIMER_TRACKED	BIT(0)
+enum sgx_epc_page_state {
+	/*
+	 * Allocated but not tracked by the reclaimer.
+	 *
+	 * Pages allocated for virtual EPC which are never tracked by the host
+	 * reclaimer; pages just allocated from free list but not yet put in
+	 * use; pages just reclaimed, but not yet returned to the free list.
+	 * Becomes FREE after sgx_free_epc().
+	 * Becomes RECLAIMABLE after sgx_mark_page_reclaimable().
+	 */
+	SGX_EPC_PAGE_NOT_TRACKED = 0,
+
+	/*
+	 * Page is in the free list, ready for allocation.
+	 *
+	 * Becomes NOT_TRACKED after sgx_alloc_epc_page().
+	 */
+	SGX_EPC_PAGE_FREE = 1,
+
+	/*
+	 * Page is in use and tracked in a reclaimable LRU list.
+	 *
+	 * Becomes NOT_TRACKED after sgx_unmark_page_reclaimable().
+	 * Becomes RECLAIM_IN_PROGRESS in sgx_reclaim_pages() when identified
+	 * for reclaiming.
+	 */
+	SGX_EPC_PAGE_RECLAIMABLE = 2,
+
+	/*
+	 * Page is in the middle of reclamation.
+	 *
+	 * Back to RECLAIMABLE if reclamation fails for any reason.
+	 * Becomes NOT_TRACKED if reclaimed successfully.
+	 */
+	SGX_EPC_PAGE_RECLAIM_IN_PROGRESS = 3,
+};
 
-/* Pages on free list */
-#define SGX_EPC_PAGE_IS_FREE		BIT(1)
+#define SGX_EPC_PAGE_STATE_MASK GENMASK(1, 0)
 
 struct sgx_epc_cgroup;
 
@@ -40,6 +73,27 @@ struct sgx_epc_page {
 	struct sgx_epc_cgroup *epc_cg;
 };
 
+static inline void sgx_epc_page_reset_state(struct sgx_epc_page *page)
+{
+	page->flags &= ~SGX_EPC_PAGE_STATE_MASK;
+}
+
+static inline void sgx_epc_page_set_state(struct sgx_epc_page *page, unsigned long flags)
+{
+	page->flags &= ~SGX_EPC_PAGE_STATE_MASK;
+	page->flags |= (flags & SGX_EPC_PAGE_STATE_MASK);
+}
+
+static inline bool sgx_epc_page_reclaim_in_progress(unsigned long flags)
+{
+	return SGX_EPC_PAGE_RECLAIM_IN_PROGRESS == (flags & SGX_EPC_PAGE_STATE_MASK);
+}
+
+static inline bool sgx_epc_page_reclaimable(unsigned long flags)
+{
+	return SGX_EPC_PAGE_RECLAIMABLE == (flags & SGX_EPC_PAGE_STATE_MASK);
+}
+
 /*
  * Contains the tracking data for NUMA nodes having EPC pages. Most importantly,
  * the free page list local to the node is stored here.
-- 
2.25.1


