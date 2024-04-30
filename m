Return-Path: <cgroups+bounces-2729-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A97598B80D0
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2024 21:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223BE1F24F64
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2024 19:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF4E1BED67;
	Tue, 30 Apr 2024 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2MnmrXP"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0AE1A0AF0;
	Tue, 30 Apr 2024 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506675; cv=none; b=iF+aIiZCNI6cGBQJ9erJAkqW+ZdnOPlmTnYa0rElfiX42XlBgMpRY33362fgkc5IiiEiF7OsJ/WQVsC6yJ1nVFXbRdgaV7MX3x5GlTAjK36v2w0C4CQnpciBJEtPNlxa1RZkV1p20FfaRv5IRWg+rneWe2HuRECsbwOOGLh18a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506675; c=relaxed/simple;
	bh=rT52NBmeUzFxtsFnovjnWlw09IBD1D0aOlTsU/mpOao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HtmhGYMY1PWeoiOq1BAQQCVnNIzzr9+BgWMNRzrHW7I72JTFl9+UtUUt+7+b9EA3negpPG35dshvPzVNab8o3Bq96bNGK9RJAzMN6gBDq/geCXMOOHohwkWugj0E+zdUewA74YwI3fI9qrw/AP4eyASSB6R+h5PjFBnzvCYjCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2MnmrXP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714506674; x=1746042674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rT52NBmeUzFxtsFnovjnWlw09IBD1D0aOlTsU/mpOao=;
  b=R2MnmrXP88LilRRN6Ret2f9wFidpGAK+BzPOmuLI3A0AUUYYLWc7nSjb
   ql6MrrjgpcZoPvNKXkDWobZs0vPZocHg+MZZ/KeA5HCTZZsVaLscDxpW9
   x//xQkvXEtUzoov21vgZCcuQq98OVsgleXczuBuc3O/BSw8hlj7M0RrHg
   EA8kQGQRxHyzZ8yAeuObyEIETUrCTqIO/61F2Rms45hJS9878Swh8cfla
   L7UGEvgqgHa0uLLSbJYqn1UXkih0w6N8OfL5NuZDeNYUsQiRlOO8P1mhb
   1sid1tmD5ftA4qqs3Y2EK3LUCU5COmiFXMKntG6xb8OfSzezn10A6SGjF
   w==;
X-CSE-ConnectionGUID: DDUfwuBeQLONKeTjhQOoAg==
X-CSE-MsgGUID: cem/3D9eSqyglNsdmrBkAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10355598"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10355598"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 12:51:10 -0700
X-CSE-ConnectionGUID: mCRbP32yRny7Ohty1cBh1w==
X-CSE-MsgGUID: Xzr64fAeQxeLfF2//Tydag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31280310"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa003.jf.intel.com with ESMTP; 30 Apr 2024 12:51:09 -0700
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
Subject: [PATCH v13 05/14] x86/sgx: Implement basic EPC misc cgroup functionality
Date: Tue, 30 Apr 2024 12:50:59 -0700
Message-Id: <20240430195108.5676-6-haitao.huang@linux.intel.com>
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

SGX Enclave Page Cache (EPC) memory allocations are separate from normal
RAM allocations, and are managed solely by the SGX subsystem. The
existing cgroup memory controller cannot be used to limit or account for
SGX EPC memory, which is a desirable feature in some environments. For
instance, within a Kubernetes environment, while a user may specify a
particular EPC quota for a pod, the orchestrator requires a mechanism to
enforce that the pod's actual runtime EPC usage does not exceed the
allocated quota.

Utilize the misc controller [admin-guide/cgroup-v2.rst, 5-9. Misc] to
limit and track EPC allocations per cgroup. Earlier patches have added
the "sgx_epc" resource type in the misc cgroup subsystem. Add basic
support in SGX driver as the "sgx_epc" resource provider:

- Set "capacity" of EPC by calling misc_cg_set_capacity()
- Update EPC usage counter, "current", by calling charge and uncharge
APIs for EPC allocation and deallocation, respectively.
- Setup sgx_epc resource type specific callbacks, which perform
initialization and cleanup during cgroup allocation and deallocation,
respectively.

