Return-Path: <cgroups+bounces-2428-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6AE89FFC7
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 20:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853B028B669
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 18:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37891836EB;
	Wed, 10 Apr 2024 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMhH24Di"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC017BB2B;
	Wed, 10 Apr 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773569; cv=none; b=UvQwFjFY+w35SW+PmWgpjgmixmOoLj1F8LaVgUS2HVzEzGYM26oVc1oS/uTGJnBUsJ3dhIb2Ir0TXdN3FkZjkieI3mjO4U9BWyCFbaIFjT/eNvjubaV95bLUM4Urw4bEvZMpyAJCKdQrKwWCZYuUnR1jBoFKjzf9SzrBz7Ae0jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773569; c=relaxed/simple;
	bh=coxnC+5OWwQ3xzvxGjYx39P7s4u8Pguie9CRrwvvlNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DxvDEPnaTW5kOTnb+rj+rB5E6X0DNcgGLaP+hWQ2ANvN9o+ZjTLZ9n3geRh/T4Z9q0I45GYnefTQPDPTjRCnJTAdIReLOE/MYFSKN25uWdbBhW387jl4Zx68K16OMqMZ3k3Wd2XqWSbQfm1Ytl07CmxXrfIoYaL4kdM5ju749pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMhH24Di; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712773568; x=1744309568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=coxnC+5OWwQ3xzvxGjYx39P7s4u8Pguie9CRrwvvlNY=;
  b=QMhH24DiX6FpEeyw4fDNV2vSqVfXYSZ5fpe7E87XOJ6V5yxs9Ccn18CQ
   Ox6yK+OI5eMSAFCF/rZAeOW8IqSkxKDIBc77jNNgBmhs+JuxQynUei0ap
   gkuYMHB+Iq+jLZ/aB2gS4/nMpv4X/JwytoYdsm8UZ/rgzAW0LHFq3aYRl
   PFBqSKZ9xReCSTyHcB9BDwxmLHNeYdxyxXfeKtPPkaD5Pow/JqxTQSHrh
   jQx8QEO8qiCTcsQqbY7siocfIV4DxUwJwEUufmgII1qcN7Ntw3wKC9RKg
   tdkw5IiNvWWNQ0XVfDLnCZ8CrtTfBdX4HcoOdSi1jS+xE5O+MXr8MY0eW
   Q==;
