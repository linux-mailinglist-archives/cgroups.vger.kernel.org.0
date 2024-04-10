Return-Path: <cgroups+bounces-2422-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C0889FFB9
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 20:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF716288EDB
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 18:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E6A18131A;
	Wed, 10 Apr 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daHBJ1j2"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C51802D6;
	Wed, 10 Apr 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773565; cv=none; b=iNW8v7o6IKV3enqcv7oaNvZI/kd4sQXaUBZIuUphFHjyTYTxBTUcY/5/ys727N+zg5yIjdStXH3aWKILYRRpNgRiNZgaCr0xW4HaauSWAu860o4hRp2G5+3doslJ3VfdcFbOpu6BDYfoyIxcisfLW4FQL97M43+kokz2yYe77nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773565; c=relaxed/simple;
	bh=lZRtrdhT6HRL5PUX1s2qanwwMwQE9b2aBJ8/CnT5WAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uLC9MtXX4DSMygPQouUr7BHNoogg/o2FmkngkYtLka+IuBF3Fw6zP1Ljg3VqqufKYidElfq3QHuqALTNw0fa4wzfr4QhuGcA7ZICCCRXsitjokI7SwPA4fiiRrBhQCZG5BeXjGd8c2qj6kJb90l4qtkD18csGmcYdNdrznzaxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daHBJ1j2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712773564; x=1744309564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lZRtrdhT6HRL5PUX1s2qanwwMwQE9b2aBJ8/CnT5WAE=;
  b=daHBJ1j2U7s09wwFM3atWdyuWM/BgkCaP3ZcakeZrNeRtsn+WTfeO52u
   fnLmKAYPn9t7w2xPPlHTnUhvcVBsbCDrklGqnjpe9BEumWAA1L+8nPwvG
   n2DDsWRKMXfKyJoUL5Q/fiAhhnZeDXJdKUqzI+1IWTlsyKQBBjZ0yJAMk
   pDI8QkRJx02stU32FP1eeF4oYYNYpnJI+UiTOlr7iz34MKK1XY366t9cS
   3w8ab0Rf7bC05KbsudZygsSfdn1MmtW0kHl4URVR+OOtREEQ2aAx2Mp4i
   /Xy+zxty34SE0O67N+ipJAs4CnSdk/MpvzlsdcnB99TbF88IGeA+ubur5
   g==;
X-CSE-ConnectionGUID: OtEOyfvkT2KdcqjEy9074Q==
X-CSE-MsgGUID: oJCAkY0XSTmCSt9XqEaYsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19583673"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="19583673"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:26:00 -0700
X-CSE-ConnectionGUID: np1+F2eySRaCiuhRIUDC1Q==
X-CSE-MsgGUID: SUEoFQs0Qt+Qk1jpYO+Tjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="21232420"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2024 11:25:59 -0700
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
Subject: [PATCH v11 05/14] x86/sgx: Implement basic EPC misc cgroup functionality
Date: Wed, 10 Apr 2024 11:25:49 -0700
Message-Id: <20240410182558.41467-6-haitao.huang@linux.intel.com>
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
---
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
 arch/x86/Kconfig                     | 13 +++++
 arch/x86/kernel/cpu/sgx/Makefile     |  1 +
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 72 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h | 72 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/main.c       | 43 ++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h        | 21 ++++++++
 include/linux/misc_cgroup.h          |  2 +
 7 files changed, 222 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 39886bab943a..bda78255a7ab 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1941,6 +1941,19 @@ config X86_SGX
 
 	  If unsure, say N.
 
+config CGROUP_SGX_EPC
+	bool "Miscellaneous Cgroup Controller for Enclave Page Cache (EPC) for Intel SGX"
+	depends on X86_SGX && CGROUP_MISC
+	help
+	  Provides control over the EPC footprint of tasks in a cgroup via
+	  the Miscellaneous cgroup controller.
+
+	  EPC is a subset of regular memory that is usable only by SGX
+	  enclaves and is very limited in quantity, e.g. less than 1%
+	  of total DRAM.
+
+	  Say N if unsure.
+
 config X86_USER_SHADOW_STACK
 	bool "X86 userspace shadow stack"
 	depends on AS_WRUSS