With these changes, the misc cgroup controller enables users to set a hard
limit for EPC usage in the "misc.max" interface file. It reports current
usage in "misc.current", the total EPC memory available in
"misc.capacity", and the number of times EPC usage reached the max limit
in "misc.events".

For now, the EPC cgroup simply blocks additional EPC allocation in
sgx_alloc_epc_page() when the limit is reached. Reclaimable pages are
still tracked in the global active list, only reclaimed by the global
reclaimer when the total free page count is lower than a threshold.

Later patches will reorganize the tracking and reclamation code in the
global reclaimer and implement per-cgroup tracking and reclaiming.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V13:
- Remove unneeded includes. (Kai)

V12:
- Remove CONFIG_CGROUP_SGX_EPC and make sgx cgroup implementation
conditionally compiled with CONFIG_CGROUP_MISC. (Jarkko)

V11:
- Update copyright and format better (Kai)
- Create wrappers to remove #ifdefs in c file. (Kai)
- Remove unneeded comments (Kai)

V10:
- Shorten function, variable, struct names, s/sgx_epc_cgroup/sgx_cgroup. (Jarkko)
- Use enums instead of booleans for the parameters. (Dave, Jarkko)

V8:
- Remove null checks for epc_cg in try_charge()/uncharge(). (Jarkko)
- Remove extra space, '_INTEL'. (Jarkko)

V7:
- Use a static for root cgroup (Kai)
- Wrap epc_cg field in sgx_epc_page struct with #ifdef (Kai)
- Correct check for charge API return (Kai)
- Start initialization in SGX device driver init (Kai)
- Remove unneeded BUG_ON (Kai)
- Split  sgx_get_current_epc_cg() out of sgx_epc_cg_try_charge() (Kai)

V6:
- Split the original large patch"Limit process EPC usage with misc
cgroup controller"  and restructure it (Kai)
---
 arch/x86/kernel/cpu/sgx/Makefile     |  1 +
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 71 +++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h | 72 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/main.c       | 42 +++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h        | 21 ++++++++
 include/linux/misc_cgroup.h          |  2 +
 6 files changed, 207 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h

diff --git a/arch/x86/kernel/cpu/sgx/Makefile b/arch/x86/kernel/cpu/sgx/Makefile
index 9c1656779b2a..081cb424575e 100644
--- a/arch/x86/kernel/cpu/sgx/Makefile
+++ b/arch/x86/kernel/cpu/sgx/Makefile
@@ -4,3 +4,4 @@ obj-y += \
 	ioctl.o \
 	main.o
 obj-$(CONFIG_X86_SGX_KVM)	+= virt.o
