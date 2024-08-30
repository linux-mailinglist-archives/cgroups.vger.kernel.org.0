Return-Path: <cgroups+bounces-4636-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F04596672E
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 18:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD7EEB23687
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697051BD51D;
	Fri, 30 Aug 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfnI5e8V"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B61BD001;
	Fri, 30 Aug 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036102; cv=none; b=R1nVR7pNfQGrr+LIprZ7p/k99ozLpnwV7AtMMlwTmcmV4SwNTifsZrFUXkFUyjCn+Hvw1OJuwRATT/AgpMzZzWpQ4VIZehwoYMuW96qZDSl2nFj2RYO8gO1z2CyRES/T4Kfm6h38QjKB4ILQL1PuonGDo8ZeawkQLcnAnC5pCnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036102; c=relaxed/simple;
	bh=BaZE4tbPVRUjlkLgAvEb+bxaQQNPjPs/SFIPFgoiTkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Djx9DUFzIoaAT61SZ8MkVp+d7tjQMgSs3OhcfWu+oFaFNoYh7rfLRuIAUgeO6ba3haak3U3l+Zs19XQR46kWJ1j74QCKxofh8JkBKbWdvzIATIBvfIq5bNMXjHUBzPljh8kkCAu+odGYnqR0cFHO0Mz7SqmzIkZ5Eq2AJ+vtG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfnI5e8V; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036100; x=1756572100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BaZE4tbPVRUjlkLgAvEb+bxaQQNPjPs/SFIPFgoiTkA=;
  b=JfnI5e8VfaZsS1Kvkid7eFvAUtrPSk6VVvaiMZC7avx7vJw7Pi60ra6D
   ZZyh1wk0r8MJ2yVJLYoy9mfNLMouDMhtYJqsXfQRMhlOtDa00bIZn9+rk
   KjSNYdaS9XB66PX4tBvJ0rpYrju3g8DQF8B3wfGvFlb+uJnPOkGztCU09
   leV5/EIUb4txgUb9Oi7XIpOWVW5xGeK5Abt3VtVkmDVjca0rCjqk17EeM
   begt+Yfl2yU/b6ZSBk3fbJFKhAIxDw2mUr0u/TnzqA7oWbWCzoRt/qlqC
   hjoeIiSxW3HUkkT7mHnA0Go2qPRgsG81qG5INPLz3hfjnXNOACS35vpBc
   A==;
X-CSE-ConnectionGUID: PGb420aoQZuR+tXOIlX8/Q==
X-CSE-MsgGUID: T/Pv0TevQTKIOY9mxG8jXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34300037"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34300037"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:52 -0700
X-CSE-ConnectionGUID: zk7Al/wCSU6yfJfrofns4w==
X-CSE-MsgGUID: ZML4hZeMS0Wy7X0VKG6qXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="101440467"
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
Subject: [PATCH v17 06/16] x86/sgx: Add sgx_epc_lru_list to encapsulate LRU list
Date: Fri, 30 Aug 2024 09:40:27 -0700
Message-ID: <20240830164038.39343-7-haitao.huang@linux.intel.com>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

Introduce a data structure to wrap the existing reclaimable list and its
spinlock. Each cgroup later will have one instance of this structure to
track EPC pages allocated for processes associated with the same cgroup.
Just like the global SGX reclaimer (ksgxd), an EPC cgroup reclaims pages
from the reclaimable list in this structure when its usage reaches near
its limit.

Use this structure to encapsulate the LRU list and its lock used by the
global reclaimer.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V17:
- Make comment for spinlock more accurate.

V15:
- Add comment for spinlock. (Jarkko, Kai)

V6:
- removed introduction to unreclaimables in commit message.

V4:
- Removed unneeded comments for the spinlock and the non-reclaimables.
(Kai, Jarkko)
- Revised the commit to add introduction comments for unreclaimables and
multiple LRU lists.(Kai)
- Reordered the patches: delay all changes for unreclaimables to
later, and this one becomes the first change in the SGX subsystem.

V3:
- Removed the helper functions and revised commit messages.
---
 arch/x86/kernel/cpu/sgx/main.c | 39 +++++++++++++++++-----------------
 arch/x86/kernel/cpu/sgx/sgx.h  | 16 ++++++++++++++
 2 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 395481e9ba55..b009d5bea40f 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -28,10 +28,9 @@ static DEFINE_XARRAY(sgx_epc_address_space);
 
 /*
  * These variables are part of the state of the reclaimer, and must be accessed
- * with sgx_reclaimer_lock acquired.
+ * with sgx_global_lru.lock acquired.
  */
