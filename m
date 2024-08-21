Return-Path: <cgroups+bounces-4390-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 292E195926D
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 03:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B7B1F245EE
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 01:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413A814884F;
	Wed, 21 Aug 2024 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhdHXSdd"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3295E13665B;
	Wed, 21 Aug 2024 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205267; cv=none; b=pXiP14fLlGUMlma9H/S5Dus54WiKNgFdAY2Ab3hR+ZuQSWitbH+p4L4Quu1QuiOE5hOvZqx8IZCqHNKia4lOiKcdOHrXtQg8opbcPydO97eW77KsSN87So4x0nNvtw1CR6Jy6sgbuWIIQ54Mfvat9bvNcEtZO+5PZHXBmgMoPmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205267; c=relaxed/simple;
	bh=rYcSeTSi0Pitr0Zq3QKFi5f1AD9kLUF2sUqZRy9AESE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sV1ZORPtIeCuZr5xJVHU0Yh1lKr/JG3vDEA2/UMWGeK89kVTRkkqozqFsuHn1SupcGsbqk10bZ3oEMjauLoSvKuftd8MZOoxo6Q1gYR6zB+LKorQKrz/OxYawaRiababHh+FlVykasICsftk9vKKDDVswZOJflSQkQjKqZTLnMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhdHXSdd; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205265; x=1755741265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rYcSeTSi0Pitr0Zq3QKFi5f1AD9kLUF2sUqZRy9AESE=;
  b=bhdHXSddakJxli1O4BL446TctIvMcPi/UXPP/rHwuFwLqiE6dYBVGzFU
   VFxpIg9v6//l4aEWkwqswWDY1VJikAuY4X0LHTVn1ibuQik+Nuz02CJ6u
   weUNNjh4/nlxekt0Xe23ViYxbflo5JNmbsRYVRVcWkkG/DaWN5Yqt3+Mh
   8MCyNv51ZJ0HE4dcQu1nlp87/6sq4w4bVoqZFWzqMd6Evjv3MLL6n1WVG
   d/0UtgY0zv/BhfU1W1Of4EDNJAck9t2u03xSbNYRz9jCg+2zbIEJY6fMO
   JNNIUW0IWroNIeFag/eCSOIJrj8Ugp5lFQCZ1yJn/aYWP8wqTfju/5ND9
   g==;
X-CSE-ConnectionGUID: I5SF3wY9T/GNjNXGjdy3wA==
X-CSE-MsgGUID: 4OvMkZpzRwuuaTsDl6q7Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33107900"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33107900"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:19 -0700
X-CSE-ConnectionGUID: 3N4XwjMsSiO9IU4AVkejoQ==
X-CSE-MsgGUID: anRdPhIGSDCiUNRgmhL49A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61078603"
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
Subject: [PATCH v16 08/16] x86/sgx: Encapsulate uses of the global LRU
Date: Tue, 20 Aug 2024 18:53:56 -0700
Message-ID: <20240821015404.6038-9-haitao.huang@linux.intel.com>
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

To support the per-cgroup reclamation, each cgroup will have its own
"per-cgroup LRU" and EPC pages will be in its owner cgroup's LRU instead
of the global LRU. Abstract the code that is directly working with the
global LRU into functions reusable with per-cgroup LRUs.

Currently the basic reclamation procedure, sgx_reclaim_pages() directly
reclaims pages from the global LRU. Change it to take in an LRU.

Note the global EPC reclamation will still be needed when the total EPC
usage reaches the system capacity while usages of some cgroups are below
their respective limits. Create a separate wrapper for the global
reclamation, sgx_reclaim_pages_global(), passing in the global LRU to
the new sgx_reclaim_pages() now. Later it will be revised to reclaim
from multiple LRUs from all EPC cgroups instead of a single global LRU.

Wrap the existing emptiness check of the global LRU with a helper so
that it can be changed later to work with multiple LRUs when per-cgroup
LRU comes to play.

Also the per-cgroup EPC reclaim and global EPC reclaim will have
different check on whether they should be done.  Rename the existing
sgx_should_reclaim() to sgx_should_reclaim_global() to separate the two
cases.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
v16:
- Regroup all abstraction related to global LRU usage to this patch from
  different patches in previous version. Position this before adding
per-cgroup reclaim. (Kai)

V13:
- Rename sgx_can_reclaim() to sgx_can_reclaim_global() and
sgx_should_reclaim() to sgx_should_reclaim_global(). (Kai)

V10:
- Add comments for the new function. (Jarkko)

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/main.c | 63 ++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 5d5f6baac9c8..47dfba6f45af 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -37,6 +37,21 @@ static inline struct sgx_epc_lru_list *sgx_epc_page_lru(struct sgx_epc_page *epc
 	return &sgx_global_lru;
 }
 
