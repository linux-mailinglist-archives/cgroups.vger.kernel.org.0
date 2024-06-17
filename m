Return-Path: <cgroups+bounces-3197-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD190AE47
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F4E1F24082
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 12:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E665C198A1D;
	Mon, 17 Jun 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsOvIicM"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EDD197A8E;
	Mon, 17 Jun 2024 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628824; cv=none; b=PU+SwBVA3S+bt0qQp8ymsp+xvKrslE5HxiV8Zo3+LiytYAZ4jPdcw9niON4zc0X/RS4/tal15707y1nDYZ/tRKYt3x/thMtkaX9c5r9MJxb7eZPjk+uikPRwk0pvl7W5v+JWXj+A3t8A/W4GOYLn//rntgZryzg+2eYQs2wHPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628824; c=relaxed/simple;
	bh=Gjs/lXPf+lPz6Yk7w+jlWbmKwIzpp5PI26wp/1sXzGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZw7vyFvhxZ8pAlGPh0odEQPTurEbJ4ldea4ykbGixtWM+riiQLwV5uKAZrezFX34mLai/DxBdC45p+L+hsGH2TsTcpimx07aIyMAjEzjp2HnsYlT58+Frf08AQBFtXF2QbfMlyGJXuXHa2vIRaqwiAfpgMO+1dhNghMGOGn+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsOvIicM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718628823; x=1750164823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gjs/lXPf+lPz6Yk7w+jlWbmKwIzpp5PI26wp/1sXzGM=;
  b=HsOvIicMq3OngF7sZHLkVxblh1Lx0Od2zrC9TGKxo02XwONuPZqnFo0j
   kuz9ncxvQwkAofzYQ7uWsgHWvBZ9KlrhF2SmKFCBXL7Fz9M0EWU3zSHaE
   KQl7YQYndtwc/nnOn5uavQLbk5meBt3ooM3AxlT+YET2wA1L9sWyBFlJ6
   1RdQyIQhIawmh/wSzzJrr2NddGEZkayGQGMgIVOXn7BnBRzpn+Ib4uibo
   yyNp+4C9xw3ciTnXNJ9rbc0VbC7SJ2fBJEDxJO2ovNCNc3OuqVrosetff
   WIsNMxMR/NkzjtwYqTwSXFrdfhN/ODHQbQJnajn/n2T73xnns4d+NYZTf
   A==;
X-CSE-ConnectionGUID: j4F6ueNcS76HKIOcdzAwTQ==
X-CSE-MsgGUID: YbK6M1uyTE+6k1cZvHnZKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15570884"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15570884"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:41 -0700
X-CSE-ConnectionGUID: jkyFS3OgQyOZcDGKroJYBg==
X-CSE-MsgGUID: HR48wdSpS5KVVhlmCQyuUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="72387528"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:40 -0700
From: "Huang, Haitao" <haitao.huang@linux.intel.com>
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
Subject: [PATCH v15 06/14] x86/sgx: Add sgx_epc_lru_list to encapsulate LRU list
Date: Mon, 17 Jun 2024 05:53:13 -0700
Message-ID: <20240617125321.36658-7-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617125321.36658-1-haitao.huang@linux.intel.com>
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
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
index 8c30257e0953..8ad6040953e6 100644
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
index fae8eef10232..e21c5a134a5e 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -114,6 +114,22 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 	return section->virt_addr + index * PAGE_SIZE;
 }
 
+/*
+ * Contains EPC pages tracked by the global reclaimer (ksgxd) or an EPC
+ * cgroup.
+ */
+struct sgx_epc_lru_list {
+	/* Use this lock to protect access from multiple reclamation worker threads */
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


