Return-Path: <cgroups+bounces-2734-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE228B80D9
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2024 21:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C641C2457F
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2024 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC11C232C;
	Tue, 30 Apr 2024 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6lbRfFU"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA719DF45;
	Tue, 30 Apr 2024 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506679; cv=none; b=jOcxoIsVu5BYSsMVKvEqHl+rjdZz9+kmljBSczTZNc30FMJSBx+3EP70DT37GIEZ79j9ctQSXoDJgrsl8BiDaW/Z1l/+q/Rirb+/cPUuStuPKP75l0kawG4eawsYUQV0aQzYzJKtve84gLIl/HNfspXusFKd5/quRtR98V5QgMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506679; c=relaxed/simple;
	bh=vd67voYNeFYGJbH8NvBLVIFAr3MlRQX4iimkRSDJacQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lUPUCrjk5C+B/GfOn5ZQ3/QLCtcB98HW9c8Ul0QohnP0ByLs9NGSC/lhF8++7/4pz5hhX1y7JutDOpZBUt0NY2RxcrZeXoJ+hyE5N5zYo8fS74cKWwKweiZ1jtFETXaFyhQ1NXh+t8VkZcA9hHDFUfid/GMog+m89moA3sUulBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6lbRfFU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714506678; x=1746042678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vd67voYNeFYGJbH8NvBLVIFAr3MlRQX4iimkRSDJacQ=;
  b=k6lbRfFUjLBaNyaP+IKYx4pR0BsvC+Zt/Bb74R5SF5TwJS3N4alpCGwc
   h7di8xx8h0nfe/OsjCHAvGpMdZCbcxgBsP/iqTUr7NxaSzH/WBN3FDbmP
   NFt8vBdTK3gTKtHzTSUqbLpjik4LD7cU+lWlxzTU8PWirSuQV4C1QPuwl
   1gIFNuyBCLPQhJl4J0KEM4/u7CCpl5XayDgwyi/LqvfCITcjxMMhPWE0H
   ORor89vPcVwGD1c0LxZRXA0L6LU+2hF+CvEtkUoRdk85FEhCUXd+1OQF2
   dwtzRRGiKxMkpy3Bj8fmk+jhCShz/yuxA3t+32AkPyvfcUwWIiojsjJdK
   A==;
X-CSE-ConnectionGUID: I+8AmNJCTPmGlc3zAyu9dQ==
X-CSE-MsgGUID: CiiySe6FSoynOgWfIhaFfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10355643"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10355643"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 12:51:11 -0700
X-CSE-ConnectionGUID: DMR1U50CRAyuvWlnaBcinQ==
X-CSE-MsgGUID: owEN2AdwTpCPEG1s8xWpFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31280323"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa003.jf.intel.com with ESMTP; 30 Apr 2024 12:51:10 -0700
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
Subject: [PATCH v13 09/14] x86/sgx: Implement async reclamation for cgroup
Date: Tue, 30 Apr 2024 12:51:03 -0700
Message-Id: <20240430195108.5676-10-haitao.huang@linux.intel.com>
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

In cases EPC pages need be allocated during a page fault and the cgroup
usage is near its limit, an asynchronous reclamation needs be triggered
to avoid blocking the page fault handling.

Create a workqueue, corresponding work item and function definitions
for EPC cgroup to support the asynchronous reclamation.

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
V13:
- Revert to BUG_ON() in case of workq allocation failure in init and
only alloc if misc is enabled.

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
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 135 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |   1 +
 2 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 3602616726ff..6368611cb29e 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -4,9 +4,63 @@
 #include<linux/slab.h>
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
@@ -89,6 +143,61 @@ static void sgx_cgroup_reclaim_pages(struct misc_cg *root)
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
@@ -122,13 +231,18 @@ int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
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
 
@@ -149,12 +263,14 @@ static void sgx_cgroup_free(struct misc_cg *cg)
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
@@ -179,6 +295,21 @@ const struct misc_res_ops sgx_cgroup_ops = {
 
 void sgx_cgroup_init(void)
 {
+	/*
+	 * misc root always exists even if misc is disabled from command line.
+	 * Initialize properly.
+	 */
 	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_cgroup_ops);
 	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
+
+	/*
+	 * Only alloc additional resource for workqueue when misc is enabled.
+	 * User can disable sgx or disable misc to avoid the failure
+	 */
+	if (cgroup_subsys_enabled(misc_cgrp_subsys)) {
+		sgx_cg_wq = alloc_workqueue("sgx_cg_wq", WQ_UNBOUND | WQ_FREEZABLE,
+					    WQ_UNBOUND_MAX_ACTIVE);
+		BUG_ON(!sgx_cg_wq);
+	}
+
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


