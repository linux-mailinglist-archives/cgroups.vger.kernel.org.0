Return-Path: <cgroups+bounces-4388-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A42C095926B
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 03:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1ED1F24474
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 01:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6BD13BAC2;
	Wed, 21 Aug 2024 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCm+u0Wk"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BAF12AAE2;
	Wed, 21 Aug 2024 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205266; cv=none; b=oiEAEgm+zU7qX/Xb8uWxbsj/ldP8RhOL/dEcT+8e071BLW56Z/2ujoEiQ6ghIjYdP0GizFgWVrt+5D+R2nXVpfwXm1CcWnqbRDav1i5/5zGCa5T5E36RGd3yjRxqFviaMyU/2wFn8b1pq1mAmmbal4IU/Opj2zBX0E5gcjOKAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205266; c=relaxed/simple;
	bh=gw3Xe0f1JqksoApA7m1mPwJ6MUYAORQ7DdhUfdb9Qdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itj+lJMN3oKLCQbJB5YYtGAXOeCz39BpLkw5YqezgH1BgKH1SVJztiJteHglNwXh4+d/D+hFoT6DXjUTc5ZB0ZbpU0+8BwV7MVajNP4ODBxaKZ5aAUvhEii6XQfzTWkUtE3orfj6u/8m2lFw5j3b0BBdHk874+RleMMNPZV5/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCm+u0Wk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205264; x=1755741264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gw3Xe0f1JqksoApA7m1mPwJ6MUYAORQ7DdhUfdb9Qdk=;
  b=mCm+u0WktBAcQVb8f2JqzhzUoV2v8zyVdf2jmXCDBpxdzBZ728rV5RS2
   /8e1HcWOpUrDUctRO9L/FX8vHlOpeTa81WsG9l4Uf7c0HP8xD7/+HSuuz
   lBMShO4XG4Bsldc/hyLJU7etkEfD37fMl3pSbD3dV8mG9kFTdtteL1qUw
   FiWUg+D7zWWY6a6rI3ccvp4HGeIRdbGlJsoxUkTUxUH2kfEVun0VGIXKa
   SgU1JHR3PkdzZlMjMSED9oeKjwfPdtNq8DXj7r96VnMl2ajkytc/485E5
   d6w8TW6fpvjSwXOIamGKdtKMhZP6NZi+PxzVKQQRC4dk7LIg4EDQ5V4Xq
   Q==;
X-CSE-ConnectionGUID: oSaK5aicTBOefJeehEX8sg==
X-CSE-MsgGUID: KzlHKdtaRguFJAlS4G3B4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33107869"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33107869"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:18 -0700
X-CSE-ConnectionGUID: meqgf8bgSdyo3/8lANJT+Q==
X-CSE-MsgGUID: OxmD/sLXTLayXknfZ66AOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61078592"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:17 -0700
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
Subject: [PATCH v16 05/16] x86/sgx: Implement basic EPC misc cgroup functionality
Date: Tue, 20 Aug 2024 18:53:53 -0700
Message-ID: <20240821015404.6038-6-haitao.huang@linux.intel.com>
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
V16:
- Proper handling for failures during init (Kai)
- Register ops and capacity at the end when SGX is ready to handle
  callbacks.

