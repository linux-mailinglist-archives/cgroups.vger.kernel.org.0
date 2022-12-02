Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6874D640D85
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 19:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiLBSja (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 13:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiLBSiy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 13:38:54 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2453D1BE84;
        Fri,  2 Dec 2022 10:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670006270; x=1701542270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RadumGQcoiq/xKIbEJnULzNUS8PkZvMSEIkwndEE9Xo=;
  b=DEAGRubQUsFalnLJCkEotKvUp46b/zMGEHazVotMCqc9IOHizdR6+K54
   B2NtOCq4pBrHSWG7X0cTedSA0U6ZPv2AH9NXoSXcFYWguYrbMnauViRfE
   H07Pj6kGOr49Oy0z0Cgxv8Hib8bN2HPJ6nDTUfXV7daB+k3OKKBPw9Nkl
   Nz6yTFIUjXXYaSwA5r2t+DuFwI3kFkDsciZQuS6+ncv+2Wp2lGn2fFnP8
   fOiH4BWaWOk7lbu4KNd4fGRv3xDoinT4yrD/8F5g0hhNv4tPHgIBlGPGZ
   w78t5SGLBTinF3pkI6apcJY9ZSvcpv2cRjG0nemcS20yEnCeczZ3sBvLm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314724694"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314724694"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="713717590"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="713717590"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.251.1.207])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:36 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2 17/18] x86/sgx: Add support for misc cgroup controller
Date:   Fri,  2 Dec 2022 10:36:53 -0800
Message-Id: <20221202183655.3767674-18-kristen@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202183655.3767674-1-kristen@linux.intel.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Implement support for cgroup control of SGX Enclave Page Cache (EPC)
memory using the misc cgroup controller. EPC memory is independent
from normal system memory, e.g. must be reserved at boot from RAM and
cannot be converted between EPC and normal memory while the system is
running. EPC is managed by the SGX subsystem and is not accounted by
the memory controller.

Much like normal system memory, EPC memory can be overcommitted via
virtual memory techniques and pages can be swapped out of the EPC to
their backing store (normal system memory, e.g. shmem).  The SGX EPC
subsystem is analogous to the memory subsytem and the SGX EPC controller
is in turn analogous to the memory controller; it implements limit and
protection models for EPC memory.

The misc controller provides a mechanism to set a hard limit of EPC
usage via the "sgx_epc" resource in "misc.max". The total EPC memory
available on the system is reported via the "sgx_epc" resource in
"misc.capacity".

