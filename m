Return-Path: <cgroups+bounces-129-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F47DBFB7
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 19:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB40E2813CD
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029B519BBA;
	Mon, 30 Oct 2023 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kedlIRxl"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6645319BBE
	for <cgroups@vger.kernel.org>; Mon, 30 Oct 2023 18:20:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D638C9;
	Mon, 30 Oct 2023 11:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698690036; x=1730226036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XwIgULTxO8Z4Bp/SNgub1tcebqsaKXGrvzAz+ItDLZY=;
  b=kedlIRxlUjelJSHdfjdLLpBFk0wVY3s/SBU37vmVxgjCthLOVvwK12Li
   nrKpYs+cYINFBw7OFgQoCFfjUW0GWf9hzEbG4BJm23fZwRV1IJdKj/f8I
   iXUxLfuBUKplkE74YsTDUC4H4D5PoRXAZ8dEUVTEnMLjW9E2ZAHMwKnBQ
   mS3IZ1Nd2a2sQM1S2RqZXnNY4tMoCq6FWEAHHbasUChfv3VP8LAIG2rCw
   6rdkdqIbYf67tUtNPJzgVS2TEE9hy+ff+U1hCHl4VYTJKQL2xNnflUWS2
   ovvRgCIr6+KfJKrrz9olIOJYpTjzYfXKIzUNE6O8xkSIbeAAjwKStmpxj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367479608"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="367479608"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 11:20:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="789529528"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="789529528"
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
	Sean Christopherson <sean.j.christopherson@intel.com>,
	Haitao Huang <haitao.huang@linux.intel.com>
Subject: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim function
Date: Mon, 30 Oct 2023 11:20:10 -0700
Message-Id: <20231030182013.40086-10-haitao.huang@linux.intel.com>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

To prepare for per-cgroup reclamation, separate the top-level reclaim
function, sgx_reclaim_epc_pages(), into two separate functions:

- sgx_isolate_epc_pages() scans and isolates reclaimable pages from a given LRU list.
- sgx_do_epc_reclamation() performs the real reclamation for the already isolated pages.

Create a new function, sgx_reclaim_epc_pages_global(), calling those two
in succession, to replace the original sgx_reclaim_epc_pages(). The
above two functions will serve as building blocks for the reclamation
flows in later EPC cgroup implementation.

sgx_do_epc_reclamation() returns the number of reclaimed pages. The EPC
cgroup will use the result to track reclaiming progress.

sgx_isolate_epc_pages() returns the additional number of pages to scan
for current epoch of reclamation. The EPC cgroup will use the result to
determine if more scanning to be done in LRUs in its children groups.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
V6:
- Restructure patches to make it easier to review. (Kai)
- Fix unused nr_to_scan (Kai)
---
 arch/x86/kernel/cpu/sgx/main.c | 97 ++++++++++++++++++++++------------
 arch/x86/kernel/cpu/sgx/sgx.h  |  8 +++
 2 files changed, 72 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 33bcba313d40..e8848b493eb7 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -281,33 +281,23 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 	mutex_unlock(&encl->lock);
 }
 
-/*
- * Take a fixed number of pages from the head of the active page pool and
- * reclaim them to the enclave's private shmem files. Skip the pages, which have
- * been accessed since the last scan. Move those pages to the tail of active
- * page pool so that the pages get scanned in LRU like fashion.
+/**
+ * sgx_isolate_epc_pages() - Isolate pages from an LRU for reclaim
+ * @lru:	LRU from which to reclaim
+ * @nr_to_scan:	Number of pages to scan for reclaim
+ * @dst:	Destination list to hold the isolated pages
  *
- * Batch process a chunk of pages (at the moment 16) in order to degrade amount
- * of IPI's and ETRACK's potentially required. sgx_encl_ewb() does degrade a bit
- * among the HW threads with three stage EWB pipeline (EWB, ETRACK + EWB and IPI
- * + EWB) but not sufficiently. Reclaiming one page at a time would also be
- * problematic as it would increase the lock contention too much, which would
- * halt forward progress.
+ * Return: remaining pages to scan, i.e, @nr_to_scan minus the number of pages scanned.
  */
-static void sgx_reclaim_pages(void)
+unsigned int  sgx_isolate_epc_pages(struct sgx_epc_lru_list *lru, unsigned int nr_to_scan,
+				    struct list_head *dst)
 {
-	struct sgx_backing backing[SGX_NR_TO_SCAN];
-	struct sgx_epc_page *epc_page, *tmp;
 	struct sgx_encl_page *encl_page;
-	pgoff_t page_index;
-	LIST_HEAD(iso);
-	int ret;
-	int i;
+	struct sgx_epc_page *epc_page;
 
-	spin_lock(&sgx_global_lru.lock);
-	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
-		epc_page = list_first_entry_or_null(&sgx_global_lru.reclaimable,
-						    struct sgx_epc_page, list);
+	spin_lock(&lru->lock);
+	for (; nr_to_scan > 0; --nr_to_scan) {
+		epc_page = list_first_entry_or_null(&lru->reclaimable, struct sgx_epc_page, list);
 		if (!epc_page)
 			break;
 
@@ -316,23 +306,53 @@ static void sgx_reclaim_pages(void)
 
 		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0) {
 			sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
-			list_move_tail(&epc_page->list, &iso);
+			list_move_tail(&epc_page->list, dst);
 		} else
 			/* The owner is freeing the page. No need to add the
 			 * page back to the list of reclaimable pages.
 			 */
 			sgx_epc_page_reset_state(epc_page);
 	}
