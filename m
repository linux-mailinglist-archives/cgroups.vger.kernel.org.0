Return-Path: <cgroups+bounces-2502-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0DD8A618E
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 05:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7353284133
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 03:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779B3D3AC;
	Tue, 16 Apr 2024 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AimW/HoS"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141463A27B;
	Tue, 16 Apr 2024 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237620; cv=none; b=tmXIwoaR3ufcWDYN/tJFuqX5p5YIifpg9zJCh62WIyfAVJQEubg4E8nvdvkhzoUdOQRaeUbL+Qz8BryTHwFuQlaAwWGyF1cGU6nMfjEiPlL7lJl/zTr5I6IwxZd/SpfOv7wHr4upAmmdpi/1ilMweVhriQ7nAO/OSYJ/Lgfydf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237620; c=relaxed/simple;
	bh=kSv4VCFkt1Su+sAegSUMV+MBdKGYK3umXURm0lZv4lU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4hdpZamVi2jJqDGdmey2Tw/uUEOde6zLV+hy8oLWWZRB3d+1uppIsQFf2Q5P9kHQVdVV0C0hWkQVddQ7oWE0u+Z1U295Fp6ZjLN91fyFDpw5+N0cq7Xjckb8cU6gJQaJxqPkXsWb2wFeQqJFHI0g8YqIdkU7ewRfwHjyiyveDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AimW/HoS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713237619; x=1744773619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kSv4VCFkt1Su+sAegSUMV+MBdKGYK3umXURm0lZv4lU=;
  b=AimW/HoSQThTTjzSTQ88aSTuPOeBG+t+OgVx/DfVnbbZvvJ2o9BNM/lc
   PK8xI75vnhf8zSxSgwfSPrtR8yDsFFWGWlqE+J7Klmudex3SLoG2cH/QO
   HSPK8CLK6JtEJxMNsfqkzpJe/hyEoBpYLnqOwzWg+3lRXn2eGN9wtoQab
   67853SczOrPhDGfQFG3uqJAaS8zQbrJRZMfbTljpQn04G8ZP9alyF8Od8
   nA/oykxaDQjns3V8dQCptQNtFNrSEavGliguIJxZv6QjSt+hMkZrv9r7c
   5yQvtLZJYxfthPVf61p+nHxeBUSuGdeEiE21PmCl4KnkgpTlLUWnLWBLX
   Q==;
X-CSE-ConnectionGUID: gl+YYgZKRcKfAQ0nKX/8ng==
X-CSE-MsgGUID: DbeuHAOwTAiEy+cPnZSBhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="34043395"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="34043395"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 20:20:18 -0700
X-CSE-ConnectionGUID: 1t480pbxTuCQwQ/0nqePIg==
X-CSE-MsgGUID: VMUYIYkvR6aLghiU7DqQgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22193630"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmviesa008.fm.intel.com with ESMTP; 15 Apr 2024 20:20:17 -0700
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
Subject: [PATCH v12 09/14] x86/sgx: Implement async reclamation for cgroup
Date: Mon, 15 Apr 2024 20:20:06 -0700
Message-Id: <20240416032011.58578-10-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416032011.58578-1-haitao.huang@linux.intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristen Carlson Accardi <kristen@linux.intel.com>

In cases EPC pages need be allocated during a page fault and the cgroup
usage is near its limit, an asynchronous reclamation needs be triggered
to avoid blocking the page fault handling.

Create a workqueue, corresponding work item and function definitions
for EPC cgroup to support the asynchronous reclamation.

In case the workqueue allocation is failed during init, disable cgroup.

In sgx_cgroup_try_charge(), if caller does not allow synchronous
reclamation, queue an asynchronous work into the workqueue.

Reclaiming only when the usage is at or very close to the limit would
cause thrashing. To avoid that, before returning from
sgx_cgroup_try_charge(), check the need for reclamation (usage too close
to the limit), queue an async work if needed, similar to how the global
reclaimer wakes up its reclaiming thread after each allocation in
sgx_alloc_epc_pages().

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V11:
- Print error instead of WARN (Kai)
- Add check for need to queue an async reclamation before returning from
try_charge(), do so if needed. This is to be consistent with global
reclaimer to minimize thrashing during allocation time.

