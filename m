Return-Path: <cgroups+bounces-2205-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B2E88F38F
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 01:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEDD29B90C
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 00:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A7625776;
	Thu, 28 Mar 2024 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyFc7ozS"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379A13AF9;
	Thu, 28 Mar 2024 00:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585368; cv=none; b=oBSYljYwX6d9A36Jzccc0YpH9K5x4e74KRVv4wT+p2oRGIibxD8cRd2i379Jf+fiFSKjuFkEKbORGCYsge/c4vqDLsV84BMGFI7mSP46GH5fMY1bUCAhPg7YXrhn2C6Wy6QHH+yzOJ8Gzn2QNf0aLPf90U2zjtBQ4U4IxC2a94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585368; c=relaxed/simple;
	bh=PxXezK5mhTO4vaj6SKsjiZfvXX0qMSvqrRRYfsZdjXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZxUlFaSmD3uCfd164EBux5dmZkHH9zLTAl6LBAazcyxQDcGIgpe9+XzwNlpkG+MhyjfdeFCoe0fHNzryHhC6o+n1FY0Di3/mGGsIntfZKwj1Ffz9YJ4jcm2i6Xt7HpHy87ienmFhQroHpYHuyvlK5ZG7UMI/nKjATwddGaXcVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyFc7ozS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711585366; x=1743121366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PxXezK5mhTO4vaj6SKsjiZfvXX0qMSvqrRRYfsZdjXk=;
  b=HyFc7ozSdVGMrZaiHH0zrwHb7MF2Q+kpGfujhwJR+NIlGFgBSxO7Akmj
   aFG5S8jRbrwz4v6KahhqwLpba3yaVKcB3eWDRnc8nwL3Nrrg/n96aS8Og
   UxrFq3M3G+FDq35+XDnfbFdOU+4DtVFzakzmS9UwZyYGCo5Cm1jDjzhBO
   4U/nOf+EZtsVbhj/p4SUt3hd09tKYoBZJ5hKFm5FBUAgzaGDfZhxWKaTq
   +S6go9kxYDIhFOk3GvuxjnerrlwQKfcQUndAAY+ZMPQxj3EjmHWaroDbQ
   /yfGo6klS+gyzLtoOqCaFIy0L65Njx5ZjGaREwniFeMtGmRjvuiEYe+BQ
   A==;
X-CSE-ConnectionGUID: pF7hG8ptQIeLePkAIdkpdQ==
X-CSE-MsgGUID: GK2DGBWNQASSdyHU3/DisA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6580673"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6580673"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 17:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16411793"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa009.jf.intel.com with ESMTP; 27 Mar 2024 17:22:30 -0700
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
Subject: [PATCH v10 05/14] x86/sgx: Implement basic EPC misc cgroup functionality
Date: Wed, 27 Mar 2024 17:22:20 -0700
Message-Id: <20240328002229.30264-6-haitao.huang@linux.intel.com>
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

With these changes, the misc cgroup controller enables user to set a hard
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
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 74 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h | 70 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/main.c       | 51 ++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h        |  5 ++
 include/linux/misc_cgroup.h          |  2 +
 7 files changed, 214 insertions(+), 2 deletions(-)
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
index 000000000000..a1dd43c195b2
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright(c) 2022 Intel Corporation.
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
+ * @sgx_cg:	The charged sgx cgroup
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
+static int sgx_cgroup_alloc(struct misc_cg *cg);
+
+const struct misc_res_ops sgx_cgroup_ops = {
+	.alloc = sgx_cgroup_alloc,
+	.free = sgx_cgroup_free,
+};
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
+void sgx_cgroup_init(void)
+{
+	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_cgroup_ops);
+	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
+}
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
new file mode 100644
index 000000000000..8f794e23fad6
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2022 Intel Corporation. */
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
+#else
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
+	return sgx_cgroup_from_misc_cg(get_current_misc_cg());
+}
+
+/**
+ * sgx_put_sgx_cg() - Put the EPC cgroup and reduce its ref count.
+ * @sgx_cg - EPC cgroup to put.
+ */
+static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
+{
+	if (sgx_cg)
+		put_misc_cg(sgx_cg->cg);
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
index d219f14365d4..023af54c1beb 100644
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
@@ -580,10 +593,24 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
+		/*
+		 * Need to do a global reclamation if cgroup was not full but free
+		 * physical pages run out, causing __sgx_alloc_epc_page() to fail.
+		 */
 		sgx_reclaim_pages();
 		cond_resched();
 	}
 
+#ifdef CONFIG_CGROUP_SGX_EPC
+	if (!IS_ERR(page)) {
+		WARN_ON_ONCE(page->sgx_cg);
+		/* sgx_put_cg() in sgx_free_epc_page() */
+		page->sgx_cg = sgx_cg;
+	} else {
+		sgx_cgroup_uncharge(sgx_cg);
+		sgx_put_cg(sgx_cg);
+	}
+#endif
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
 		wake_up(&ksgxd_waitq);
 
@@ -604,6 +631,14 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
 	struct sgx_numa_node *node = section->node;
 
+#ifdef CONFIG_CGROUP_SGX_EPC
+	if (page->sgx_cg) {
+		sgx_cgroup_uncharge(page->sgx_cg);
+		sgx_put_cg(page->sgx_cg);
+		page->sgx_cg = NULL;
+	}
+#endif
+
 	spin_lock(&node->lock);
 
 	page->owner = NULL;
@@ -643,6 +678,11 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		section->pages[i].flags = 0;
 		section->pages[i].owner = NULL;
 		section->pages[i].poison = 0;
+
+#ifdef CONFIG_CGROUP_SGX_EPC
+		section->pages[i].sgx_cg = NULL;
+#endif
+
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
@@ -787,6 +827,7 @@ static void __init arch_update_sysfs_visibility(int nid) {}
 static bool __init sgx_page_cache_init(void)
 {
 	u32 eax, ebx, ecx, edx, type;
+	u64 capacity = 0;
 	u64 pa, size;
 	int nid;
 	int i;
@@ -837,6 +878,7 @@ static bool __init sgx_page_cache_init(void)
 
 		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
 		sgx_numa_nodes[nid].size += size;
+		capacity += size;
 
 		sgx_nr_epc_sections++;
 	}
@@ -846,6 +888,8 @@ static bool __init sgx_page_cache_init(void)
 		return false;
 	}
 
+	misc_cg_set_capacity(MISC_CG_RES_SGX_EPC, capacity);
+
 	return true;
 }
 
@@ -942,6 +986,9 @@ static int __init sgx_init(void)
 	if (sgx_vepc_init() && ret)
 		goto err_provision;
 
+	/* Setup cgroup if either the native or vepc driver is active */
+	sgx_cgroup_init();
+
 	return 0;
 
 err_provision:
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index ca34cd4f58ac..6accc81d19a9 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -39,12 +39,17 @@ enum sgx_reclaim {
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
 
 /*
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