diff --git a/arch/x86/kernel/cpu/sgx/Makefile b/arch/x86/kernel/cpu/sgx/Makefile
index 9c1656779b2a..12901a488da7 100644
--- a/arch/x86/kernel/cpu/sgx/Makefile
+++ b/arch/x86/kernel/cpu/sgx/Makefile
@@ -4,3 +4,4 @@ obj-y += \
 	ioctl.o \
 	main.o
 obj-$(CONFIG_X86_SGX_KVM)	+= virt.o
+obj-$(CONFIG_CGROUP_SGX_EPC)	       += epc_cgroup.o
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
new file mode 100644
index 000000000000..ff4d4a25dbe7
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022-2024 Intel Corporation. */
+
+#include <linux/atomic.h>
+#include <linux/kernel.h>
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
index 000000000000..0ecb170830f1
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
+#ifndef CONFIG_CGROUP_SGX_EPC
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
+#else
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
+#endif
+
+#endif /* _SGX_EPC_CGROUP_H_ */
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index d219f14365d4..d482ae7fdabf 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -6,6 +6,7 @@
 #include <linux/highmem.h>
 #include <linux/kthread.h>
 #include <linux/miscdevice.h>
+#include <linux/misc_cgroup.h>
 #include <linux/node.h>
 #include <linux/pagemap.h>
 #include <linux/ratelimit.h>
@@ -17,6 +18,7 @@
 #include "driver.h"
 #include "encl.h"
 #include "encls.h"
+#include "epc_cgroup.h"
 
 struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
 static int sgx_nr_epc_sections;
@@ -558,7 +560,16 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
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
@@ -567,8 +578,10 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
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
@@ -584,6 +597,15 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
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
 
@@ -602,8 +624,16 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
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
@@ -643,6 +673,8 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		section->pages[i].flags = 0;
 		section->pages[i].owner = NULL;
 		section->pages[i].poison = 0;
+		sgx_epc_page_set_cgroup(&section->pages[i], NULL);
+
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
@@ -787,6 +819,7 @@ static void __init arch_update_sysfs_visibility(int nid) {}
 static bool __init sgx_page_cache_init(void)
 {
 	u32 eax, ebx, ecx, edx, type;
+	u64 capacity = 0;
 	u64 pa, size;
 	int nid;
 	int i;
@@ -837,6 +870,7 @@ static bool __init sgx_page_cache_init(void)
 
 		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
 		sgx_numa_nodes[nid].size += size;
+		capacity += size;
 
 		sgx_nr_epc_sections++;
 	}
@@ -846,6 +880,8 @@ static bool __init sgx_page_cache_init(void)
 		return false;
 	}
 
+	misc_cg_set_capacity(MISC_CG_RES_SGX_EPC, capacity);
+
 	return true;
 }
 
@@ -942,6 +978,9 @@ static int __init sgx_init(void)
 	if (sgx_vepc_init() && ret)
 		goto err_provision;
 
+	/* Setup cgroup if either the native or vepc driver is active */
+	sgx_cgroup_init();
+
 	return 0;
 
 err_provision:
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index ca34cd4f58ac..79337dd39348 100644
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
+#ifdef CONFIG_CGROUP_SGX_EPC
+	struct sgx_cgroup *sgx_cg;
+#endif
 };
 
+static inline void sgx_epc_page_set_cgroup(struct sgx_epc_page *page, struct sgx_cgroup *cg)
+{
+#ifdef CONFIG_CGROUP_SGX_EPC
+	page->sgx_cg = cg;
+#endif
+}
+
+static inline struct sgx_cgroup *sgx_epc_page_get_cgroup(struct sgx_epc_page *page)
+{
+#ifdef CONFIG_CGROUP_SGX_EPC
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
index 2f6cc3a0ad23..1a16efdfcd3d 100644
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