V10:
- Split asynchronous flow in separate patch. (Kai)
- Consider cgroup disabled when the workqueue allocation fail during
init. (Kai)
- Abstract out sgx_cgroup_should_reclaim().

V9:
- Add comments for static variables. (Jarkko)

V8:
- Remove alignment for substructure variables. (Jarkko)

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 129 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |   1 +
 2 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 74d403d1e0d4..8151371a198b 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -5,9 +5,63 @@
 #include <linux/kernel.h>
 #include "epc_cgroup.h"
 
+/*
+ * The minimal free pages maintained by per-cgroup reclaimer
+ * Set this to the low threshold used by the global reclaimer, ksgxd.
+ */
+#define SGX_CG_MIN_FREE_PAGE	(SGX_NR_LOW_PAGES)
+
+/*
+ * If the cgroup limit is close to SGX_CG_MIN_FREE_PAGE, maintaining the minimal
+ * free pages would barely leave any page for use, causing excessive reclamation
+ * and thrashing.
+ *
+ * Define the following limit, below which cgroup does not maintain the minimal
+ * free page threshold. Set this to quadruple of the minimal so at least 75%
+ * pages used without being reclaimed.
+ */
+#define SGX_CG_LOW_LIMIT	(SGX_CG_MIN_FREE_PAGE * 4)
+
 /* The root SGX EPC cgroup */
 static struct sgx_cgroup sgx_cg_root;
 
+/*
+ * The work queue that reclaims EPC pages in the background for cgroups.
+ *
+ * A cgroup schedules a work item into this queue to reclaim pages within the
+ * same cgroup when its usage limit is reached and synchronous reclamation is not
+ * an option, i.e., in a page fault handler.
+ */
+static struct workqueue_struct *sgx_cg_wq;
+
+static inline u64 sgx_cgroup_page_counter_read(struct sgx_cgroup *sgx_cg)
+{
+	return atomic64_read(&sgx_cg->cg->res[MISC_CG_RES_SGX_EPC].usage) / PAGE_SIZE;
+}
+
+static inline u64 sgx_cgroup_max_pages(struct sgx_cgroup *sgx_cg)
+{
+	return READ_ONCE(sgx_cg->cg->res[MISC_CG_RES_SGX_EPC].max) / PAGE_SIZE;
+}
+
+/*
+ * Get the lower bound of limits of a cgroup and its ancestors. Used in
+ * sgx_cgroup_should_reclaim() to determine if EPC usage of a cgroup is
+ * close to its limit or its ancestors' hence reclamation is needed.
+ */
+static inline u64 sgx_cgroup_max_pages_to_root(struct sgx_cgroup *sgx_cg)
+{
+	struct misc_cg *i = sgx_cg->cg;
+	u64 m = U64_MAX;
+
+	while (i) {
+		m = min(m, READ_ONCE(i->res[MISC_CG_RES_SGX_EPC].max));
+		i = misc_cg_parent(i);
+	}
+
+	return m / PAGE_SIZE;
+}
+
 /**
  * sgx_cgroup_lru_empty() - check if a cgroup tree has no pages on its LRUs
  * @root:	Root of the tree to check
@@ -90,6 +144,61 @@ static void sgx_cgroup_reclaim_pages(struct misc_cg *root)
 	rcu_read_unlock();
 }
 
+/**
+ * sgx_cgroup_should_reclaim() - check if EPC reclamation is needed for a cgroup
+ * @sgx_cg: The cgroup to be checked.
+ *
+ * This function can be used to guard a call to sgx_cgroup_reclaim_pages() where
+ * the minimal number of free page needs be maintained for the cgroup to make
+ * good forward progress.
+ *
+ * Return: %true if number of free pages available for the cgroup below a
+ * threshold (%SGX_CG_MIN_FREE_PAGE) and there are reclaimable pages within the
+ * cgroup.
+ */
+static bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg)
+{
+	u64 cur, max;
+
+	if (sgx_cgroup_lru_empty(sgx_cg->cg))
+		return false;
+
+	max = sgx_cgroup_max_pages_to_root(sgx_cg);
+
+	/*
+	 * Unless the limit is very low, maintain a minimal number of free pages
+	 * so there is always a few pages available to serve new allocation
+	 * requests quickly.
+	 */
+	if (max > SGX_CG_LOW_LIMIT)
+		max -= SGX_CG_MIN_FREE_PAGE;
+
+	cur = sgx_cgroup_page_counter_read(sgx_cg);
+
+	return (cur >= max);
+}
+
+/*
+ * Asynchronous work flow to reclaim pages from the cgroup when the cgroup is
+ * at/near its maximum capacity.
+ */
+static void sgx_cgroup_reclaim_work_func(struct work_struct *work)
+{
+	struct sgx_cgroup *sgx_cg = container_of(work, struct sgx_cgroup, reclaim_work);
+
+	/*
+	 * This work func is scheduled by sgx_cgroup_try_charge() when it cannot
+	 * directly reclaim, i.e., EPC allocation in a fault handler. Waiting to
+	 * reclaim until the cgroup is actually at its limit is less performant,
+	 * as it means the task scheduling this asynchronous work is effectively
+	 * blocked until a worker makes its way through the global work queue.
+	 */
+	while (sgx_cgroup_should_reclaim(sgx_cg)) {
+		sgx_cgroup_reclaim_pages(sgx_cg->cg);
+		cond_resched();
+	}
+}
+
 static int __sgx_cgroup_try_charge(struct sgx_cgroup *epc_cg)
 {
 	if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE))
