Return-Path: <cgroups+bounces-2212-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BD188F39C
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 01:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311012A41F9
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 00:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BC939ADD;
	Thu, 28 Mar 2024 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTQZaRn7"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35222C6A3;
	Thu, 28 Mar 2024 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585374; cv=none; b=NHKKjxV0RJouyOjdl69XXQ+veoxTKq+jpj+OvqM97emQxbYoNtDgh4nELma7srYPtP6pAdBQgKiRjpLH/3+P0Av0vL21+AKCKp0EgmmnBi0jZCj1lcpaVhv3Jv+rxhHAoMN/FR/LDJEPFMbv5Dd72O7nVEQ6DgLGUPBW243ZKbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585374; c=relaxed/simple;
	bh=PqB4qf6V61lDIyPU5Botu2zS1f1Pt/+NklL1YmmEbO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p+Humj/SB+pj8U4Fo/2Z4cXNkaMS8vbOs+TAVDE4IDnVaBa1qAk/uKmmHIbmc0LOOEdEZ2JMvx6bNbblh10Sc5VjJqZ/fKH+US1PHoYvRBxbmpT/8m8g9FeYWqzgd2E7Ui2FReGNn4RZn5DVYKjjICWK116lwhSj4B+mJrRU6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTQZaRn7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711585372; x=1743121372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PqB4qf6V61lDIyPU5Botu2zS1f1Pt/+NklL1YmmEbO8=;
  b=lTQZaRn7v8r3Uc6ebG7MFrFyVXPZpq0qFyMkB74eqQIcF8VCIbSOKJxo
   p9IfKgJK0fI2e+j3YkOGwbg8V2GMuFGNxPAFdVZ86/lnzbYPLlwSVh7ib
   d1SZDBcGEE4XjQgdRaTOPbQM+KKA/DvyN2PH41vO4GUP8PB6TnxDBVMfa
   HsysiD1SR030p45u0ci86whJ292zJnQP78Gs4nd9YQi3oRW1QDoe//6mW
   5SyKrYb2yicmPf23sDJd9ISD7uY8CYRBMbCOSECyy15Z1P+IFeaSuNErq
   wChfApux37AUSofVhse60F65yAykJsSCKgYi106ehf1LY157rue6SK160
   w==;
X-CSE-ConnectionGUID: uKlZXjg8Rk+ChJFlTeDleg==
X-CSE-MsgGUID: j3YTzuKPR1yNV82R4I5efw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6580739"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6580739"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 17:22:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16411818"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa009.jf.intel.com with ESMTP; 27 Mar 2024 17:22:32 -0700
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
Subject: [PATCH v10 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
Date: Wed, 27 Mar 2024 17:22:27 -0700
Message-Id: <20240328002229.30264-13-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328002229.30264-1-haitao.huang@linux.intel.com>
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
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
V10:
- Add comment to clarify each page belongs to one cgroup, or the root by
default. (Kai)
- Merge the changes that expose sgx_cgroup_* functions to this patch.
- Add changes for sgx_reclaim_direct() that was missed previously.

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c |  6 +++---
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  7 +++++++
 arch/x86/kernel/cpu/sgx/main.c       | 29 +++++++++++++++++++++++++++-
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 1defbf213e8d..cacd9e93344e 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -72,7 +72,7 @@ static inline u64 sgx_cgroup_max_pages_to_root(struct sgx_cgroup *sgx_cg)
  *
  * Return: %true if all cgroups under the specified root have empty LRU lists.
  */
-static bool sgx_cgroup_lru_empty(struct misc_cg *root)
+bool sgx_cgroup_lru_empty(struct misc_cg *root)
 {
 	struct cgroup_subsys_state *css_root;
 	struct cgroup_subsys_state *pos;
@@ -125,7 +125,7 @@ static bool sgx_cgroup_lru_empty(struct misc_cg *root)
  * triggering reclamation, and call cond_resched() in between iterations to
  * avoid indefinite blocking.
  */
-static void sgx_cgroup_reclaim_pages(struct misc_cg *root, struct mm_struct *charge_mm)
+void sgx_cgroup_reclaim_pages(struct misc_cg *root, struct mm_struct *charge_mm)
 {
 	struct cgroup_subsys_state *css_root;
 	struct cgroup_subsys_state *pos;
@@ -166,7 +166,7 @@ static void sgx_cgroup_reclaim_pages(struct misc_cg *root, struct mm_struct *cha
  * threshold (%SGX_CG_MIN_FREE_PAGE) and there are reclaimable pages within the
  * cgroup.
  */
-static bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg)
+bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg)
 {
 	u64 cur, max;
 
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index f66570d3ef42..8f55b38157da 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -28,6 +28,10 @@ static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_recl
 static inline void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg) { }
 
 static inline void sgx_cgroup_init(void) { }
+
+static inline void sgx_cgroup_reclaim_pages(struct misc_cg *root, struct mm_struct *charge_mm)
+{
+}
 #else
 struct sgx_cgroup {
 	struct misc_cg *cg;
@@ -65,6 +69,9 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
 
 int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
+bool sgx_cgroup_lru_empty(struct misc_cg *root);
+bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg);
+void sgx_cgroup_reclaim_pages(struct misc_cg *root,  struct mm_struct *charge_mm);
 void sgx_cgroup_init(void);
 
 #endif
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 7f92455d957d..68f28ff2d5ef 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -34,6 +34,16 @@ static struct sgx_epc_lru_list sgx_global_lru;
 
 static inline struct sgx_epc_lru_list *sgx_lru_list(struct sgx_epc_page *epc_page)
 {
+#ifdef CONFIG_CGROUP_SGX_EPC
+	if (epc_page->sgx_cg)
+		return &epc_page->sgx_cg->lru;
+
+	/*
+	 * This should not happen when cgroup is enabled: Every page belongs
+	 * to a cgroup, or the root by default.
+	 */
+	WARN_ON_ONCE(1);
+#endif
 	return &sgx_global_lru;
 }
 
@@ -42,7 +52,11 @@ static inline struct sgx_epc_lru_list *sgx_lru_list(struct sgx_epc_page *epc_pag
  */
 static inline bool sgx_can_reclaim(void)
 {
+#ifdef CONFIG_CGROUP_SGX_EPC
+	return !sgx_cgroup_lru_empty(misc_cg_root());
+#else
 	return !list_empty(&sgx_global_lru.reclaimable);
+#endif
 }
 
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
@@ -404,7 +418,10 @@ static bool sgx_should_reclaim(unsigned long watermark)
 
 static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
 {
-	sgx_reclaim_pages(&sgx_global_lru, charge_mm);
+	if (IS_ENABLED(CONFIG_CGROUP_SGX_EPC))
+		sgx_cgroup_reclaim_pages(misc_cg_root(), charge_mm);
+	else
+		sgx_reclaim_pages(&sgx_global_lru, charge_mm);
 }
 
 /*
@@ -414,6 +431,16 @@ static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
  */
 void sgx_reclaim_direct(void)
 {
+#ifdef CONFIG_CGROUP_SGX_EPC
+	struct sgx_cgroup *sgx_cg = sgx_get_current_cg();
+
+	/* Make sure there are some free pages at cgroup level */
+	if (sgx_cg && sgx_cgroup_should_reclaim(sgx_cg)) {
+		sgx_cgroup_reclaim_pages(sgx_cg->cg, current->mm);
+		sgx_put_cg(sgx_cg);
+	}
+#endif
+	/* Make sure there are some free pages at global level */
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
 		sgx_reclaim_pages_global(current->mm);
 }
-- 
2.25.1


