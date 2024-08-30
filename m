Return-Path: <cgroups+bounces-4635-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0431966728
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 18:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E34B231DA
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8C31BCA1C;
	Fri, 30 Aug 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sgu9DCYk"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B281BB68E;
	Fri, 30 Aug 2024 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036100; cv=none; b=ksnPqIARwQkp1eBLHbvCN/oRYPUDzkujFXmXnUj9z24oeSNIM1MUvGYApdsMqNZS9YGOdGj1Cu13ZRgJx1SYuuwUM3Hcdkhtv2YcQEEizNIxRPQjIb48KrAKUSgzqPlBpzdq5VYkagVpAN4rPhrHQRNCAMSOcXTsLpsDeAQe+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036100; c=relaxed/simple;
	bh=K/MgWsnfH75WRIJzv24IgSeYzE5Q8QxnzxXKTeRzHr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaSsrnHMo/FMYqT4EBojZ1h/nszNDuhGP/pikUeMsdoI0cRd/WS2KmqGbcDkchOsk/38q4SD2nhnLqvQlvxJIPd8QQexXdrF+09uYDBGH3Pjhe3n1MhrEqIglve04fM0vTKHG6gANE19csnDejdFYs4mP31nWJAI2Y58scsY2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sgu9DCYk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036097; x=1756572097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K/MgWsnfH75WRIJzv24IgSeYzE5Q8QxnzxXKTeRzHr0=;
  b=Sgu9DCYk858cA6VALhkToDL6nm2NYvrPS52cTplcj2wUSjGW3iOeQ5bj
   MfjDJzCxv22pguRLW9VxKb1E2bNxsoPcO7RlnFp4CNC84SuW14Gn8hEs/
   VFns7HuCynx8twzGPdmxW2/LZo1yo63OFOtE95geHTSSMdEeT42hMzygX
   QzglYOeh6o/PmmRwmvnZbLvQcrNvS4VSpcEJGPEy1eYLeF+T27NOZGMvj
   olKVqQR/Ha6MV3dOs8pkOj+78NktPVDAkZ4P+ccEftj19DOK4xCeZeVAS
   UezZRVfeuTbzqho6xaaFfBiWIwFwiM5DUdx/DFxFz0l4LAvuizvyGVQwP
   Q==;
X-CSE-ConnectionGUID: S1+yiAKoQGKU0tGv04dN8Q==
X-CSE-MsgGUID: ByMaZ3pRT6q6oDgohU4vHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34300007"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34300007"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:52 -0700
X-CSE-ConnectionGUID: zy5ZD+1hRIOXrUe26kEVBQ==
X-CSE-MsgGUID: j07sulMYRSyoEhy6Xuz1Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="101440464"
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
Subject: [PATCH v17 05/16] x86/sgx: Implement basic EPC misc cgroup functionality
Date: Fri, 30 Aug 2024 09:40:26 -0700
Message-ID: <20240830164038.39343-6-haitao.huang@linux.intel.com>
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
V17:
- Rename sgx_cgroup_register() -> sgx_cgroup_init(), and move the
sgx_cgroup_misc_init call to it. (Kai)

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
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 87 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h | 72 +++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/main.c       | 41 +++++++++++--
 arch/x86/kernel/cpu/sgx/sgx.h        | 24 ++++++++
 include/linux/misc_cgroup.h          |  2 +
 6 files changed, 223 insertions(+), 4 deletions(-)
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
index 000000000000..b219ec21c637
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -0,0 +1,87 @@
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
+/*
+ * Register capacity and ops for SGX cgroup and init the root cgroup.
+ * Only called at the end of sgx_init() when SGX is ready to handle the ops
+ * callbacks. No failures allowed in this function.
+ */
+void __init sgx_cgroup_init(void)
+{
+	unsigned int nid = first_node(sgx_numa_mask);
+	unsigned int first = nid;
+	u64 capacity = 0;
+
+	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
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
index 000000000000..52c9faf31fa1
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
+static inline void __init sgx_cgroup_init(void) { }
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
+void __init sgx_cgroup_init(void);
+
+#endif /* CONFIG_CGROUP_MISC */
+
+#endif /* _SGX_EPC_CGROUP_H_ */
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index e64073fb4256..395481e9ba55 100644
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
 
@@ -943,6 +974,8 @@ static int __init sgx_init(void)
 	if (sgx_vepc_init() && ret)
 		goto err_provision;
 
+	sgx_cgroup_init();
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


