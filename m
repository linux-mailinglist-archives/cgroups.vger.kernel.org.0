Return-Path: <cgroups+bounces-2506-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2062E8A6198
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 05:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6BF2846F3
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 03:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A455A4C6;
	Tue, 16 Apr 2024 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzUrs65n"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E43FB9D;
	Tue, 16 Apr 2024 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237623; cv=none; b=GmTSM5Zr+Shw4QD+WUxshMwk8VnmShbT2EWrn22HxCyLXcrPUrC/humeGT4KbCpcZyfuuBYsinNXWHgA28H3pem22rv310hDUwWRX+h/4lT2+T5NE5D5XJ1EmuIvHhAYl7U59X+dyjMlbYZztqdOi6T81W1tENGtz4JVT+c9e0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237623; c=relaxed/simple;
	bh=O2WZ74MF/PWMdOQrJB4v5HT5JxlQ4zfl/6XFNK988SI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aFnkl77hplKu8VdanLXWX7b2ll8DzBTfKCG7iARR3qKiCsnvUS1e1Z/DzQbpUTadgy9wnGe5d3YWhI17xEsq8mHsP8DPe7vNoeinMjcMJrts4HiPdi39rMlJIo4avc5sspSsDoX6WJWtzJ8HeWVMvFmUiAfunpoJBKIBDOyXwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzUrs65n; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713237621; x=1744773621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O2WZ74MF/PWMdOQrJB4v5HT5JxlQ4zfl/6XFNK988SI=;
  b=SzUrs65nocU74zLv9sOC5rS4LbjouV9KHssWz9ZfdXkeSr4vrp4KwvuH
   eY/+Prbq+wlhAXzzsM416cP3WV1zvyv0hdjPi5psrlGuC+mDw1P+jhWP5
   bjhC/yz1W7JorfDT6GPq12fYTRrqClIbLXgdVXB6pn1dI5dy40K1BrvcF
   e75IlGNRZo7wOHmmDfI2dSFLyL7dGvRhfBLXAkGNbhVP7a05N1xKIx7Hf
   HIl6kOGUXPdjQOElIv4yJsFcLGneH5q/wtPpzNk4lp4qazim0R4/0ogsO
   UnvkLkxGh0nkwv6ki6mgQgWl6lQ+Xz+cvR4wMWbzsTYMzEN/mkRaVxCSR
   g==;
X-CSE-ConnectionGUID: 99NT4aDDQ2mbin0g6INjzA==
X-CSE-MsgGUID: zZV6Tw6KRNKt+hJnvSetDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="34043426"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="34043426"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 20:20:20 -0700
X-CSE-ConnectionGUID: mVJ23RTzRAy/HTbUMT8tPA==
X-CSE-MsgGUID: V+dkKdvBTB69ZsvKAW9lxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22193662"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmviesa008.fm.intel.com with ESMTP; 15 Apr 2024 20:20:19 -0700
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
Subject: [PATCH v12 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
Date: Mon, 15 Apr 2024 20:20:09 -0700
Message-Id: <20240416032011.58578-13-haitao.huang@linux.intel.com>
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
Tested-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
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
index 2044e0d64076..9d69608eadf6 100644
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
 #else /* CONFIG_CGROUP_MISC */
 
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
 
 #endif /* CONFIG_CGROUP_MISC */
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 11edbdb06782..9343f7d50649 100644
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
+	if (IS_ENABLED(CONFIG_CGROUP_MISC))
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