V15:
- Declare __init for sgx_cgroup_init() (Jarkko)
- Disable SGX when sgx_cgroup_init() fails (Jarkko)

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
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 93 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h | 78 +++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/main.c       | 44 +++++++++++--
 arch/x86/kernel/cpu/sgx/sgx.h        | 24 +++++++
 include/linux/misc_cgroup.h          |  2 +
 6 files changed, 238 insertions(+), 4 deletions(-)
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
index 000000000000..0e422fef02bb
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -0,0 +1,93 @@
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
+int __init sgx_cgroup_init(void)
+{
+	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
+
+	return 0;
+}
+
+/**
+ * Register capacity and ops for SGX cgroup.
+ * Only called at the end of sgx_init() when SGX is ready to handle the ops
+ * callbacks.
+ */
+void __init sgx_cgroup_register(void)
+{
+	unsigned int nid = first_node(sgx_numa_mask);
+	unsigned int first = nid;
+	u64 capacity = 0;
+
+	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_cgroup_ops);
+
+	/* sgx_numa_mask is not empty when this is called */
+	do {
+		capacity += sgx_numa_nodes[nid].size;
+		nid = next_node_in(nid, sgx_numa_mask);
+	} while (nid != first);
+	misc_cg_set_capacity(MISC_CG_RES_SGX_EPC, capacity);
+}
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
new file mode 100644
index 000000000000..e74b1ea0b642
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -0,0 +1,78 @@
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
+static inline int __init sgx_cgroup_init(void)
+{
+	return 0;
+}
+
+static inline void __init sgx_cgroup_register(void) { }
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
+int __init sgx_cgroup_init(void);
+void __init sgx_cgroup_register(void);
+
+#endif /* CONFIG_CGROUP_MISC */
+
+#endif /* _SGX_EPC_CGROUP_H_ */
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index e64073fb4256..0fda964c0a7c 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -18,6 +18,7 @@
 #include "driver.h"
 #include "encl.h"
 #include "encls.h"
+#include "epc_cgroup.h"
 
 struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
 static int sgx_nr_epc_sections;
@@ -35,14 +36,14 @@ static DEFINE_SPINLOCK(sgx_reclaimer_lock);
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
 /* Nodes with one or more EPC sections. */
-static nodemask_t sgx_numa_mask;
+nodemask_t sgx_numa_mask;
 
 /*
  * Array with one list_head for each possible NUMA node.  Each
  * list contains all the sgx_epc_section's which are on that
  * node.
  */
-static struct sgx_numa_node *sgx_numa_nodes;
+struct sgx_numa_node *sgx_numa_nodes;
 
 static LIST_HEAD(sgx_dirty_page_list);
 
@@ -559,7 +560,16 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
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
@@ -568,8 +578,10 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
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
@@ -585,6 +597,15 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
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
 
@@ -603,8 +624,16 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
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
@@ -644,6 +673,8 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		section->pages[i].flags = 0;
 		section->pages[i].owner = NULL;
 		section->pages[i].poison = 0;
+		sgx_epc_page_set_cgroup(&section->pages[i], NULL);
+
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
@@ -930,6 +961,9 @@ static int __init sgx_init(void)
 	if (ret)
 		goto err_kthread;
 
+	ret = sgx_cgroup_init();
+	if (ret)
+		goto err_provision;
 	/*
 	 * Always try to initialize the native *and* KVM drivers.
 	 * The KVM driver is less picky than the native one and
@@ -943,6 +977,8 @@ static int __init sgx_init(void)
 	if (sgx_vepc_init() && ret)
 		goto err_provision;
 
+	sgx_cgroup_register();
+
 	return 0;
 
 err_provision:
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index ca34cd4f58ac..c5208da7c8eb 100644
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
@@ -58,6 +79,9 @@ struct sgx_numa_node {
 	spinlock_t lock;
 };
 
+extern nodemask_t sgx_numa_mask;
+extern struct sgx_numa_node *sgx_numa_nodes;
+
 /*
  * The firmware can define multiple chunks of EPC to the different areas of the
  * physical memory e.g. for memory areas of the each node. This structure is
diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index b4119869b0d1..df88e1ff9877 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -48,6 +48,7 @@ struct misc_res_ops {
  * @watermark: Historical maximum usage of the resource.
  * @usage: Current usage of the resource.
  * @events: Number of times, the resource limit exceeded.
+ * @priv: resource specific data.
  */
 struct misc_res {
 	u64 max;
@@ -55,6 +56,7 @@ struct misc_res {
 	atomic64_t usage;
 	atomic64_t events;
 	atomic64_t events_local;
+	void *priv;
 };
 
 /**
-- 
2.43.0