-static LIST_HEAD(sgx_active_page_list);
-static DEFINE_SPINLOCK(sgx_reclaimer_lock);
+static struct sgx_epc_lru_list sgx_global_lru;
 
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
@@ -306,13 +305,13 @@ static void sgx_reclaim_pages(void)
 	int ret;
 	int i;
 
-	spin_lock(&sgx_reclaimer_lock);
+	spin_lock(&sgx_global_lru.lock);
 	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
-		if (list_empty(&sgx_active_page_list))
+		epc_page = list_first_entry_or_null(&sgx_global_lru.reclaimable,
+						    struct sgx_epc_page, list);
+		if (!epc_page)
 			break;
 
-		epc_page = list_first_entry(&sgx_active_page_list,
-					    struct sgx_epc_page, list);
 		list_del_init(&epc_page->list);
 		encl_page = epc_page->owner;
 
@@ -324,7 +323,7 @@ static void sgx_reclaim_pages(void)
 			 */
 			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 	}
-	spin_unlock(&sgx_reclaimer_lock);
+	spin_unlock(&sgx_global_lru.lock);
 
 	for (i = 0; i < cnt; i++) {
 		epc_page = chunk[i];
@@ -347,9 +346,9 @@ static void sgx_reclaim_pages(void)
 		continue;
 
 skip:
-		spin_lock(&sgx_reclaimer_lock);
-		list_add_tail(&epc_page->list, &sgx_active_page_list);
-		spin_unlock(&sgx_reclaimer_lock);
+		spin_lock(&sgx_global_lru.lock);
+		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
+		spin_unlock(&sgx_global_lru.lock);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 
@@ -380,7 +379,7 @@ static void sgx_reclaim_pages(void)
 static bool sgx_should_reclaim(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
-	       !list_empty(&sgx_active_page_list);
+	       !list_empty(&sgx_global_lru.reclaimable);
 }
 
 /*
@@ -432,6 +431,8 @@ static bool __init sgx_page_reclaimer_init(void)
 
 	ksgxd_tsk = tsk;
 
+	sgx_lru_init(&sgx_global_lru);
+
 	return true;
 }
 
@@ -507,10 +508,10 @@ static struct sgx_epc_page *__sgx_alloc_epc_page(void)
  */
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
 {
-	spin_lock(&sgx_reclaimer_lock);
+	spin_lock(&sgx_global_lru.lock);
 	page->flags |= SGX_EPC_PAGE_RECLAIMER_TRACKED;
-	list_add_tail(&page->list, &sgx_active_page_list);
-	spin_unlock(&sgx_reclaimer_lock);
+	list_add_tail(&page->list, &sgx_global_lru.reclaimable);
+	spin_unlock(&sgx_global_lru.lock);
 }
 
 /**
@@ -525,18 +526,18 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
  */
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
 {
-	spin_lock(&sgx_reclaimer_lock);
+	spin_lock(&sgx_global_lru.lock);
 	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
 		/* The page is being reclaimed. */
 		if (list_empty(&page->list)) {
-			spin_unlock(&sgx_reclaimer_lock);
+			spin_unlock(&sgx_global_lru.lock);
 			return -EBUSY;
 		}
 
 		list_del(&page->list);
 		page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 	}
-	spin_unlock(&sgx_reclaimer_lock);
+	spin_unlock(&sgx_global_lru.lock);
 
 	return 0;
 }
@@ -578,7 +579,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
-		if (list_empty(&sgx_active_page_list)) {
+		if (list_empty(&sgx_global_lru.reclaimable)) {
 			page = ERR_PTR(-ENOMEM);
 			break;
 		}
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index c5208da7c8eb..5a575a9427e7 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -117,6 +117,22 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 	return section->virt_addr + index * PAGE_SIZE;
 }
 
+/*
+ * Contains EPC pages tracked by the global reclaimer (ksgxd) or an EPC
+ * cgroup.
+ */
+struct sgx_epc_lru_list {
+	/* Lock for concurrent access to @reclaimable. */
+	spinlock_t lock;
+	struct list_head reclaimable;
+};
+
+static inline void sgx_lru_init(struct sgx_epc_lru_list *lru)
+{
+	spin_lock_init(&lru->lock);
+	INIT_LIST_HEAD(&lru->reclaimable);
+}
+
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
 void sgx_reclaim_direct(void);
-- 
2.43.0


