Return-Path: <cgroups+bounces-4629-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA1896671B
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 18:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E38B20CE8
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8300F1B9B2D;
	Fri, 30 Aug 2024 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MP5bqCxV"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424381B5820;
	Fri, 30 Aug 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036095; cv=none; b=gHZKgOFqrGMNYwDsi2VbLZxdCBVyOZlfohfO0Ohh9d59SH8dmz9N47qCGDLF5tZI9qlq8TuEO/YsNWw9uUeIvZKY6gO6lykS3Zkv3pXAOYNlZMU4nm8U/RRdo8nZhVRXVoo1hVfi6S+6eVx9en+4DwQY4+yXsss79w/JPyKulRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036095; c=relaxed/simple;
	bh=/lbtpIyXtuTFQtNRAZhbpbZmEUcgbTF0BGfZ94D+zjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fdx2gp6GdBrT2y6o+Kkex7QUaY7YgZvm1514o9jIkToFZGqQhZYtP9AQfQ+B7DWnxrcum3f2ktLIQ/YCrfck05WABJvUSbWQ4558DLKJLCh5GCP4Fcz2GSrwVVU0Yeu/69XL8M7N+AMo7GiQMVDotM/BjRglHKIzM8MOMDLOPKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MP5bqCxV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036093; x=1756572093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/lbtpIyXtuTFQtNRAZhbpbZmEUcgbTF0BGfZ94D+zjU=;
  b=MP5bqCxVmSEf5T47gN4DHOqTsEyW1t0Obk+RUS1wTct2/qoe/aMNu0GB
   2CzIBSGiBI+DTk9glQboz3PvOxzG+Paceo3iTVQeGrxWKoLMHR9p8Samk
   Uqnl6+fcBBAm8i95krKZEKLQkbj4fENh8YEqeQSs8C+TRMq0fCj9G8HlV
   BSipPZ2KI87RfXYV1VNsu/aZu+BNQDkNhtNYcz2pK830gOBnWxzY+x1oX
   nZ5JY3Ty5Ei+qhEywbm0rREhqbga7Iz+rh7riLQ9sOmLQA9RQRiDppx7h
   Tp/uwqWsNgPCza5UHTp5NwrUNIbsjaDJecIlRCYZqAmaV0yji93eLk6lT
   A==;
X-CSE-ConnectionGUID: aFaHWeDLSgSrM1XgvYBNQw==
X-CSE-MsgGUID: SLnL7oMzT9+7kWzfioQnzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34299936"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34299936"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:52 -0700
X-CSE-ConnectionGUID: zRrrewg9QfeJTnA7Z5BuXA==
X-CSE-MsgGUID: nzCvf2pESjSufhst/XkCIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="101440473"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:52 -0700
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
Subject: [PATCH v17 08/16] x86/sgx: Encapsulate uses of the global LRU
Date: Fri, 30 Aug 2024 09:40:29 -0700
Message-ID: <20240830164038.39343-9-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830164038.39343-1-haitao.huang@linux.intel.com>
References: <20240830164038.39343-1-haitao.huang@linux.intel.com>
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
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V17:
- remove comments in sgx_can_reclaim_global(), move it to later patch.
  (Kai)

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
 arch/x86/kernel/cpu/sgx/main.c | 56 +++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index bfbdb3247761..5c2c3940c234 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -37,6 +37,14 @@ static inline struct sgx_epc_lru_list *sgx_epc_page_lru(struct sgx_epc_page *epc
 	return &sgx_global_lru;
 }
 
+/*
+ * Check if there is any reclaimable page at global level.
+ */
+static inline bool sgx_can_reclaim_global(void)
+{
+	return !list_empty(&sgx_global_lru.reclaimable);
+}
+
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
 /* Nodes with one or more EPC sections. */
@@ -287,10 +295,10 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
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
@@ -299,7 +307,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  * problematic as it would increase the lock contention too much, which would
  * halt forward progress.
  */
-static void sgx_reclaim_pages(void)
+static void sgx_reclaim_pages(struct sgx_epc_lru_list *lru)
 {
 	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
 	struct sgx_backing backing[SGX_NR_TO_SCAN];
@@ -310,10 +318,9 @@ static void sgx_reclaim_pages(void)
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
 
@@ -328,7 +335,7 @@ static void sgx_reclaim_pages(void)
 			 */
 			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 	}
-	spin_unlock(&sgx_global_lru.lock);
+	spin_unlock(&lru->lock);
 
 	for (i = 0; i < cnt; i++) {
 		epc_page = chunk[i];
@@ -351,9 +358,9 @@ static void sgx_reclaim_pages(void)
 		continue;
 
 skip:
-		spin_lock(&sgx_global_lru.lock);
-		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
-		spin_unlock(&sgx_global_lru.lock);
+		spin_lock(&lru->lock);
+		list_add_tail(&epc_page->list, &lru->reclaimable);
+		spin_unlock(&lru->lock);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 
@@ -381,10 +388,15 @@ static void sgx_reclaim_pages(void)
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
@@ -394,8 +406,8 @@ static bool sgx_should_reclaim(unsigned long watermark)
  */
 void sgx_reclaim_direct(void)
 {
-	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		sgx_reclaim_pages();
+	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
+		sgx_reclaim_pages_global();
 }
 
 static int ksgxd(void *p)
@@ -415,10 +427,10 @@ static int ksgxd(void *p)
 
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
@@ -585,7 +597,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
-		if (list_empty(&sgx_global_lru.reclaimable)) {
+		if (!sgx_can_reclaim_global()) {
 			page = ERR_PTR(-ENOMEM);
 			break;
 		}
@@ -600,7 +612,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
-		sgx_reclaim_pages();
+		sgx_reclaim_pages_global();
 		cond_resched();
 	}
 
@@ -613,7 +625,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 		sgx_put_cg(sgx_cg);
 	}
 
-	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
+	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
 		wake_up(&ksgxd_waitq);
 
 	return page;
-- 
2.43.0