This patch was modified from its original version to use the misc cgroup
controller instead of a custom controller.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/Kconfig                     |  13 +
 arch/x86/kernel/cpu/sgx/Makefile     |   1 +
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 539 +++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  59 +++
 arch/x86/kernel/cpu/sgx/main.c       |  86 ++++-
 arch/x86/kernel/cpu/sgx/sgx.h        |   6 +-
 6 files changed, 688 insertions(+), 16 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..0eeae4ebe1c3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1936,6 +1936,19 @@ config X86_SGX
 
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
+          Say N if unsure.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
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
index 000000000000..d668a67fde84
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -0,0 +1,539 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright(c) 2022 Intel Corporation.
+
+#include <linux/atomic.h>
+#include <linux/kernel.h>
+#include <linux/ratelimit.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
+#include <linux/threads.h>
+
+#include "epc_cgroup.h"
+
+#define SGX_EPC_RECLAIM_MIN_PAGES		16UL
+#define SGX_EPC_RECLAIM_MAX_PAGES		64UL
+#define SGX_EPC_RECLAIM_IGNORE_AGE_THRESHOLD	5
+#define SGX_EPC_RECLAIM_OOM_THRESHOLD		5
+
+static struct workqueue_struct *sgx_epc_cg_wq;
+
+struct sgx_epc_reclaim_control {
+	struct sgx_epc_cgroup *epc_cg;
+	int nr_fails;
+	bool ignore_age;
+};
+
+static inline unsigned long sgx_epc_cgroup_page_counter_read(struct sgx_epc_cgroup *epc_cg)
+{
+	 return atomic_long_read(&epc_cg->cg->res[MISC_CG_RES_SGX_EPC].usage) / PAGE_SIZE;
+}
+
+static inline unsigned long sgx_epc_cgroup_max_pages(struct sgx_epc_cgroup *epc_cg)
+{
+	 return READ_ONCE(epc_cg->cg->res[MISC_CG_RES_SGX_EPC].max) / PAGE_SIZE;
+}
+
+static inline struct sgx_epc_cgroup *sgx_epc_cgroup_from_misc_cg(struct misc_cg *cg)
+{
+	if (cg)
+		return (struct sgx_epc_cgroup *)(cg->res[MISC_CG_RES_SGX_EPC].priv);
+
+	return NULL;
+}
+
+static inline struct sgx_epc_cgroup *parent_epc_cgroup(struct sgx_epc_cgroup *epc_cg)
+{
+	return sgx_epc_cgroup_from_misc_cg(misc_cg_parent(epc_cg->cg));
+}
+
+static inline bool sgx_epc_cgroup_disabled(void)
+{
+	return !cgroup_subsys_enabled(misc_cgrp_subsys);
+}
+
+/**
+ * sgx_epc_cgroup_iter - iterate over the EPC cgroup hierarchy
+ * @root:		hierarchy root
+ * @prev:		previously returned epc_cg, NULL on first invocation
+ * @reclaim_epoch:	epoch for shared reclaim walks, NULL for full walks
+ *
+ * Return: references to children of the hierarchy below @root, or
+ * @root itself, or %NULL after a full round-trip.
+ *
+ * Caller must pass the return value in @prev on subsequent invocations
+ * for reference counting, or use sgx_epc_cgroup_iter_break() to cancel
+ * a hierarchy walk before the round-trip is complete.
+ */
+static struct sgx_epc_cgroup *sgx_epc_cgroup_iter(struct sgx_epc_cgroup *prev,
+						  struct sgx_epc_cgroup *root,
+						  unsigned long *reclaim_epoch)
+{
+	struct cgroup_subsys_state *css = NULL;
+	struct sgx_epc_cgroup *epc_cg = NULL;
+	struct sgx_epc_cgroup *pos = NULL;
+	bool inc_epoch = false;
+
+	if (sgx_epc_cgroup_disabled())
+		return NULL;
+
+	if (!root)
+		root = sgx_epc_cgroup_from_misc_cg(misc_cg_root());
+
+	if (prev && !reclaim_epoch)
+		pos = prev;
+
+	rcu_read_lock();
+
+start:
+	if (reclaim_epoch) {
+		/*
+		 * Abort the walk if a reclaimer working from the same root has
+		 * started a new walk after this reclaimer has already scanned
+		 * at least one cgroup.
+		 */
+		if (prev && *reclaim_epoch != root->epoch)
+			goto out;
+
+		while (1) {
+			pos = READ_ONCE(root->reclaim_iter);
+			if (!pos || css_tryget(&pos->cg->css))
+				break;
+
+			/*
+			 * The css is dying, clear the reclaim_iter immediately
+			 * instead of waiting for ->css_released to be called.
+			 * Busy waiting serves no purpose and attempting to wait
+			 * for ->css_released may actually block it from being
+			 * called.
+			 */
+			(void)cmpxchg(&root->reclaim_iter, pos, NULL);
+		}
+	}
+
+	if (pos)
+		css = &pos->cg->css;
+
+	while (!epc_cg) {
+		struct misc_cg *cg;
+
+		css = css_next_descendant_pre(css, &root->cg->css);
+		if (!css) {
+			/*
+			 * Increment the epoch as we've reached the end of the
+			 * tree and the next call to css_next_descendant_pre
+			 * will restart at root.  Do not update root->epoch
+			 * directly as we should only do so if we update the
+			 * reclaim_iter, i.e. a different thread may win the
+			 * race and update the epoch for us.
+			 */
+			inc_epoch = true;
+
+			/*
+			 * Reclaimers share the hierarchy walk, and a new one
+			 * might jump in at the end of the hierarchy.  Restart
+			 * at root so that  we don't return NULL on a thread's
+			 * initial call.
+			 */
+			if (!prev)
+				continue;
+			break;
+		}
+
+		cg = css_misc(css);
+		/*
+		 * Verify the css and acquire a reference.  Don't take an
+		 * extra reference to root as it's either the global root
+		 * or is provided by the caller and so is guaranteed to be
+		 * alive.  Keep walking if this css is dying.
+		 */
+		if (cg != root->cg && !css_tryget(&cg->css))
+			continue;
+
+		epc_cg = sgx_epc_cgroup_from_misc_cg(cg);
+	}
+
+	if (reclaim_epoch) {
+		/*
+		 * reclaim_iter could have already been updated by a competing
+		 * thread; check that the value hasn't changed since we read
+		 * it to avoid reclaiming from the same cgroup twice.  If the
+		 * value did change, put all of our references and restart the
+		 * entire process, for all intents and purposes we're making a
+		 * new call.
+		 */
+		if (cmpxchg(&root->reclaim_iter, pos, epc_cg) != pos) {
+			if (epc_cg && epc_cg != root)
+				put_misc_cg(epc_cg->cg);
+			if (pos)
+				put_misc_cg(pos->cg);
+			css = NULL;
+			epc_cg = NULL;
+			inc_epoch = false;
+			goto start;
+		}
+
+		if (inc_epoch)
+			root->epoch++;
+		if (!prev)
+			*reclaim_epoch = root->epoch;
+
+		if (pos)
+			put_misc_cg(pos->cg);
+	}
+
+out:
+	rcu_read_unlock();
+	if (prev && prev != root)
+		put_misc_cg(prev->cg);
+
+	return epc_cg;
+}
+
+/**
+ * sgx_epc_cgroup_iter_break - abort a hierarchy walk prematurely
+ * @prev:	last visited cgroup as returned by sgx_epc_cgroup_iter()
+ * @root:	hierarchy root
+ */
+static void sgx_epc_cgroup_iter_break(struct sgx_epc_cgroup *prev,
+				      struct sgx_epc_cgroup *root)
+{
+	if (!root)
+		root = sgx_epc_cgroup_from_misc_cg(misc_cg_root());
+	if (prev && prev != root)
+		put_misc_cg(prev->cg);
+}
+
+/**
+ * sgx_epc_cgroup_lru_empty - check if a cgroup tree has no pages on its lrus
+ * @root:	root of the tree to check
+ *
+ * Return: %true if all cgroups under the specified root have empty LRU lists.
+ * Used to avoid livelocks due to a cgroup having a non-zero charge count but
+ * no pages on its LRUs, e.g. due to a dead enclave waiting to be released or
+ * because all pages in the cgroup are unreclaimable.
+ */
+bool sgx_epc_cgroup_lru_empty(struct sgx_epc_cgroup *root)
+{
+	struct sgx_epc_cgroup *epc_cg;
+
+	for (epc_cg = sgx_epc_cgroup_iter(NULL, root, NULL);
+	     epc_cg;
+	     epc_cg = sgx_epc_cgroup_iter(epc_cg, root, NULL)) {
+		if (!list_empty(&epc_cg->lru.reclaimable)) {
+			sgx_epc_cgroup_iter_break(epc_cg, root);
+			return false;
+		}
+	}
+	return true;
+}
+
+/**
+ * sgx_epc_cgroup_isolate_pages - walk a cgroup tree and separate pages
+ * @root:	root of the tree to start walking
+ * @nr_to_scan: The number of pages that need to be isolated
+ * @dst:	Destination list to hold the isolated pages
+ *
+ * Walk the cgroup tree and isolate the pages in the hierarchy
+ * for reclaiming.
+ */
+void sgx_epc_cgroup_isolate_pages(struct sgx_epc_cgroup *root,
+				  int *nr_to_scan, struct list_head *dst)
+{
+        struct sgx_epc_cgroup *epc_cg;
+        unsigned long epoch;
+
+	if (!*nr_to_scan)
+		return;
+
+        for (epc_cg = sgx_epc_cgroup_iter(NULL, root, &epoch);
+             epc_cg;
+             epc_cg = sgx_epc_cgroup_iter(epc_cg, root, &epoch)) {
+                sgx_isolate_epc_pages(&epc_cg->lru, nr_to_scan, dst);
+                if (!*nr_to_scan) {
+                        sgx_epc_cgroup_iter_break(epc_cg, root);
+                        break;
+                }
+        }
+}
+
+static int sgx_epc_cgroup_reclaim_pages(unsigned long nr_pages,
+					struct sgx_epc_reclaim_control *rc)
+{
+	/*
+	 * Ensure sgx_reclaim_pages is called with a minimum and maximum
+	 * number of pages.  Attempting to reclaim only a few pages will
+	 * often fail and is inefficient, while reclaiming a huge number
+	 * of pages can result in soft lockups due to holding various
+	 * locks for an extended duration.  This also bounds nr_pages so
+	 */
+	nr_pages = max(nr_pages, SGX_EPC_RECLAIM_MIN_PAGES);
+	nr_pages = min(nr_pages, SGX_EPC_RECLAIM_MAX_PAGES);
+
+	return sgx_reclaim_epc_pages(nr_pages, rc->ignore_age, rc->epc_cg);
+}
+
+static int sgx_epc_cgroup_reclaim_failed(struct sgx_epc_reclaim_control *rc)
+{
+	if (sgx_epc_cgroup_lru_empty(rc->epc_cg))
+		return -ENOMEM;
+
+	++rc->nr_fails;
+	if (rc->nr_fails > SGX_EPC_RECLAIM_IGNORE_AGE_THRESHOLD)
+		rc->ignore_age = true;
+
+	return 0;
+}
+
+static inline
+void sgx_epc_reclaim_control_init(struct sgx_epc_reclaim_control *rc,
+				  struct sgx_epc_cgroup *epc_cg)
+{
+	rc->epc_cg = epc_cg;
+	rc->nr_fails = 0;
+	rc->ignore_age = false;
+}
+
+/*
+ * Scheduled by sgx_epc_cgroup_try_charge() to reclaim pages from the
+ * cgroup when the cgroup is at/near its maximum capacity
+ */
+static void sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
+{
+	struct sgx_epc_reclaim_control rc;
+	struct sgx_epc_cgroup *epc_cg;
+	unsigned long cur, max;
+
+	epc_cg = container_of(work, struct sgx_epc_cgroup, reclaim_work);
+
+	sgx_epc_reclaim_control_init(&rc, epc_cg);
+
+	for (;;) {
+		max = sgx_epc_cgroup_max_pages(epc_cg);
+
+		/*
+		 * Adjust the limit down by one page, the goal is to free up
+		 * pages for fault allocations, not to simply obey the limit.
+		 * Conditionally decrementing max also means the cur vs. max
+		 * check will correctly handle the case where both are zero.
+		 */
+		if (max)
+			max--;
+
+		/*
+		 * Unless the limit is extremely low, in which case forcing
+		 * reclaim will likely cause thrashing, force the cgroup to
+		 * reclaim at least once if it's operating *near* its maximum
+		 * limit by adjusting @max down by half the min reclaim size.
+		 * This work func is scheduled by sgx_epc_cgroup_try_charge
+		 * when it cannot directly reclaim due to being in an atomic
+		 * context, e.g. EPC allocation in a fault handler.  Waiting
+		 * to reclaim until the cgroup is actually at its limit is less
+		 * performant as it means the faulting task is effectively
+		 * blocked until a worker makes its way through the global work
+		 * queue.
+		 */
+		if (max > SGX_EPC_RECLAIM_MAX_PAGES)
+			max -= (SGX_EPC_RECLAIM_MIN_PAGES/2);
+
+		cur = sgx_epc_cgroup_page_counter_read(epc_cg);
+		if (cur <= max)
+			break;
+
+		if (!sgx_epc_cgroup_reclaim_pages(cur - max, &rc)) {
+			if (sgx_epc_cgroup_reclaim_failed(&rc))
+				break;
+		}
+	}
+}
+
+static int __sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg,
+				       unsigned long nr_pages, bool reclaim)
+{
+	struct sgx_epc_reclaim_control rc;
+	unsigned long cur, max, over;
+	unsigned int nr_empty = 0;
+
+	if (epc_cg == sgx_epc_cgroup_from_misc_cg(misc_cg_root())) {
+		misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
+				   nr_pages * PAGE_SIZE);
+		return 0;
+	}
+
+	sgx_epc_reclaim_control_init(&rc, NULL);
+
+	for (;;) {
+		if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
+					nr_pages * PAGE_SIZE))
+			break;
+
+		rc.epc_cg = epc_cg;
+		max = sgx_epc_cgroup_max_pages(rc.epc_cg);
+		if (nr_pages > max)
+			return -ENOMEM;
+
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+
+		if (!reclaim) {
+			queue_work(sgx_epc_cg_wq, &rc.epc_cg->reclaim_work);
+			return -EBUSY;
+		}
+
+		cur = sgx_epc_cgroup_page_counter_read(rc.epc_cg);
+		over = ((cur + nr_pages) > max) ?
+			(cur + nr_pages) - max : SGX_EPC_RECLAIM_MIN_PAGES;
+
+		if (!sgx_epc_cgroup_reclaim_pages(over, &rc)) {
+			if (sgx_epc_cgroup_reclaim_failed(&rc)) {
+				if (++nr_empty > SGX_EPC_RECLAIM_OOM_THRESHOLD)
+					return -ENOMEM;
+				schedule();
+			}
+		}
+	}
+
+	css_get_many(&epc_cg->cg->css, nr_pages);
+
+	return 0;
+}
+
+
+/**
+ * sgx_epc_cgroup_try_charge - hierarchically try to charge a single EPC page
+ * @mm:			the mm_struct of the process to charge
+ * @reclaim:		whether or not synchronous reclaim is allowed
+ *
+ * Returns EPC cgroup or NULL on success, -errno on failure.
+ */
+struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(struct mm_struct *mm,
+						 bool reclaim)
+{
+	struct sgx_epc_cgroup *epc_cg;
+	int ret;
+
+	if (sgx_epc_cgroup_disabled())
+		return NULL;
+
+	epc_cg = sgx_epc_cgroup_from_misc_cg(get_current_misc_cg());
+	ret = __sgx_epc_cgroup_try_charge(epc_cg, 1, reclaim);
+	put_misc_cg(epc_cg->cg);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	return epc_cg;
+}
+
+/**
+ * sgx_epc_cgroup_uncharge - hierarchically uncharge EPC pages
+ * @epc_cg:	the charged epc cgroup
+ */
+void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg)
+{
+	if (sgx_epc_cgroup_disabled())
+		return;
+
+	misc_cg_uncharge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
+
+	if (epc_cg->cg != misc_cg_root())
+		put_misc_cg(epc_cg->cg);
+}
+
+static void sgx_epc_cgroup_oom(struct sgx_epc_cgroup *root)
+{
+	struct sgx_epc_cgroup *epc_cg;
+
+	for (epc_cg = sgx_epc_cgroup_iter(NULL, root, NULL);
+	     epc_cg;
+	     epc_cg = sgx_epc_cgroup_iter(epc_cg, root, NULL)) {
+		if (sgx_epc_oom(&epc_cg->lru)) {
+			sgx_epc_cgroup_iter_break(epc_cg, root);
+			return;
+		}
+	}
+}
+
+static void sgx_epc_cgroup_released(struct misc_cg *cg)
+{
+	struct sgx_epc_cgroup *dead_cg;
+	struct sgx_epc_cgroup *epc_cg;
+
+	epc_cg = sgx_epc_cgroup_from_misc_cg(cg);
+	dead_cg = epc_cg;
+
+	while ((epc_cg = parent_epc_cgroup(epc_cg)))
+		cmpxchg(&epc_cg->reclaim_iter, dead_cg, NULL);
+}
+
+static void sgx_epc_cgroup_free(struct misc_cg *cg)
+{
+	struct sgx_epc_cgroup *epc_cg;
+
+	epc_cg = sgx_epc_cgroup_from_misc_cg(cg);
+	cancel_work_sync(&epc_cg->reclaim_work);
+	kfree(epc_cg);
+}
+
+static void sgx_epc_cgroup_max_write(struct misc_cg *cg)
+{
+	struct sgx_epc_reclaim_control rc;
+	struct sgx_epc_cgroup *epc_cg;
+	unsigned int nr_empty = 0;
+	unsigned long cur, max;
+
+	epc_cg = sgx_epc_cgroup_from_misc_cg(cg);
+
+	sgx_epc_reclaim_control_init(&rc, epc_cg);
+
+	max = sgx_epc_cgroup_max_pages(epc_cg);
+
+	for (;;) {
+		cur = sgx_epc_cgroup_page_counter_read(epc_cg);
+		if (cur <= max)
+			break;
+
+		if (signal_pending(current))
+			break;
+
+		if (!sgx_epc_cgroup_reclaim_pages(cur - max, &rc)) {
+			if (sgx_epc_cgroup_reclaim_failed(&rc)) {
+				if (++nr_empty > SGX_EPC_RECLAIM_OOM_THRESHOLD)
+					sgx_epc_cgroup_oom(epc_cg);
+				schedule();
+			}
+		}
+	}
+}
+
+static int sgx_epc_cgroup_alloc(struct misc_cg *cg)
+{
+	struct sgx_epc_cgroup *epc_cg;
+
+	epc_cg = kzalloc(sizeof(struct sgx_epc_cgroup), GFP_KERNEL);
+	if (!epc_cg)
+		return -ENOMEM;
+
+	sgx_lru_init(&epc_cg->lru);
+	INIT_WORK(&epc_cg->reclaim_work, sgx_epc_cgroup_reclaim_work_func);
+	cg->res[MISC_CG_RES_SGX_EPC].misc_cg_alloc = sgx_epc_cgroup_alloc;
+	cg->res[MISC_CG_RES_SGX_EPC].misc_cg_free = sgx_epc_cgroup_free;
+	cg->res[MISC_CG_RES_SGX_EPC].misc_cg_released = sgx_epc_cgroup_released;
+	cg->res[MISC_CG_RES_SGX_EPC].misc_cg_max_write = sgx_epc_cgroup_max_write;
+	cg->res[MISC_CG_RES_SGX_EPC].priv = epc_cg;
+	epc_cg->cg = cg;
+	return 0;
+}
+
+static int __init sgx_epc_cgroup_init(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_SGX))
+		return 0;
+
+	sgx_epc_cg_wq = alloc_workqueue("sgx_epc_cg_wq",
+					WQ_UNBOUND | WQ_FREEZABLE,
+					WQ_UNBOUND_MAX_ACTIVE);
+	BUG_ON(!sgx_epc_cg_wq);
+
+	return sgx_epc_cgroup_alloc(misc_cg_root());
+}
+subsys_initcall(sgx_epc_cgroup_init);
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
new file mode 100644
index 000000000000..bc358934dbe2
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2022 Intel Corporation. */
+#ifndef _INTEL_SGX_EPC_CGROUP_H_
+#define _INTEL_SGX_EPC_CGROUP_H_
+
+#include <asm/sgx.h>
+#include <linux/cgroup.h>
+#include <linux/list.h>
+#include <linux/misc_cgroup.h>
+#include <linux/page_counter.h>
+#include <linux/workqueue.h>
+
+#include "sgx.h"
+
+#ifndef CONFIG_CGROUP_SGX_EPC
+#define MISC_CG_RES_SGX_EPC MISC_CG_RES_TYPES
+struct sgx_epc_cgroup;
+
+static inline struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(struct mm_struct *mm,
+							       bool reclaim)
+{
+	return NULL;
+}
+static inline void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg) { }
+static inline void sgx_epc_cgroup_isolate_pages(struct sgx_epc_cgroup *root,
+						int *nr_to_scan,
+						struct list_head *dst) { }
+static inline struct sgx_epc_lru_lists *epc_cg_lru(struct sgx_epc_cgroup *epc_cg)
+{
+	return NULL;
+}
+static bool sgx_epc_cgroup_lru_empty(struct sgx_epc_cgroup *root)
+{
+	return true;
+}
+#else
+struct sgx_epc_cgroup {
+	struct misc_cg *cg;
+	struct sgx_epc_lru_lists	lru;
+	struct sgx_epc_cgroup	*reclaim_iter;
+	struct work_struct	reclaim_work;
+	unsigned int		epoch;
+};
+
+struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(struct mm_struct *mm,
+						 bool reclaim);
+void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
+bool sgx_epc_cgroup_lru_empty(struct sgx_epc_cgroup *root);
+void sgx_epc_cgroup_isolate_pages(struct sgx_epc_cgroup *root,
+				  int *nr_to_scan, struct list_head *dst);
+static inline struct sgx_epc_lru_lists *epc_cg_lru(struct sgx_epc_cgroup *epc_cg)
+{
+	if (epc_cg)
+		return &epc_cg->lru;
+	return NULL;
+}
+#endif
+
+#endif /* _INTEL_SGX_EPC_CGROUP_H_ */
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 70046c4e332a..a9d5cfd4e024 100644
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
 
 #define SGX_MAX_NR_TO_RECLAIM	32
 