+obj-$(CONFIG_CGROUP_MISC)	+= epc_cgroup.o
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
new file mode 100644
index 000000000000..5c484fd10160
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022-2024 Intel Corporation. */
+
+#include<linux/slab.h>
+#include "epc_cgroup.h"
+
+/* The root SGX EPC cgroup */
+static struct sgx_cgroup sgx_cg_root;
+
+/**
+ * sgx_cgroup_try_charge() - try to charge cgroup for a single EPC page
+ *
+ * @sgx_cg:	The EPC cgroup to be charged for the page.
+ * Return:
+ * * %0 - If successfully charged.
+ * * -errno - for failures.
+ */
+int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
+{
+	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, sgx_cg->cg, PAGE_SIZE);
+}
+
+/**
+ * sgx_cgroup_uncharge() - uncharge a cgroup for an EPC page
+ * @sgx_cg:	The charged sgx cgroup.
+ */
+void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg)
+{
+	misc_cg_uncharge(MISC_CG_RES_SGX_EPC, sgx_cg->cg, PAGE_SIZE);
+}
+
+static void sgx_cgroup_free(struct misc_cg *cg)
+{
+	struct sgx_cgroup *sgx_cg;
+
+	sgx_cg = sgx_cgroup_from_misc_cg(cg);
+	if (!sgx_cg)
+		return;
+
+	kfree(sgx_cg);
+}
+
+static void sgx_cgroup_misc_init(struct misc_cg *cg, struct sgx_cgroup *sgx_cg)
+{
+	cg->res[MISC_CG_RES_SGX_EPC].priv = sgx_cg;
+	sgx_cg->cg = cg;
+}
+
+static int sgx_cgroup_alloc(struct misc_cg *cg)
+{
+	struct sgx_cgroup *sgx_cg;
+
+	sgx_cg = kzalloc(sizeof(*sgx_cg), GFP_KERNEL);
+	if (!sgx_cg)
+		return -ENOMEM;
+
+	sgx_cgroup_misc_init(cg, sgx_cg);
+
+	return 0;
+}
+
+const struct misc_res_ops sgx_cgroup_ops = {
+	.alloc = sgx_cgroup_alloc,
+	.free = sgx_cgroup_free,
+};
+
+void sgx_cgroup_init(void)
+{
+	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_cgroup_ops);
+	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
+}
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
new file mode 100644
index 000000000000..bd9606479e67
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SGX_EPC_CGROUP_H_
+#define _SGX_EPC_CGROUP_H_
+
+#include <asm/sgx.h>
+#include <linux/cgroup.h>
+#include <linux/misc_cgroup.h>
+
+#include "sgx.h"
+
+#ifndef CONFIG_CGROUP_MISC
+
+#define MISC_CG_RES_SGX_EPC MISC_CG_RES_TYPES
+struct sgx_cgroup;
+
+static inline struct sgx_cgroup *sgx_get_current_cg(void)
+{
+	return NULL;
+}
+
+static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg) { }
+
+static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
+{
+	return 0;
+}
+
+static inline void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg) { }
+
+static inline void sgx_cgroup_init(void) { }
+
+#else /* CONFIG_CGROUP_MISC */
+
+struct sgx_cgroup {
+	struct misc_cg *cg;
+};
+
+static inline struct sgx_cgroup *sgx_cgroup_from_misc_cg(struct misc_cg *cg)
+{
+	return (struct sgx_cgroup *)(cg->res[MISC_CG_RES_SGX_EPC].priv);
+}
+
+/**
+ * sgx_get_current_cg() - get the EPC cgroup of current process.
+ *
+ * Returned cgroup has its ref count increased by 1. Caller must call
+ * sgx_put_cg() to return the reference.
+ *
+ * Return: EPC cgroup to which the current task belongs to.
+ */
+static inline struct sgx_cgroup *sgx_get_current_cg(void)
+{
+	/* get_current_misc_cg() never returns NULL when Kconfig enabled */
+	return sgx_cgroup_from_misc_cg(get_current_misc_cg());
+}
+
+/**
+ * sgx_put_cg() - Put the EPC cgroup and reduce its ref count.
+ * @sgx_cg - EPC cgroup to put.
+ */
+static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
+{
+	put_misc_cg(sgx_cg->cg);
+}
+
+int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg);
+void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
+void sgx_cgroup_init(void);
+
+#endif /* CONFIG_CGROUP_MISC */
+
+#endif /* _SGX_EPC_CGROUP_H_ */
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index d219f14365d4..1226ea0d5b3c 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -17,6 +17,7 @@
 #include "driver.h"
 #include "encl.h"
 #include "encls.h"
+#include "epc_cgroup.h"
 
 struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
 static int sgx_nr_epc_sections;