+/*
+ * Check if there is any reclaimable page at global level.
+ */
+static inline bool sgx_can_reclaim_global(void)
+{
+	/*
+	 * Now all EPC pages are still tracked in the @sgx_global_lru, so only
+	 * check @sgx_global_lru.
+	 *
+	 * When EPC pages are tracked in the actual per-cgroup LRUs,
+	 * replace with sgx_cgroup_lru_empty(misc_cg_root()).
+	 */
+	return !list_empty(&sgx_global_lru.reclaimable);
+}
+
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
 /* Nodes with one or more EPC sections. */
@@ -287,10 +302,10 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 }
 
 /*
- * Take a fixed number of pages from the head of the active page pool and
- * reclaim them to the enclave's private shmem files. Skip the pages, which have
- * been accessed since the last scan. Move those pages to the tail of active
- * page pool so that the pages get scanned in LRU like fashion.
+ * Take a fixed number of pages from the head of a given LRU and reclaim them to
+ * the enclave's private shmem files. Skip the pages, which have been accessed
+ * since the last scan. Move those pages to the tail of the list so that the
+ * pages get scanned in LRU like fashion.
  *
  * Batch process a chunk of pages (at the moment 16) in order to degrade amount
  * of IPI's and ETRACK's potentially required. sgx_encl_ewb() does degrade a bit
@@ -299,7 +314,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  * problematic as it would increase the lock contention too much, which would
  * halt forward progress.
  */
-static void sgx_reclaim_pages(void)
+static void sgx_reclaim_pages(struct sgx_epc_lru_list *lru)
 {
 	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
 	struct sgx_backing backing[SGX_NR_TO_SCAN];
@@ -310,10 +325,9 @@ static void sgx_reclaim_pages(void)
 	int ret;
 	int i;
 
-	spin_lock(&sgx_global_lru.lock);
+	spin_lock(&lru->lock);
 	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
-		epc_page = list_first_entry_or_null(&sgx_global_lru.reclaimable,
-						    struct sgx_epc_page, list);
+		epc_page = list_first_entry_or_null(&lru->reclaimable, struct sgx_epc_page, list);
 		if (!epc_page)
 			break;
 
@@ -328,7 +342,7 @@ static void sgx_reclaim_pages(void)
 			 */
 			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 	}
-	spin_unlock(&sgx_global_lru.lock);
+	spin_unlock(&lru->lock);
 
 	for (i = 0; i < cnt; i++) {
 		epc_page = chunk[i];
@@ -351,9 +365,9 @@ static void sgx_reclaim_pages(void)
 		continue;
 
 skip:
-		spin_lock(&sgx_global_lru.lock);
-		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
-		spin_unlock(&sgx_global_lru.lock);
+		spin_lock(&lru->lock);
+		list_add_tail(&epc_page->list, &lru->reclaimable);
+		spin_unlock(&lru->lock);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 
@@ -381,10 +395,15 @@ static void sgx_reclaim_pages(void)
 	}
 }
 
-static bool sgx_should_reclaim(unsigned long watermark)
+static bool sgx_should_reclaim_global(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
-	       !list_empty(&sgx_global_lru.reclaimable);
+		sgx_can_reclaim_global();
+}
+
+static void sgx_reclaim_pages_global(void)
+{
+	sgx_reclaim_pages(&sgx_global_lru);
 }
 
 /*
@@ -394,8 +413,8 @@ static bool sgx_should_reclaim(unsigned long watermark)
  */
 void sgx_reclaim_direct(void)
 {
-	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		sgx_reclaim_pages();
+	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
+		sgx_reclaim_pages_global();
 }
 
 static int ksgxd(void *p)
@@ -415,10 +434,10 @@ static int ksgxd(void *p)
 
 		wait_event_freezable(ksgxd_waitq,
 				     kthread_should_stop() ||
-				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
+				     sgx_should_reclaim_global(SGX_NR_HIGH_PAGES));
 
-		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_pages();
+		if (sgx_should_reclaim_global(SGX_NR_HIGH_PAGES))
+			sgx_reclaim_pages_global();
 
 		cond_resched();
 	}
@@ -585,7 +604,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
-		if (list_empty(&sgx_global_lru.reclaimable)) {
+		if (!sgx_can_reclaim_global()) {
 			page = ERR_PTR(-ENOMEM);
 			break;
 		}
@@ -600,7 +619,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
-		sgx_reclaim_pages();
+		sgx_reclaim_pages_global();
 		cond_resched();
 	}
 
@@ -613,7 +632,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 		sgx_put_cg(sgx_cg);
 	}
 
-	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
+	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
 		wake_up(&ksgxd_waitq);
 
 	return page;
-- 
2.43.0