@@ -33,9 +35,20 @@ static DEFINE_XARRAY(sgx_epc_address_space);
 static struct sgx_epc_lru_lists sgx_global_lru;
 static inline struct sgx_epc_lru_lists *sgx_lru_lists(struct sgx_epc_page *epc_page)
 {
+        if (IS_ENABLED(CONFIG_CGROUP_SGX_EPC))
+		return epc_cg_lru(epc_page->epc_cg);
+
 	return &sgx_global_lru;
 }
 
+static inline bool sgx_can_reclaim(void)
+{
+        if (!IS_ENABLED(CONFIG_CGROUP_SGX_EPC))
+		return !list_empty(&sgx_global_lru.reclaimable);
+
+	return !sgx_epc_cgroup_lru_empty(NULL);
+}
+
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
 /* Nodes with one or more EPC sections. */
@@ -320,9 +333,10 @@ void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lru, int *nr_to_scan,
 }
 
 /**
- * sgx_reclaim_epc_pages() - Reclaim EPC pages from the consumers
+ * __sgx_reclaim_epc_pages() - Reclaim EPC pages from the consumers
  * @nr_to_scan:		 Number of EPC pages to scan for reclaim
  * @ignore_age:		 Reclaim a page even if it is young
+ * @epc_cg:		 EPC cgroup from which to reclaim
  *
  * Take a fixed number of pages from the head of the active page pool and
  * reclaim them to the enclave's private shmem files. Skip the pages, which have
@@ -336,7 +350,8 @@ void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lru, int *nr_to_scan,
  * problematic as it would increase the lock contention too much, which would
  * halt forward progress.
  */