X-CSE-ConnectionGUID: gbHvQ8E3SAeQMeWu0di7fw==
X-CSE-MsgGUID: aMc0IUnLR4a4oDS1xktqlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19583742"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="19583742"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:26:02 -0700
X-CSE-ConnectionGUID: CD8+omyEQ5GA4ejrLIeDSg==
X-CSE-MsgGUID: PVFK8tNpQ2iZWMuqIsXUZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="21232452"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2024 11:26:01 -0700
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
Subject: [PATCH v11 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
Date: Wed, 10 Apr 2024 11:25:56 -0700
Message-Id: <20240410182558.41467-13-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410182558.41467-1-haitao.huang@linux.intel.com>
References: <20240410182558.41467-1-haitao.huang@linux.intel.com>
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
pages are still tracked in the global LRU as sgx_lru_list() returns hard
coded reference to the global LRU.

Change sgx_lru_list() to return the LRU of the cgroup in which the given
EPC page is allocated.

This makes all EPC pages tracked in per-cgroup LRUs and the global
reclaimer (ksgxd) will not be able to reclaim any pages from the global
LRU. However, in cases of over-committing, i.e., the sum of cgroup
limits greater than the total capacity, cgroups may never reclaim but
the total usage can still be near the capacity. Therefore a global
reclamation is still needed in those cases and it should be performed
from the root cgroup.

Modify sgx_reclaim_pages_global(), to reclaim from the root EPC cgroup
when cgroup is enabled, otherwise from the global LRU. Export
sgx_cgroup_reclaim_pages() in the header file so it can be reused for
this purpose.

Similarly, modify sgx_can_reclaim(), to check emptiness of LRUs of all
cgroups when EPC cgroup is enabled, otherwise only check the global LRU.
Export sgx_cgroup_lru_empty() so it can be reused for this purpose.

Finally, change sgx_reclaim_direct(), to check and ensure there are free
pages at cgroup level so forward progress can be made by the caller.
Export sgx_cgroup_should_reclaim() for reuse.

With these changes, the global reclamation and per-cgroup reclamation
both work properly with all pages tracked in per-cgroup LRUs.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
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
 arch/x86/kernel/cpu/sgx/epc_cgroup.c |  6 ++--
 arch/x86/kernel/cpu/sgx/epc_cgroup.h | 27 +++++++++++++++++
 arch/x86/kernel/cpu/sgx/main.c       | 43 ++++++++++++++++++++++++++--
 3 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 2efc33476b0b..16fe0e1574ec 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -68,7 +68,7 @@ static inline u64 sgx_cgroup_max_pages_to_root(struct sgx_cgroup *sgx_cg)
  *
  * Return: %true if all cgroups under the specified root have empty LRU lists.
  */
-static bool sgx_cgroup_lru_empty(struct misc_cg *root)
+bool sgx_cgroup_lru_empty(struct misc_cg *root)
 {
 	struct cgroup_subsys_state *css_root;
 	struct cgroup_subsys_state *pos;
@@ -116,7 +116,7 @@ static bool sgx_cgroup_lru_empty(struct misc_cg *root)
  * the LRUs are recently accessed, i.e., considered "too young" to reclaim, no
  * page will actually be reclaimed after walking the whole tree.
  */
-static void sgx_cgroup_reclaim_pages(struct misc_cg *root, struct mm_struct *charge_mm)
+void sgx_cgroup_reclaim_pages(struct misc_cg *root, struct mm_struct *charge_mm)
 {
 	struct cgroup_subsys_state *css_root;
 	struct cgroup_subsys_state *pos;
@@ -157,7 +157,7 @@ static void sgx_cgroup_reclaim_pages(struct misc_cg *root, struct mm_struct *cha
  * threshold (%SGX_CG_MIN_FREE_PAGE) and there are reclaimable pages within the
  * cgroup.
  */
-static bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg)
+bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg)
 {
 	u64 cur, max;
 
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index 9a2d51a91e5c..963aa19d3c47 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -13,6 +13,11 @@
 #define MISC_CG_RES_SGX_EPC MISC_CG_RES_TYPES
 struct sgx_cgroup;
 
+static inline struct misc_cg *misc_from_sgx(struct sgx_cgroup *sgx_cg)
+{
+	return NULL;
+}
+
 static inline struct sgx_cgroup *sgx_get_current_cg(void)
 {
 	return NULL;
@@ -27,8 +32,22 @@ static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_recl
 
 static inline void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg) { }
 
+static inline bool sgx_cgroup_lru_empty(struct misc_cg *root)
+{
+	return true;
+}
+
+static inline bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg)
+{
+	return false;
+}
+
 static inline void sgx_cgroup_init(void) { }
 
+static inline void sgx_cgroup_reclaim_pages(struct misc_cg *root, struct mm_struct *charge_mm)
+{
+}
+
 #else
 
 struct sgx_cgroup {
@@ -37,6 +56,11 @@ struct sgx_cgroup {
 	struct work_struct reclaim_work;
 };
 
+static inline struct misc_cg *misc_from_sgx(struct sgx_cgroup *sgx_cg)
+{
+	return sgx_cg->cg;
+}
+
 static inline struct sgx_cgroup *sgx_cgroup_from_misc_cg(struct misc_cg *cg)
 {
 	return (struct sgx_cgroup *)(cg->res[MISC_CG_RES_SGX_EPC].priv);
@@ -67,6 +91,9 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
 
 int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
+bool sgx_cgroup_lru_empty(struct misc_cg *root);
+bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg);
+void sgx_cgroup_reclaim_pages(struct misc_cg *root,  struct mm_struct *charge_mm);
 void sgx_cgroup_init(void);
 
 #endif
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 11edbdb06782..e42e4a972752 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -32,9 +32,30 @@ static DEFINE_XARRAY(sgx_epc_address_space);
  */
 static struct sgx_epc_lru_list sgx_global_lru;
 
+/*
+ * Get the per-cgroup or global LRU list that tracks the given reclaimable page.
+ */
 static inline struct sgx_epc_lru_list *sgx_lru_list(struct sgx_epc_page *epc_page)
 {
+#ifdef CONFIG_CGROUP_SGX_EPC
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
@@ -42,7 +63,8 @@ static inline struct sgx_epc_lru_list *sgx_lru_list(struct sgx_epc_page *epc_pag
  */
 static inline bool sgx_can_reclaim(void)
 {
-	return !list_empty(&sgx_global_lru.reclaimable);
+	return !sgx_cgroup_lru_empty(misc_cg_root()) ||
+	       !list_empty(&sgx_global_lru.reclaimable);
 }
 
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
@@ -404,7 +426,10 @@ static bool sgx_should_reclaim(unsigned long watermark)
 
 static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
 {
-	sgx_reclaim_pages(&sgx_global_lru, charge_mm);
+	if (IS_ENABLED(CONFIG_CGROUP_SGX_EPC))
+		sgx_cgroup_reclaim_pages(misc_cg_root(), charge_mm);
+	else
+		sgx_reclaim_pages(&sgx_global_lru, charge_mm);
 }
 
 /*
@@ -414,6 +439,14 @@ static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
  */
 void sgx_reclaim_direct(void)
 {
+	struct sgx_cgroup *sgx_cg = sgx_get_current_cg();
+
+	/* Make sure there are some free pages at cgroup level */
+	if (sgx_cg && sgx_cgroup_should_reclaim(sgx_cg)) {
+		sgx_cgroup_reclaim_pages(misc_from_sgx(sgx_cg), current->mm);
+		sgx_put_cg(sgx_cg);
+	}
+	/* Make sure there are some free pages at global level */
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
 		sgx_reclaim_pages_global(current->mm);
 }
@@ -616,6 +649,12 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
+		/*
+		 * At this point, the usage within this cgroup is under its
+		 * limit but there is no physical page left for allocation.
+		 * Perform a global reclaim to get some pages released from any
+		 * cgroup with reclaimable pages.
+		 */
 		sgx_reclaim_pages_global(current->mm);
 		cond_resched();
 	}
-- 
2.25.1


