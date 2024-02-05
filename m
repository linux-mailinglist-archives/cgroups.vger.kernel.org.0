Return-Path: <cgroups+bounces-1357-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC22284A860
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 23:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE1C1F2C517
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 22:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8941474A1;
	Mon,  5 Feb 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtFm2Qv3"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B13E1420CF;
	Mon,  5 Feb 2024 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167207; cv=none; b=gtZpgc4f97H2sLjRgKygdnHbkWYA80LTjIlAd6yzQUoU9nVXx1Ie16L+kqlvKTf2QbkT8pJEnT+M+TMPVIkL44X39Vkyw7TV6u4sw7r8CX38i+1oG095SgiY72O+hQSNvzleyN00/rTM248imvOrhmQL9tae1riDbttDfMgRdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167207; c=relaxed/simple;
	bh=FkvdAsiRimG0155vi9kTsbkBJOJnYCJn8tUbdiiXarc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CwxLJxn0CvErYzO43WdEu4jf6dDw4trv2jSWzHz55q4A+z5fWEokRJ0QCMjByR5gsbEV4SOIJlSLheZwCpN46UHbYlpLNGen84fJWwJ+KImnAUh7FaKDvTJriDNioGNbVlUwLRYJME1WhyVTM9+50+5jd+9JtiPfB6JaP5zqLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtFm2Qv3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707167206; x=1738703206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FkvdAsiRimG0155vi9kTsbkBJOJnYCJn8tUbdiiXarc=;
  b=gtFm2Qv3L8uC8G2egYM0bPkBAVUw2qGJDAWK0QoGL4Khfg/uTgh+/a2Y
   jXdimwU+sH2n71bdAmmMN1ShgbWd5mhcwDT8zsrq+9wc/NFzC9za/6446
   s0j3nzXFpO/+1/vcK81vwc+WOe0S6v9/02zEH2+dFxpGothEiGGLMhA0f
   SV7xfRsmecRjmHqyb+yvI2ttF+TD+YvRlTewR/GAy4AawMmy25Vzd3LwQ
   Yr4yUlo5NJ3E85sLfpYgethYiW1AlQ8mFWTsAKyZj7pldU+k3a3E+mnnJ
   E9BsiS9GW2jScfshpfxQSBcM5acxInsQ18pmBJpOJjnFIgXYk0B6tKaDn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11960423"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11960423"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:06:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="38245631"
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
Subject: [PATCH v9 07/15] x86/sgx: Expose sgx_reclaim_pages() for cgroup
Date: Mon,  5 Feb 2024 13:06:30 -0800
Message-Id: <20240205210638.157741-8-haitao.huang@linux.intel.com>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

Each EPC cgroup will have an LRU structure to track reclaimable EPC pages.
When a cgroup usage reaches its limit, the cgroup needs to reclaim pages
from its LRU or LRUs of its descendants to make room for any new
allocations.

To prepare for reclamation per cgroup, expose the top level reclamation
function, sgx_reclaim_pages(), in header file for reuse. Add a parameter
to the function to pass in an LRU so cgroups can pass in different
tracking LRUs later.  Add another parameter for passing in the number of
pages to scan and make the function return the number of pages reclaimed
as a cgroup reclaimer may need to track reclamation progress from its
descendants, change number of pages to scan in subsequent calls.

Create a wrapper for the global reclaimer, sgx_reclaim_pages_global(),
to just call this function with the global LRU passed in. When
per-cgroup LRU is added later, the wrapper will perform global
reclamation from the root cgroup.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V8:
- Use width of 80 characters in text paragraphs. (Jarkko)

V7:
- Reworked from patch 9 of V6, "x86/sgx: Restructure top-level EPC reclaim
function". Do not split the top level function (Kai)
- Dropped patches 7 and 8 of V6.
---
 arch/x86/kernel/cpu/sgx/main.c | 53 +++++++++++++++++++++++-----------
 arch/x86/kernel/cpu/sgx/sgx.h  |  1 +
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index a131aa985c95..4f5824c4751d 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -286,11 +286,13 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 	mutex_unlock(&encl->lock);
 }
 