-static int __sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
+static int __sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age,
+			  struct sgx_epc_cgroup *epc_cg)
 {
 	struct sgx_backing backing[SGX_MAX_NR_TO_RECLAIM];
 	struct sgx_epc_page *epc_page, *tmp;
@@ -347,7 +362,15 @@ static int __sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
 	int i = 0;
 	int ret;
 
-	sgx_isolate_epc_pages(&sgx_global_lru, &nr_to_scan, &iso);
+        /*
+         * If a specific cgroup is not being targetted, take from the global
+         * list first, even when cgroups are enabled.  If there are
+         * pages on the global LRU then they should get reclaimed asap.
+         */
+        if (!IS_ENABLED(CONFIG_CGROUP_SGX_EPC) || !epc_cg)
+                sgx_isolate_epc_pages(&sgx_global_lru, &nr_to_scan, &iso);
+
+	sgx_epc_cgroup_isolate_pages(epc_cg, &nr_to_scan, &iso);
 
 	if (list_empty(&iso))
 		return 0;
@@ -397,25 +420,33 @@ static int __sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
 				     SGX_EPC_PAGE_ENCLAVE |
 				     SGX_EPC_PAGE_VERSION_ARRAY);
 
+		if (epc_page->epc_cg) {
+			sgx_epc_cgroup_uncharge(epc_page->epc_cg);
+			epc_page->epc_cg = NULL;
+		}
+
 		sgx_free_epc_page(epc_page);
 	}
 	return i;
 }
 
