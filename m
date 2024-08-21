Return-Path: <cgroups+bounces-4397-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BFB95927F
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 03:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4DE285F06
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 01:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ED815854C;
	Wed, 21 Aug 2024 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1WJlzsA"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC614F13D;
	Wed, 21 Aug 2024 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205272; cv=none; b=eYnfD6iLP7bJB+2btiH9t413PrGPgMvR0HXPW1DKddus5iYdBL+R/6XOa9FTGh+md5KeArUin4TdtMVZMdNUXNCQRxfucDlTJpqBeh6fk4UPj2MhkmcYnxqNqe3nK3VRSA2bq8kVnFLjlBOHfCeLCb5fSCxI78z/GTyK8Pl0/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205272; c=relaxed/simple;
	bh=ZdDKXWLL6fJHykCIgSD/hWSzJVp4jZ7dPn4jVPHmnK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsFOHgdq5dpi+PnbNTuNEFoPFH02UDr8ufyoFFVr1D2XsRQ6038F5HSFbuU+TDXqg7pUBpE2e5IqEUbfi7Yp1eNRo3hNUWN9QGBMclJ4HFTWpFIL2dHQyckh3QfgFEpCG+6LHcrbsIaItlZcn6UqF/y/nGzd9qpAU31/xosQsYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1WJlzsA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205270; x=1755741270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZdDKXWLL6fJHykCIgSD/hWSzJVp4jZ7dPn4jVPHmnK0=;
  b=Q1WJlzsAKQevoZWjrYBe2d8zLGcqnetb1t8Gy9xdYesH3pXWxYX0y5u9
   530+4HDASmR8hhp/KzsTYDv6LeXYUHnnLfqBPn7qMIaoNKCc06UFlvXFA
   sWMKoS4A8YkWoWWakUJZWC8GzDYZ16bb0PSFAwGCoj1SIOhT0K0+1ViKt
   BGbAiTefvid88yMfszWo9dYsAMvxfwvYgDvb6JJaL9QoDP60ziNzOV21e
   0pYhlzB/MVaLyYvdiI1Xk5TcV2/lbqzunXQLtRwTVVOfokVzBOBlRt8nt
   xpMeQR2ghh5LYntuF4G3A5aU8gZX34mvSLJ4YeGEOp6YEgMOyr2Jjc4Qj
   Q==;
X-CSE-ConnectionGUID: guk49F9DT1OJZ0+NyQkH4A==
X-CSE-MsgGUID: PB9PIKh1T6CHPX9gPQHtPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33107968"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33107968"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:23 -0700
X-CSE-ConnectionGUID: RyifEbjKSqeAcFhoN7bWjA==
X-CSE-MsgGUID: BPCC5zURQuW9oVZQoacxeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61078623"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:22 -0700
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
Subject: [PATCH v16 14/16] x86/sgx: Turn on per-cgroup EPC reclamation
Date: Tue, 20 Aug 2024 18:54:02 -0700
Message-ID: <20240821015404.6038-15-haitao.huang@linux.intel.com>
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

Previous patches have implemented all infrastructure needed for
per-cgroup EPC page tracking and reclaiming. But all reclaimable EPC
pages are still tracked in the global LRU as sgx_epc_page_lru() always
returns reference to the global LRU.

Change sgx_epc_page_lru() to return the LRU of the cgroup in which the
given EPC page is allocated.

Update sgx_can_reclaim_global(), to check emptiness of LRUs of all
cgroups, and update sgx_reclaim_pages_global(), to utilize
sgx_cgroup_reclaim_pages_global(), when EPC cgroup is enabled.

With these changes, the global reclamation and per-cgroup reclamation
both work properly with all pages tracked in per-cgroup LRUs.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V16:
- Separated out the global and direct reclamation to earlier patch.(Kai)

V14:
- Update global reclamation to use the new sgx_cgroup_reclaim_pages() to
iterate cgroups at lower level if the top cgroups are too busy.

V13:
- Use IS_ENABLED(CONFIG_CGROUP_MISC) in sgx_can_reclaim_global(). (Kai)

V12:
- Remove CONFIG_CGROUP_SGX_EPC, conditional compile SGX Cgroup for
CONFIGCONFIG_CGROUPMISC. (Jarkko)

V11:
- Reword the comments for global reclamation for allocation failure
after passing cgroup charging. (Kai)
- Add stub functions to remove ifdefs in c file (Kai)
- Add more detailed comments to clarify each page belongs to one cgroup, or the
root. (Kai)

