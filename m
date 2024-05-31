Return-Path: <cgroups+bounces-3058-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF7C8D6C74
	for <lists+cgroups@lfdr.de>; Sat,  1 Jun 2024 00:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488A21F28ECB
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2024 22:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E9E13667E;
	Fri, 31 May 2024 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhOlmpVY"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667F132106;
	Fri, 31 May 2024 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717194401; cv=none; b=kpB/hSIPrpgD3yB/wYboygTNhyC29TFdqB+UNpqIbxGZ5P0urA3OlxrCBiauI2DsG44O13z+8C4cKfuWSNSR+9Ef4ZQH5D8Mwsgpe13qlSfFpVohBMTl0TbiKEpCEBFRw5ylTYkQ2uuXAbAR3SAFUZRnxeelZ2wrVoV23yeDZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717194401; c=relaxed/simple;
	bh=3xt1weILLGfju81ZRhocvOHuO3M+95xn3/6Ta724eHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVSndqDH9hm9DyRkqE65GCModPsdV5BJDNS3lEwyfPafijkmaCvpXgJoRu1D1ewmTbrHjReD1ZGnH7sjd+rBiSQCIRyM+SYSM+8mHj2C2u6y/9VnjXr0sAFFODJr9Bq5daLSRKCKva2pY6EMc+Xf1ViYzbDGHo78Dkq0idcd2YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhOlmpVY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717194399; x=1748730399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3xt1weILLGfju81ZRhocvOHuO3M+95xn3/6Ta724eHE=;
  b=EhOlmpVYShMEDl9PoNdHxwWN5Te2l8I9aZ9r/vdNdRxsF08toaeJ65rL
   lGxuUwINqxmtImedFbPcwHXCkehR1ao0r15hBCXpXfoZyG1SPStjSH/bu
   R9LPAFv/B8SUKPp3XwEfPniU+ktrgTKf3kQuVYJCjTIh41OS2pPdWjCdl
   3RRftq+Fn7+9o1XAVEFs7OHHqaoulkSff/oO97mQSqAjsyURcVAW2V5zR
   Q50wN8dxuORjG84G0HcrNii9b0TQdMkpr63TTY3U8tYNdayqy/D4hOoSm
   GroTvGSL+5AGU7+JzWEwOnmFsJF4cOlj5LUTPMkWjdJWmRSiMo2vpmELs
   g==;
X-CSE-ConnectionGUID: Rtzl08shTl+wybCTY2+XlA==
X-CSE-MsgGUID: nMfn3UvOTAaVeLiGLiCGIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13949816"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13949816"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 15:26:37 -0700
X-CSE-ConnectionGUID: y4iZr6WVQoGgd2LD1TM00w==
X-CSE-MsgGUID: ck+pfSqdREy0dLWF/hO4iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="40736942"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmviesa005.fm.intel.com with ESMTP; 31 May 2024 15:26:36 -0700
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
Subject: [PATCH v14 10/14] x86/sgx: Implement async reclamation for cgroup
Date: Fri, 31 May 2024 15:26:26 -0700
Message-Id: <20240531222630.4634-11-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240531222630.4634-1-haitao.huang@linux.intel.com>
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
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
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 136 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |   1 +
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 4406077acd1c..9e366068e0cd 100644
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
@@ -113,6 +167,65 @@ static struct misc_cg *sgx_cgroup_reclaim_pages(struct misc_cg *root, struct mis
 	return css_misc(next);
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
+	struct misc_cg *cg_next = NULL;
+
+	/*
+	 * This work func is scheduled by sgx_cgroup_try_charge() when it cannot
+	 * directly reclaim, i.e., EPC allocation in a fault handler. Waiting to
+	 * reclaim until the cgroup is actually at its limit is less performant,
+	 * as it means the task scheduling this asynchronous work is effectively
+	 * blocked until a worker makes its way through the global work queue.
+	 */
+	while (sgx_cgroup_should_reclaim(sgx_cg)) {
+		cg_next = sgx_cgroup_reclaim_pages(sgx_cg->cg, cg_next);
+		cond_resched();
+	}
+
+	if (cg_next != sgx_cg->cg)
+		put_misc_cg(cg_next);
+}
+
 static int __sgx_cgroup_try_charge(struct sgx_cgroup *epc_cg)
 {
 	if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE))
@@ -148,7 +261,8 @@ int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
 			goto out;
 
 		if (reclaim == SGX_NO_RECLAIM) {
-			ret = -ENOMEM;
+			queue_work(sgx_cg_wq, &sgx_cg->reclaim_work);
+			ret = -EBUSY;
 			goto out;
 		}
 
@@ -156,6 +270,9 @@ int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
 		cond_resched();
 	}
 
+	if (sgx_cgroup_should_reclaim(sgx_cg))
+		queue_work(sgx_cg_wq, &sgx_cg->reclaim_work);
+
 out:
 	if (cg_next != sgx_cg->cg)
 		put_misc_cg(cg_next);
@@ -179,12 +296,14 @@ static void sgx_cgroup_free(struct misc_cg *cg)
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
@@ -209,6 +328,21 @@ const struct misc_res_ops sgx_cgroup_ops = {
 
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