-int sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age)
+/**
+ * sgx_reclaim_epc_pages() - wrapper for __sgx_reclaim_epc_pages which
+ * 			     calls cond_resched() upon completion.
+ * @nr_to_scan:		Number of EPC pages to scan for reclaim
+ * @ignore_age:		Reclaim a page even if it is young
+ * @epc_cg:		EPC cgroup from which to reclaim
+ */
+int sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age,
+			  struct sgx_epc_cgroup *epc_cg)
 {
 	int ret;
 
-	ret = __sgx_reclaim_pages(nr_to_scan, ignore_age);
+	ret = __sgx_reclaim_epc_pages(nr_to_scan, ignore_age, epc_cg);
 	cond_resched();
 	return ret;
 }
 
-static bool sgx_can_reclaim(void)
-{
-	return !list_empty(&sgx_global_lru.reclaimable);
-}
-
 static bool sgx_should_reclaim(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
@@ -432,7 +463,7 @@ static bool sgx_should_reclaim(unsigned long watermark)
 void sgx_reclaim_direct(void)
 {
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		__sgx_reclaim_pages(SGX_NR_TO_SCAN, false);
+		__sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false, NULL);
 }
 
 static int ksgxd(void *p)
@@ -458,7 +489,7 @@ static int ksgxd(void *p)
 				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