@@ -117,19 +226,28 @@ int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
 {
 	int ret;
 
+	/* cgroup disabled due to wq allocation failure during sgx_cgroup_init(). */
+	if (!sgx_cg_wq)
+		return 0;
+
 	for (;;) {
 		ret = __sgx_cgroup_try_charge(sgx_cg);
 
 		if (ret != -EBUSY)
 			return ret;
 
-		if (reclaim == SGX_NO_RECLAIM)
-			return -ENOMEM;
+		if (reclaim == SGX_NO_RECLAIM) {
+			queue_work(sgx_cg_wq, &sgx_cg->reclaim_work);
+			return -EBUSY;
+		}
 
 		sgx_cgroup_reclaim_pages(sgx_cg->cg);
 		cond_resched();
 	}
 
+	if (sgx_cgroup_should_reclaim(sgx_cg))
+		queue_work(sgx_cg_wq, &sgx_cg->reclaim_work);
+
 	return 0;
 }
 
@@ -150,12 +268,14 @@ static void sgx_cgroup_free(struct misc_cg *cg)
 	if (!sgx_cg)
 		return;
 
+	cancel_work_sync(&sgx_cg->reclaim_work);
 	kfree(sgx_cg);
 }
 
 static void sgx_cgroup_misc_init(struct misc_cg *cg, struct sgx_cgroup *sgx_cg)
 {
 	sgx_lru_init(&sgx_cg->lru);
+	INIT_WORK(&sgx_cg->reclaim_work, sgx_cgroup_reclaim_work_func);
 	cg->res[MISC_CG_RES_SGX_EPC].priv = sgx_cg;
 	sgx_cg->cg = cg;
 }
@@ -182,4 +302,9 @@ void sgx_cgroup_init(void)
 {
 	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_cgroup_ops);
 	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
+
+	sgx_cg_wq = alloc_workqueue("sgx_cg_wq", WQ_UNBOUND | WQ_FREEZABLE, WQ_UNBOUND_MAX_ACTIVE);
+
+	if (!sgx_cg_wq)
+		pr_err("SGX EPC cgroup disabled: alloc_workqueue() failed.\n");
 }
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index 538524f5669d..2044e0d64076 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -34,6 +34,7 @@ static inline void sgx_cgroup_init(void) { }
 struct sgx_cgroup {
 	struct misc_cg *cg;
 	struct sgx_epc_lru_list lru;
+	struct work_struct reclaim_work;
 };
 
 static inline struct sgx_cgroup *sgx_cgroup_from_misc_cg(struct misc_cg *cg)
-- 
2.25.1


