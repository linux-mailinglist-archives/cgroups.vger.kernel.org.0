Return-Path: <cgroups+bounces-4640-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B516B966734
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 18:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E541F21660
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 16:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BA51BE862;
	Fri, 30 Aug 2024 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+qRexDD"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6351BDA88;
	Fri, 30 Aug 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036104; cv=none; b=BrFkpf4l1spkxP95tnwJ0O2LN3WScFIJVDHgYc1XGJZvUsqEqGpHPI7h3Rnm7JPdbdqFL8prlHUIt9DWFe4bHd+ipCeA+R3txszX2sewZzJ9KKZnIiCep9fBvwAuWr4HkDsB3Tv9lVLv7XfzA5fuEwi2G/6j2K7pJyiOZ35EPQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036104; c=relaxed/simple;
	bh=DFJqJfyqJgzpVWSIte70DFHcz7I0BjM4RG7nfiuqhbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPu/Ur0OqAwhA4SVBhvYqp2f2+ElUUq1vWsVsw9LqMg9IVmfVFfifJG9DMYEx+Ap+lSmGFJA5LN8rLWuY5u5pizC67x2lbVpgmRpAIeaDKYWzcx1/h87anCrX0vn2huEodssTcvETUnLeut7+tJsu9KUjLxRonO8IUBJd2zmqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+qRexDD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036102; x=1756572102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DFJqJfyqJgzpVWSIte70DFHcz7I0BjM4RG7nfiuqhbw=;
  b=T+qRexDDBm647/RhPSe1wsGMauykGGgb26OgdNcIkFQCCo6pvwzrgznm
   alQNFmmfB4in84Nsntw8yrvEGk3DuROQjHcU9clI/XVDHb1WwWoAh6zzB
   I6K8Qz+5lOBs+cTBmLDwfAGyAWuVoHPUqM7X7Z+BHUwyvvUDJZ0zQASRu
   exLAeHFU5vNLJj97PCLegqLsExTN5zYzUQOykr6WfOIPfvACq0jfbpf+C
   3S4ndZFDPTBNvOPU0FLO01jPJdMLs+gL1bkymB8ey4fFPGriHB28DzZXG
   WxBar0fGqsLxTaF1q7eOaNBWdh5k2mk83h/WhsB+aS2F/bhJ6FWOuQbOw
   w==;
X-CSE-ConnectionGUID: 0FJ+8EnCRyKe3X3HOxfqHg==
X-CSE-MsgGUID: pVMo5wGlQcShVfK2R7CIZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34300047"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34300047"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:52 -0700
X-CSE-ConnectionGUID: 5QUfa82bS1yMDZt1SCxENA==
X-CSE-MsgGUID: RGywgsBaTSuRAnQMosaYoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="101440481"
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
Subject: [PATCH v17 10/16] x86/sgx: Implement async reclamation for cgroup
Date: Fri, 30 Aug 2024 09:40:31 -0700
Message-ID: <20240830164038.39343-11-haitao.huang@linux.intel.com>
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
V17:
- Rename sgx_cgroup_{init,deinit} to sgx_cgroup_wq_{init,deinit}. (Kai)
- Remove '/**' (Kai)

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
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 124 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |   9 ++
 arch/x86/kernel/cpu/sgx/main.c       |   9 +-
 3 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index abbefa9e21d5..abcf71fe2cba 100644
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
@@ -266,6 +365,29 @@ const struct misc_res_ops sgx_cgroup_ops = {
 	.free = sgx_cgroup_free,
 };
 
+/*
+ * Initialize the workqueue for cgroups.
+ */
+int __init sgx_cgroup_wq_init(void)
+{
+	sgx_cg_wq = alloc_workqueue("sgx_cg_wq", WQ_UNBOUND | WQ_FREEZABLE,
+				    WQ_UNBOUND_MAX_ACTIVE);
+	if (!sgx_cg_wq) {
+		pr_err("alloc_workqueue() failed for SGX cgroup.\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * Only called during init to unwind what's done in sgx_cgroup_wq_init()
+ */
+void __init sgx_cgroup_wq_deinit(void)
+{
+	destroy_workqueue(sgx_cg_wq);
+}
+
 /*
  * Register capacity and ops for SGX cgroup and init the root cgroup.
  * Only called at the end of sgx_init() when SGX is ready to handle the ops
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index 879d5a4a2fcd..2285dbfc9462 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -28,12 +28,19 @@ static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_recl
 static inline void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg) { }
 
 static inline void __init sgx_cgroup_init(void) { }
+static inline int __init sgx_cgroup_wq_init(void)
+{
+	return 0;
+}
+
+static inline void __init sgx_cgroup_wq_deinit(void) { }
 
 #else /* CONFIG_CGROUP_MISC */
 
 struct sgx_cgroup {
 	struct misc_cg *cg;
 	struct sgx_epc_lru_list lru;
+	struct work_struct reclaim_work;
 	/*
 	 * Pointer to the next cgroup to scan when the per-cgroup reclamation
 	 * is triggered next time. It does not hold a reference to prevent it
@@ -80,6 +87,8 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
 int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
 void __init sgx_cgroup_init(void);
+int __init sgx_cgroup_wq_init(void);
+void __init sgx_cgroup_wq_deinit(void);
 
 #endif /* CONFIG_CGROUP_MISC */
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index d41cf6145975..7b1a19d659ab 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -993,6 +993,10 @@ static int __init sgx_init(void)
 	if (ret)
 		goto err_kthread;
 
+	ret = sgx_cgroup_wq_init();
+	if (ret)
+		goto err_provision;
+
 	/*
 	 * Always try to initialize the native *and* KVM drivers.
 	 * The KVM driver is less picky than the native one and
@@ -1004,12 +1008,15 @@ static int __init sgx_init(void)
 	ret = sgx_drv_init();
 
 	if (sgx_vepc_init() && ret)
-		goto err_provision;
+		goto err_cgroup;
 
 	sgx_cgroup_init();
 
 	return 0;
 
+err_cgroup:
+	sgx_cgroup_wq_deinit();
+
 err_provision:
 	misc_deregister(&sgx_dev_provision);
 
-- 
2.43.0