+			sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false, NULL);
 	}
 
 	return 0;
@@ -620,6 +651,11 @@ int sgx_drop_epc_page(struct sgx_epc_page *page)
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 {
 	struct sgx_epc_page *page;
+	struct sgx_epc_cgroup *epc_cg;
+
+	epc_cg = sgx_epc_cgroup_try_charge(current->mm, reclaim);
+	if (IS_ERR(epc_cg))
+		return ERR_CAST(epc_cg);
 
 	for ( ; ; ) {
 		page = __sgx_alloc_epc_page();
@@ -628,8 +664,10 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		if (!sgx_can_reclaim())
-			return ERR_PTR(-ENOMEM);
+		if (!sgx_can_reclaim()) {
+			page = ERR_PTR(-ENOMEM);
+			break;
+		}
 
 		if (!reclaim) {
 			page = ERR_PTR(-EBUSY);
@@ -641,7 +679,14 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
+		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false, NULL);
+	}
+
+	if (!IS_ERR(page)) {
+		WARN_ON(page->epc_cg);
+		page->epc_cg = epc_cg;
+	} else {
+		sgx_epc_cgroup_uncharge(epc_cg);
 	}
 
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
@@ -674,6 +719,12 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 	page->flags = SGX_EPC_PAGE_IS_FREE;
 
 	spin_unlock(&node->lock);
+
+	if (page->epc_cg) {
+		sgx_epc_cgroup_uncharge(page->epc_cg);
+		page->epc_cg = NULL;
+	}
+
 	atomic_long_inc(&sgx_nr_free_pages);
 }
 