@@ -558,7 +559,16 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
  */
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 {
+	struct sgx_cgroup *sgx_cg;
 	struct sgx_epc_page *page;
+	int ret;
+
+	sgx_cg = sgx_get_current_cg();
+	ret = sgx_cgroup_try_charge(sgx_cg);
+	if (ret) {
+		sgx_put_cg(sgx_cg);
+		return ERR_PTR(ret);
+	}
 
 	for ( ; ; ) {
 		page = __sgx_alloc_epc_page();
@@ -567,8 +577,10 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
-		if (list_empty(&sgx_active_page_list))
-			return ERR_PTR(-ENOMEM);
+		if (list_empty(&sgx_active_page_list)) {
+			page = ERR_PTR(-ENOMEM);
+			break;
+		}
 
 		if (reclaim == SGX_NO_RECLAIM) {
 			page = ERR_PTR(-EBUSY);
@@ -584,6 +596,15 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 		cond_resched();
 	}
 
+	if (!IS_ERR(page)) {
+		WARN_ON_ONCE(sgx_epc_page_get_cgroup(page));
+		/* sgx_put_cg() in sgx_free_epc_page() */
+		sgx_epc_page_set_cgroup(page, sgx_cg);
+	} else {
+		sgx_cgroup_uncharge(sgx_cg);
+		sgx_put_cg(sgx_cg);
+	}
+
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
 		wake_up(&ksgxd_waitq);
 
@@ -602,8 +623,16 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 void sgx_free_epc_page(struct sgx_epc_page *page)
 {
 	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
+	struct sgx_cgroup *sgx_cg = sgx_epc_page_get_cgroup(page);
 	struct sgx_numa_node *node = section->node;
 
+	/* sgx_cg could be NULL if called from __sgx_sanitize_pages() */
+	if (sgx_cg) {
+		sgx_cgroup_uncharge(sgx_cg);
+		sgx_put_cg(sgx_cg);
+		sgx_epc_page_set_cgroup(page, NULL);
+	}
+
 	spin_lock(&node->lock);
 
 	page->owner = NULL;
@@ -643,6 +672,8 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		section->pages[i].flags = 0;
 		section->pages[i].owner = NULL;
 		section->pages[i].poison = 0;
+		sgx_epc_page_set_cgroup(&section->pages[i], NULL);
+
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
@@ -787,6 +818,7 @@ static void __init arch_update_sysfs_visibility(int nid) {}
 static bool __init sgx_page_cache_init(void)
 {
 	u32 eax, ebx, ecx, edx, type;
+	u64 capacity = 0;
 	u64 pa, size;
 	int nid;
 	int i;
@@ -837,6 +869,7 @@ static bool __init sgx_page_cache_init(void)
 
 		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
 		sgx_numa_nodes[nid].size += size;
+		capacity += size;
 
 		sgx_nr_epc_sections++;
 	}
@@ -846,6 +879,8 @@ static bool __init sgx_page_cache_init(void)
 		return false;
 	}
 
+	misc_cg_set_capacity(MISC_CG_RES_SGX_EPC, capacity);
+
 	return true;
 }
 
@@ -942,6 +977,9 @@ static int __init sgx_init(void)
 	if (sgx_vepc_init() && ret)
 		goto err_provision;
 
+	/* Setup cgroup if either the native or vepc driver is active */
+	sgx_cgroup_init();
+
 	return 0;
 
 err_provision:
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index ca34cd4f58ac..fae8eef10232 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -39,14 +39,35 @@ enum sgx_reclaim {
 	SGX_DO_RECLAIM
 };
 
+struct sgx_cgroup;
+
 struct sgx_epc_page {
 	unsigned int section;
 	u16 flags;
 	u16 poison;
 	struct sgx_encl_page *owner;
 	struct list_head list;
+#ifdef CONFIG_CGROUP_MISC
+	struct sgx_cgroup *sgx_cg;
+#endif
 };
 
+static inline void sgx_epc_page_set_cgroup(struct sgx_epc_page *page, struct sgx_cgroup *cg)
+{
+#ifdef CONFIG_CGROUP_MISC
+	page->sgx_cg = cg;
+#endif
+}
+
+static inline struct sgx_cgroup *sgx_epc_page_get_cgroup(struct sgx_epc_page *page)
+{
+#ifdef CONFIG_CGROUP_MISC
+	return page->sgx_cg;
+#else
+	return NULL;
+#endif
+}
+
 /*
  * Contains the tracking data for NUMA nodes having EPC pages. Most importantly,
  * the free page list local to the node is stored here.
diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 440ed2bb8053..c9b47a5e966a 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -46,11 +46,13 @@ struct misc_res_ops {
  * @max: Maximum limit on the resource.
  * @usage: Current usage of the resource.
  * @events: Number of times, the resource limit exceeded.
+ * @priv: resource specific data.
  */
 struct misc_res {
 	u64 max;
 	atomic64_t usage;
 	atomic64_t events;
+	void *priv;
 };
 
 /**
-- 
2.25.1


