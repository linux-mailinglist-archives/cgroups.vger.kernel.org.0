Return-Path: <cgroups+bounces-4393-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20C8959274
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 03:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2931E285BC9
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 01:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8537414E2D4;
	Wed, 21 Aug 2024 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBn5JnUV"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175141482E2;
	Wed, 21 Aug 2024 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205269; cv=none; b=h5G9cxWFlf+Ac7oK9rsVb/nFluwFZP7X6zgsBQI+ig2n8DaQbfC18Kbd7RXdnGL3tcyjmYUw1Q39FPTeRljlzoIE0RTndp/pti/ylDpW5Q3ihFlDu96Uy8LI0dPl2oK/JjiZwo36c2H4mAa39N2dLYfjyHk8AG+xDmYKWLtQwkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205269; c=relaxed/simple;
	bh=oEBuXaMkP8awFaO/oQjNOfcQEZM1A7RLQ1gGgJrOcAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeRu2VI+ldXP3QpnTSXLTWnClfUeIy2kCpJvnFP5L+1E9El9Ic9k8LqqsCO+z8ZK9Oc5KYLlSRv3dpRZEB4LiesMO2LVIFmJso/sUgElR44TGqNJxHxWlYbqjfXgGbg3rypxvyusPR8tW5p0NRiCU5STOEA+8nHI3ppgbdKn5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBn5JnUV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205267; x=1755741267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oEBuXaMkP8awFaO/oQjNOfcQEZM1A7RLQ1gGgJrOcAM=;
  b=CBn5JnUVfvyQYUaBEZPLEHEXKLne4TwsZNiC6WnWwl0Oi2DGLe6cq7id
   OSXQ/rMUSi4WsbNnxP0WB19qjCNSx7jdUerwvwsxLuZZh9EVi9Y5TJHzr
   nF0M+0i+9QJm+X0z0xWjJala+sdj2mCl+2OnIEpNIYZkHOUnT2J9Mm4+j
   /ufELk9aZNBIdbXDuL9YHL34FQ1goFueUXm7bIeKi+Q0RbjgwPt2yro0F
   Tv0ksB2tzaEqIfpQZiR3HsIJAKZ17fKUh/yLffmf9UMpxo9V9jw3ejETS
   VSz5VmS/pSE3DlCBRAVWYBLqaB1Fa7Akzx+M0wB+YEogtdDHK6fAaciJ8
   A==;
X-CSE-ConnectionGUID: htvRJsPQSUqQBShdlN3X4A==
X-CSE-MsgGUID: N/JffX8IQyyNovdINYHOMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33107925"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33107925"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:20 -0700
X-CSE-ConnectionGUID: UxHVoFeuRXihasEmWqP5+w==
X-CSE-MsgGUID: nU9wveUmSeGrv2k7tBsh9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61078609"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:19 -0700
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
Subject: [PATCH v16 10/16] x86/sgx: Implement async reclamation for cgroup
Date: Tue, 20 Aug 2024 18:53:58 -0700
Message-ID: <20240821015404.6038-11-haitao.huang@linux.intel.com>
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

From: Kristen Carlson Accardi <kristen@linux.intel.com>

In cases EPC pages need be allocated during a page fault and the cgroup
usage is near its limit, an asynchronous reclamation needs to be
triggered to avoid blocking the page fault handling.

To keep implementation simple, use a workqueue instead of kthread to
schedule the asynchronous reclamation work. Add corresponding work item and
function definitions for EPC cgroup.

In sgx_cgroup_try_charge(), if caller does not allow synchronous
reclamation, queue an asynchronous work into the workqueue.

The current global reclaimer, ksgxd, maintains a threshold for the
minimal free EPC pages to avoid thrashing when allocating EPC pages.
Similarly, only reclaiming EPC pages from the current cgroup when its
usage actually reaches limit could also cause thrashing.  To avoid that,
define a similar "per-cgroup usage threshold" and actively trigger
asynchronous per-cgroup EPC reclamation when the usage reaches the
threshold after try_charge() is successful.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V16:
- Destroy workqueue in sgx_cgroup_deinit()
- Reuse the new sgx_cgroup_reclaim_pages() to scan at least
  SGX_NR_TO_SCAN pages for each round async reclaim.
- Revise commit message. (Kai)

V15:
- Disable SGX when sgx_cgroup_init() fails instead of BUG_ON() (Jarkko)
- Reset capacity to zero when sgx_cgroup_init() fails. (Kai)
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
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 115 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |   4 +
 arch/x86/kernel/cpu/sgx/main.c       |   5 +-
 3 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index ce28efd20a15..c40f601d06d9 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -4,9 +4,37 @@
 #include<linux/slab.h>
 #include "epc_cgroup.h"
 