@@ -838,6 +889,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		section->pages[i].flags = 0;
 		section->pages[i].encl_owner = NULL;
 		section->pages[i].poison = 0;
+		section->pages[i].epc_cg = NULL;
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
@@ -1002,6 +1054,7 @@ static void __init arch_update_sysfs_visibility(int nid) {}
 static bool __init sgx_page_cache_init(void)
 {
 	u32 eax, ebx, ecx, edx, type;
+	u64 capacity = 0;
 	u64 pa, size;
 	int nid;
 	int i;
@@ -1052,6 +1105,7 @@ static bool __init sgx_page_cache_init(void)
 
 		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
 		sgx_numa_nodes[nid].size += size;
+		capacity += size;
 
 		sgx_nr_epc_sections++;
 	}
@@ -1061,6 +1115,8 @@ static bool __init sgx_page_cache_init(void)
 		return false;
 	}
 
+	misc_cg_set_capacity(MISC_CG_RES_SGX_EPC, capacity);
+
 	return true;
 }
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 1c666b25294b..defb48f51145 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -35,6 +35,8 @@
 #define SGX_EPC_PAGE_ENCLAVE		BIT(4)
 #define SGX_EPC_PAGE_VERSION_ARRAY	BIT(5)
 
+struct sgx_epc_cgroup;
+
 struct sgx_epc_page {
 	unsigned int section;
 	u16 flags;
@@ -46,6 +48,7 @@ struct sgx_epc_page {
 		struct sgx_encl *encl;
 	};
 	struct list_head list;
+	struct sgx_epc_cgroup *epc_cg;
 };
 
 /*
@@ -206,7 +209,8 @@ void sgx_reclaim_direct(void);
 void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags);
 int sgx_drop_epc_page(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
-int sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age);
+int sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age,
+			  struct sgx_epc_cgroup *epc_cg);
 void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lrus, int *nr_to_scan,
 			   struct list_head *dst);
 bool sgx_epc_oom(struct sgx_epc_lru_lists *lrus);
-- 
2.38.1