-/*
- * Take a fixed number of pages from the head of the active page pool and
- * reclaim them to the enclave's private shmem files. Skip the pages, which have
- * been accessed since the last scan. Move those pages to the tail of active
- * page pool so that the pages get scanned in LRU like fashion.
+/**
+ * sgx_reclaim_pages() - Reclaim a fixed number of pages from an LRU
+ *
+ * Take a fixed number of pages from the head of a given LRU and reclaim them to
+ * the enclave's private shmem files. Skip the pages, which have been accessed
+ * since the last scan. Move those pages to the tail of the list so that the
+ * pages get scanned in LRU like fashion.
  *
  * Batch process a chunk of pages (at the moment 16) in order to degrade amount
  * of IPI's and ETRACK's potentially required. sgx_encl_ewb() does degrade a bit
@@ -298,8 +300,13 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  * + EWB) but not sufficiently. Reclaiming one page at a time would also be
  * problematic as it would increase the lock contention too much, which would
  * halt forward progress.
+ *
+ * @lru:	The LRU from which pages are reclaimed.
+ * @nr_to_scan: Pointer to the target number of pages to scan, must be less than
+ *		SGX_NR_TO_SCAN.
+ * Return:	Number of pages reclaimed.
  */
-static void sgx_reclaim_pages(void)
+unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned int *nr_to_scan)
 {
 	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
 	struct sgx_backing backing[SGX_NR_TO_SCAN];
@@ -310,10 +317,10 @@ static void sgx_reclaim_pages(void)
 	int ret;
 	int i;
 
-	spin_lock(&sgx_global_lru.lock);
-	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
-		epc_page = list_first_entry_or_null(&sgx_global_lru.reclaimable,
-						    struct sgx_epc_page, list);
+	spin_lock(&lru->lock);
+
+	for (; *nr_to_scan > 0; --(*nr_to_scan)) {
+		epc_page = list_first_entry_or_null(&lru->reclaimable, struct sgx_epc_page, list);
 		if (!epc_page)
 			break;
 
@@ -328,7 +335,8 @@ static void sgx_reclaim_pages(void)
 			 */
 			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 	}
-	spin_unlock(&sgx_global_lru.lock);
+
+	spin_unlock(&lru->lock);
 
 	for (i = 0; i < cnt; i++) {
 		epc_page = chunk[i];
@@ -351,9 +359,9 @@ static void sgx_reclaim_pages(void)
 		continue;
 
 skip:
-		spin_lock(&sgx_global_lru.lock);
-		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
-		spin_unlock(&sgx_global_lru.lock);
+		spin_lock(&lru->lock);
+		list_add_tail(&epc_page->list, &lru->reclaimable);
+		spin_unlock(&lru->lock);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 
@@ -366,6 +374,7 @@ static void sgx_reclaim_pages(void)
 			sgx_reclaimer_block(epc_page);
 	}
 
+	ret = 0;
 	for (i = 0; i < cnt; i++) {
 		epc_page = chunk[i];
 		if (!epc_page)
@@ -378,7 +387,10 @@ static void sgx_reclaim_pages(void)
 		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 
 		sgx_free_epc_page(epc_page);
+		ret++;
 	}
+
+	return (unsigned int)ret;
 }
 
 static bool sgx_should_reclaim(unsigned long watermark)
@@ -387,6 +399,13 @@ static bool sgx_should_reclaim(unsigned long watermark)
 	       !list_empty(&sgx_global_lru.reclaimable);
 }
 
+static void sgx_reclaim_pages_global(void)
+{
+	unsigned int nr_to_scan = SGX_NR_TO_SCAN;
+
+	sgx_reclaim_pages(&sgx_global_lru, &nr_to_scan);
+}
+
 /*
  * sgx_reclaim_direct() should be called (without enclave's mutex held)
  * in locations where SGX memory resources might be low and might be
@@ -395,7 +414,7 @@ static bool sgx_should_reclaim(unsigned long watermark)
 void sgx_reclaim_direct(void)
 {
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		sgx_reclaim_pages();
+		sgx_reclaim_pages_global();
 }
 
 static int ksgxd(void *p)
@@ -418,7 +437,7 @@ static int ksgxd(void *p)
 				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_pages();
+			sgx_reclaim_pages_global();
 
 		cond_resched();
 	}
@@ -604,7 +623,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 		 * Need to do a global reclamation if cgroup was not full but free
 		 * physical pages run out, causing __sgx_alloc_epc_page() to fail.
 		 */
-		sgx_reclaim_pages();
+		sgx_reclaim_pages_global();
 		cond_resched();
 	}
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 0e99e9ae3a67..2593c013d091 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -110,6 +110,7 @@ void sgx_reclaim_direct(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
+unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned int *nr_to_scan);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.25.1