V10:
- Add comment to clarify each page belongs to one cgroup, or the root by
default. (Kai)
- Merge the changes that expose sgx_cgroup_* functions to this patch.
- Add changes for sgx_reclaim_direct() that was missed previously.

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c |  2 +-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  6 ++++
 arch/x86/kernel/cpu/sgx/main.c       | 45 ++++++++++++++++++----------
 3 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index b7d60b2d878d..c3f0c7bc13c6 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -162,7 +162,7 @@ static inline u64 sgx_cgroup_max_pages_to_root(struct sgx_cgroup *sgx_cg)
  *
  * Return: %true if all cgroups under the specified root have empty LRU lists.
  */
-static bool sgx_cgroup_lru_empty(struct misc_cg *root)
+bool sgx_cgroup_lru_empty(struct misc_cg *root)
 {
 	struct cgroup_subsys_state *css_root;
 	struct cgroup_subsys_state *pos;
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index cf2b946d993e..cd957cf38204 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -27,6 +27,11 @@ static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_recl
 
 static inline void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg) { }
 
+static inline bool sgx_cgroup_lru_empty(struct misc_cg *root)
+{
+	return true;
+}
+
 static inline int __init sgx_cgroup_init(void)
 {
 	return 0;
@@ -91,6 +96,7 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
 
 int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
+bool sgx_cgroup_lru_empty(struct misc_cg *root);
 void sgx_cgroup_reclaim_pages_global(struct mm_struct *charge_mm);
 void sgx_cgroup_reclaim_direct(void);
 int __init sgx_cgroup_init(void);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 9a8f91ebd21b..2a23a10d882e 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -32,9 +32,30 @@ static DEFINE_XARRAY(sgx_epc_address_space);
  */
 static struct sgx_epc_lru_list sgx_global_lru;
 
+/*
+ * Get the per-cgroup or global LRU list that tracks the given reclaimable page.
+ */
 static inline struct sgx_epc_lru_list *sgx_epc_page_lru(struct sgx_epc_page *epc_page)
 {
+#ifdef CONFIG_CGROUP_MISC
+	/*
+	 * epc_page->sgx_cg here is never NULL during a reclaimable epc_page's
+	 * life between sgx_alloc_epc_page() and sgx_free_epc_page():
+	 *
+	 * In sgx_alloc_epc_page(), epc_page->sgx_cg is set to the return from
+	 * sgx_get_current_cg() which is the misc cgroup of the current task, or
+	 * the root by default even if the misc cgroup is disabled by kernel
+	 * command line.
+	 *
+	 * epc_page->sgx_cg is only unset by sgx_free_epc_page().
+	 *
+	 * This function is never used before sgx_alloc_epc_page() or after
+	 * sgx_free_epc_page().
+	 */
+	return &epc_page->sgx_cg->lru;
+#else
 	return &sgx_global_lru;
+#endif
 }
 
 /*
@@ -42,14 +63,10 @@ static inline struct sgx_epc_lru_list *sgx_epc_page_lru(struct sgx_epc_page *epc
  */
 static inline bool sgx_can_reclaim_global(void)
 {
-	/*
-	 * Now all EPC pages are still tracked in the @sgx_global_lru, so only
-	 * check @sgx_global_lru.
-	 *
-	 * When EPC pages are tracked in the actual per-cgroup LRUs,
-	 * replace with sgx_cgroup_lru_empty(misc_cg_root()).
-	 */
-	return !list_empty(&sgx_global_lru.reclaimable);
+	if (IS_ENABLED(CONFIG_CGROUP_MISC))
+		return !sgx_cgroup_lru_empty(misc_cg_root());
+	else
+		return !list_empty(&sgx_global_lru.reclaimable);
 }
 
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
@@ -411,14 +428,10 @@ static bool sgx_should_reclaim_global(unsigned long watermark)
 
 static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
 {
-	/*
-	 * Now all EPC pages are still tracked in the @sgx_global_lru.
-	 * Still reclaim from it.
-	 *
-	 * When EPC pages are tracked in the actual per-cgroup LRUs,
-	 * sgx_cgroup_reclaim_pages_global() will be called.
-	 */
-	sgx_reclaim_pages(&sgx_global_lru, charge_mm);
+	if (IS_ENABLED(CONFIG_CGROUP_MISC))
+		sgx_cgroup_reclaim_pages_global(charge_mm);
+	else
+		sgx_reclaim_pages(&sgx_global_lru, charge_mm);
 }
 
 /*
-- 
2.43.0