+/*
+ * The minimal free pages, or the minimal margin between limit and usage
+ * maintained by per-cgroup reclaimer.
+ *
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
 /*
  * Return the next descendant in a preorder walk, given a root, @root and a
  * cgroup, @cg, to start the walk from. Return @root if no descendant left for
@@ -100,6 +128,34 @@ static inline struct sgx_cgroup *sgx_cgroup_next_get(struct sgx_cgroup *root)
 	return p;
 }
 
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
@@ -159,6 +215,43 @@ static inline void sgx_cgroup_reclaim_pages(struct sgx_cgroup *root,
 	}
 }
 
+/* Check whether EPC reclaim should be performed for a given EPC cgroup.*/
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
+	 * Unless the limit is very low, maintain a minimal "credit" available
+	 * for charge to avoid per-cgroup reclamation and to serve new
+	 * allocation requests more quickly.
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
+	struct sgx_cgroup *root = container_of(work, struct sgx_cgroup, reclaim_work);
+
+	while (sgx_cgroup_should_reclaim(root)) {
+		sgx_cgroup_reclaim_pages(root, SGX_NR_TO_SCAN);
+		cond_resched();
+	}
+}
+
 static int __sgx_cgroup_try_charge(struct sgx_cgroup *epc_cg)
 {
 	if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE))
@@ -193,7 +286,8 @@ int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
 			goto out;
 
 		if (reclaim == SGX_NO_RECLAIM) {
-			ret = -ENOMEM;
+			queue_work(sgx_cg_wq, &sgx_cg->reclaim_work);
+			ret = -EBUSY;
 			goto out;
 		}
 
@@ -202,6 +296,9 @@ int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
 		cond_resched();
 	}
 
+	if (sgx_cgroup_should_reclaim(sgx_cg))
+		queue_work(sgx_cg_wq, &sgx_cg->reclaim_work);
+
 out:
 	return ret;
 }
@@ -224,6 +321,7 @@ static void sgx_cgroup_free(struct misc_cg *cg)
 	if (!sgx_cg)
 		return;
 
+	cancel_work_sync(&sgx_cg->reclaim_work);
 	/*
 	 * Notify ancestors to not reclaim from this dying cgroup.
 	 * Not start from this cgroup itself because at this point no reference
@@ -242,6 +340,7 @@ static void sgx_cgroup_free(struct misc_cg *cg)
 static void sgx_cgroup_misc_init(struct misc_cg *cg, struct sgx_cgroup *sgx_cg)
 {
 	sgx_lru_init(&sgx_cg->lru);
+	INIT_WORK(&sgx_cg->reclaim_work, sgx_cgroup_reclaim_work_func);
 	cg->res[MISC_CG_RES_SGX_EPC].priv = sgx_cg;
 	sgx_cg->cg = cg;
 	sgx_cg->next_cg = sgx_cg;
@@ -268,11 +367,25 @@ const struct misc_res_ops sgx_cgroup_ops = {
 
 int __init sgx_cgroup_init(void)
 {
+	sgx_cg_wq = alloc_workqueue("sgx_cg_wq", WQ_UNBOUND | WQ_FREEZABLE,
+				    WQ_UNBOUND_MAX_ACTIVE);
+	if (!sgx_cg_wq) {
+		pr_err("alloc_workqueue() failed for SGX cgroup.\n");
+		return -ENOMEM;
+	}
 	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
 
 	return 0;
 }
 
+/**
+ * Only called during init to unwind what's done in sgx_cgroup_init()
+ */
+void __init sgx_cgroup_deinit(void)
+{
+	destroy_workqueue(sgx_cg_wq);
+}
+
 /**
  * Register capacity and ops for SGX cgroup.
  * Only called at the end of sgx_init() when SGX is ready to handle the ops
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index da7f5315bff8..37364bdb797f 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -32,6 +32,8 @@ static inline int __init sgx_cgroup_init(void)
 	return 0;
 }
 
+static inline void __init sgx_cgroup_deinit(void) { }
+
 static inline void __init sgx_cgroup_register(void) { }
 
 #else /* CONFIG_CGROUP_MISC */
@@ -39,6 +41,7 @@ static inline void __init sgx_cgroup_register(void) { }
 struct sgx_cgroup {
 	struct misc_cg *cg;
 	struct sgx_epc_lru_list lru;
+	struct work_struct reclaim_work;
 	/*
 	 * Pointer to the next cgroup to scan when the per-cgroup reclamation
 	 * is triggered next time. It does not hold a reference to prevent it
@@ -86,6 +89,7 @@ int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
 int __init sgx_cgroup_init(void);
 void __init sgx_cgroup_register(void);
+void __init sgx_cgroup_deinit(void);
 
 #endif /* CONFIG_CGROUP_MISC */
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 303b06f39e4e..4bb8aa019c6a 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -1014,12 +1014,15 @@ static int __init sgx_init(void)
 	ret = sgx_drv_init();
 
 	if (sgx_vepc_init() && ret)
-		goto err_provision;
+		goto err_cgroup;
 
 	sgx_cgroup_register();
 
 	return 0;
 
+err_cgroup:
+	sgx_cgroup_deinit();
+
 err_provision:
 	misc_deregister(&sgx_dev_provision);
 
-- 
2.43.0