-	spin_unlock(&sgx_global_lru.lock);
+	spin_unlock(&lru->lock);
+
+	return nr_to_scan;
+}
+
+/**
+ * sgx_do_epc_reclamation() - Perform reclamation for isolated EPC pages.
+ * @iso:		List of isolated pages for reclamation
+ *
+ * Take a list of EPC pages and reclaim them to the enclave's private shmem files.  Do not
+ * reclaim the pages that have been accessed since the last scan, and move each of those pages
+ * to the tail of its tracking LRU list.
+ *
+ * Limit the number of pages to be processed up to SGX_NR_TO_SCAN_MAX per call in order to
+ * degrade amount of IPI's and ETRACK's potentially required. sgx_encl_ewb() does degrade a bit
+ * among the HW threads with three stage EWB pipeline (EWB, ETRACK + EWB and IPI + EWB) but not
+ * sufficiently. Reclaiming one page at a time would also be problematic as it would increase
+ * the lock contention too much, which would halt forward progress.
+ *
+ * Extra pages in the list beyond the SGX_NR_TO_SCAN_MAX limit are skipped and returned back to
+ * their tracking LRU lists.
+ *
+ * Return: number of pages successfully reclaimed.
+ */
+unsigned int sgx_do_epc_reclamation(struct list_head *iso)
+{
+	struct sgx_backing backing[SGX_NR_TO_SCAN_MAX];
+	struct sgx_epc_page *epc_page, *tmp;
+	struct sgx_encl_page *encl_page;
+	pgoff_t page_index;
+	size_t ret, i;
 
-	if (list_empty(&iso))
-		return;
+	if (list_empty(iso))
+		return 0;
 
 	i = 0;
-	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
+	list_for_each_entry_safe(epc_page, tmp, iso, list) {
 		encl_page = epc_page->owner;
 
-		if (!sgx_reclaimer_age(epc_page))
+		if (i == SGX_NR_TO_SCAN_MAX || !sgx_reclaimer_age(epc_page))
 			goto skip;
 
 		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
@@ -358,11 +378,11 @@ static void sgx_reclaim_pages(void)
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 	}
 
-	list_for_each_entry(epc_page, &iso, list)
+	list_for_each_entry(epc_page, iso, list)
 		sgx_reclaimer_block(epc_page);
 
 	i = 0;
-	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
+	list_for_each_entry_safe(epc_page, tmp, iso, list) {
 		encl_page = epc_page->owner;
 		sgx_reclaimer_write(epc_page, &backing[i++]);
 
@@ -371,6 +391,17 @@ static void sgx_reclaim_pages(void)
 
 		sgx_free_epc_page(epc_page);
 	}
+
+	return i;
+}
+
+static void sgx_reclaim_epc_pages_global(void)
+{
+	LIST_HEAD(iso);
+
+	sgx_isolate_epc_pages(&sgx_global_lru, SGX_NR_TO_SCAN, &iso);
+
+	sgx_do_epc_reclamation(&iso);
 }
 
 static bool sgx_should_reclaim(unsigned long watermark)
@@ -387,7 +418,7 @@ static bool sgx_should_reclaim(unsigned long watermark)
 void sgx_reclaim_direct(void)
 {
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		sgx_reclaim_pages();
+		sgx_reclaim_epc_pages_global();
 }
 
 static int ksgxd(void *p)
@@ -410,7 +441,7 @@ static int ksgxd(void *p)
 				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_pages();
+			sgx_reclaim_epc_pages_global();
 
 		cond_resched();
 	}
@@ -587,7 +618,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 		 * Need to do a global reclamation if cgroup was not full but free
 		 * physical pages run out, causing __sgx_alloc_epc_page() to fail.
 		 */
-		sgx_reclaim_pages();
+		sgx_reclaim_epc_pages_global();
 		cond_resched();
 	}
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index dd7ab65b5b27..6a40f70ed96f 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -19,6 +19,11 @@
 
 #define SGX_MAX_EPC_SECTIONS		8
 #define SGX_EEXTEND_BLOCK_SIZE		256
+
+/*
+ * Maximum number of pages to scan for reclaiming.
+ */
+#define SGX_NR_TO_SCAN_MAX		32U
 #define SGX_NR_TO_SCAN			16
 #define SGX_NR_LOW_PAGES		32
 #define SGX_NR_HIGH_PAGES		64
@@ -162,6 +167,9 @@ void sgx_reclaim_direct(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
+unsigned int sgx_do_epc_reclamation(struct list_head *iso);
+unsigned int sgx_isolate_epc_pages(struct sgx_epc_lru_list *lru, unsigned int nr_to_scan,
+				   struct list_head *dst);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.25.1


