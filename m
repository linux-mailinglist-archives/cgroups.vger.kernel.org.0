Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE5D5E6962
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 19:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiIVROb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 13:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiIVROC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 13:14:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0C9103FFA;
        Thu, 22 Sep 2022 10:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663866839; x=1695402839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SG+j0Ze6lCik/OeaYt6iz9BizoJpGhJOsGDfe2GFcks=;
  b=LViibgw+AljhGceNauUL9QYi5ahsRLAxDyCGC8nK+q9p2Yo4Zmd0/ziN
   Hg0l/15MvIVp8R6R1m9V5Ko11w2Fjw2RIKdC2Mu1KFtNuVZnzt21YU44Y
   pM8qDpRmwQsJ8HTl7BHnIgS/rDOAs61Nf44jq3ucCtRHcIqRrs+kWfjRO
   WhXQeMRcwCm0gytSODPVIDGMkh09rr8MJxI+IRaOiXyTkd5aGHzYDJWXD
   R9KY1V/2ZkQStwvVXaWsJDxJLgDU//9l6iYFhYMEd3ALLQaR/Qj/+rgBm
   1aelrzUlP1q83DZsOioYdsbSzVxWmCQ3ia6K1qgC1gjWnYQZxquDMeA65
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283421611"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="283421611"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:12:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="762270229"
Received: from sknaidu-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.165.187])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:11:49 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [RFC PATCH 17/20] cgroup, x86/sgx: Add SGX EPC cgroup controller
Date:   Thu, 22 Sep 2022 10:10:54 -0700
Message-Id: <20220922171057.1236139-18-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922171057.1236139-1-kristen@linux.intel.com>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Implement a cgroup controller, sgx_epc, which regulates distribution of
SGX Enclave Page Cache (EPC) memory.  EPC memory is independent from
normal system memory, e.g. must be reserved at boot from RAM and cannot
be converted between EPC and normal memory while the system is running.
EPC is managed by the SGX subsystem and is not accounted by the memory
controller.

Much like normal system memory, EPC memory can be overcommitted via
virtual memory techniques and pages can be swapped out of the EPC to
their backing store (normal system memory, e.g. shmem).  The SGX EPC
subsystem is analogous to the memory subsytem and the SGX EPC controller
is in turn analogous to the memory controller; it implements limit and
protection models for EPC memory.

"sgx_epc.high" and "sgx_epc.low" are the main mechanisms to control
EPC usage, while "sgx_epc.max" is a last line of defense mechanism.
"sgx_epc.high" is a best-effort limit of EPC usage.  "sgx_epc.low"
is a best-effort protection of EPC usage.  "sgx_epc.max" is a hard
limit of EPC usage.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/Makefile     |   1 +
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 830 +++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  37 ++
 include/linux/cgroup_subsys.h        |   4 +
 init/Kconfig                         |  12 +
 5 files changed, 884 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h

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
index 000000000000..0a61bb8548ff
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -0,0 +1,830 @@
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
+struct sgx_epc_reclaim_control {
+	struct sgx_epc_cgroup *epc_cg;
+	int nr_fails;
+	bool ignore_age;
+};
+
+static struct sgx_epc_cgroup *root_epc_cgroup __read_mostly;
+static struct workqueue_struct *sgx_epc_cg_wq;
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
+	return 0;
+}
+subsys_initcall(sgx_epc_cgroup_init);
+
+static inline bool sgx_epc_cgroup_disabled(void)
+{
+	return !cgroup_subsys_enabled(sgx_epc_cgrp_subsys);
+}
+
+static
+struct sgx_epc_cgroup *sgx_epc_cgroup_from_css(struct cgroup_subsys_state *css)
+{
+	return container_of(css, struct sgx_epc_cgroup, css);
+}
+
+static
+struct sgx_epc_cgroup *sgx_epc_cgroup_from_task(struct task_struct *task)
+{
+	if (unlikely(!task))
+		return NULL;
+	return sgx_epc_cgroup_from_css(task_css(task, sgx_epc_cgrp_id));
+}
+
+static struct sgx_epc_cgroup *sgx_epc_cgroup_from_mm(struct mm_struct *mm)
+{
+	struct sgx_epc_cgroup *epc_cg;
+
+	rcu_read_lock();
+	do {
+		epc_cg = sgx_epc_cgroup_from_task(rcu_dereference(mm->owner));
+		if (unlikely(!epc_cg))
+			epc_cg = root_epc_cgroup;
+	} while (!css_tryget_online(&epc_cg->css));
+	rcu_read_unlock();
+
+	return epc_cg;
+}
+
+static struct sgx_epc_cgroup *parent_epc_cgroup(struct sgx_epc_cgroup *epc_cg)
+{
+	return sgx_epc_cgroup_from_css(epc_cg->css.parent);
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
+		root = root_epc_cgroup;
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
+			if (!pos || css_tryget(&pos->css))
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
+		css = &pos->css;
+
+	while (!epc_cg) {
+		css = css_next_descendant_pre(css, &root->css);
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
+		/*
+		 * Verify the css and acquire a reference.  Don't take an
+		 * extra reference to root as it's either the global root
+		 * or is provided by the caller and so is guaranteed to be
+		 * alive.  Keep walking if this css is dying.
+		 */
+		if (css != &root->css && !css_tryget(css))
+			continue;
+
+		epc_cg = sgx_epc_cgroup_from_css(css);
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
+				css_put(&epc_cg->css);
+			if (pos)
+				css_put(&pos->css);
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
+			css_put(&pos->css);
+	}
+
+out:
+	rcu_read_unlock();
+	if (prev && prev != root)
+		css_put(&prev->css);
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
+		root = root_epc_cgroup;
+	if (prev && prev != root)
+		css_put(&prev->css);
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
+static inline bool __sgx_epc_cgroup_is_low(struct sgx_epc_cgroup *epc_cg)
+{
+	unsigned long cur = page_counter_read(&epc_cg->pc);
+
+	return cur < epc_cg->pc.low &&
+	       cur < epc_cg->high &&
+	       cur < epc_cg->pc.max;
+}
+
+/**
+ * sgx_epc_cgroup_is_low - check if EPC consumption is below the normal range
+ * @epc_cg:	the EPC cgroup to check
+ * @root:	the top ancestor of the sub-tree being checked
+ *
+ * Returns %true if EPC consumption of @epc_cg, and that of all
+ * ancestors up to (but not including) @root, is below the normal range.
+ *
+ * @root is exclusive; it is never low when looked at directly and isn't
+ * checked when traversing the hierarchy.
+ *
+ * Excluding @root enables using sgx_epc.low to prioritize EPC usage
+ * between cgroups within a subtree of the hierarchy that is limited
+ * by sgx_epc.high or sgx_epc.max.
+ *
+ * For example, given cgroup A with children B and C:
+ *
+ *    A
+ *   / \
+ *  B   C
+ *
+ * and
+ *
+ *  1. A/sgx_epc.current > A/sgx_epc.high
+ *  2. A/B/sgx_epc.current < A/B/sgx_epc.low
+ *  3. A/C/sgx_epc.current >= A/C/sgx_epc.low
+ *
+ * As 'A' is high, i.e. triggers reclaim from 'A', and 'B' is low, we
+ * should reclaim from 'C' until 'A' is no longer high or until we can
+ * no longer reclaim from 'C'.  If 'A', i.e. @root, isn't excluded by
+ * when reclaming from 'A', then 'B' will not be considered low and we
+ * will reclaim indiscriminately from both 'B' and 'C'.
+ */
+static bool sgx_epc_cgroup_is_low(struct sgx_epc_cgroup *epc_cg,
+				  struct sgx_epc_cgroup *root)
+{
+	if (sgx_epc_cgroup_disabled())
+		return false;
+
+	if (!root)
+		root = root_epc_cgroup;
+	if (epc_cg == root)
+		return false;
+
+	for (; epc_cg != root; epc_cg = parent_epc_cgroup(epc_cg)) {
+		if (!__sgx_epc_cgroup_is_low(epc_cg))
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * sgx_epc_cgroup_all_in_use_are_low - check if all cgroups in a tree are low
+ * @root:	the root EPC cgroup of the hierarchy to check
+ *
+ * Returns true if all cgroups in a hierarchy are either low or
+ * or do not have any pages on their LRU.
+ */
+static bool sgx_epc_cgroup_all_in_use_are_low(struct sgx_epc_cgroup *root)
+{
+	struct sgx_epc_cgroup *epc_cg;
+
+	if (sgx_epc_cgroup_disabled())
+		return false;
+
+	for (epc_cg = sgx_epc_cgroup_iter(NULL, root, NULL);
+	     epc_cg;
+	     epc_cg = sgx_epc_cgroup_iter(epc_cg, root, NULL)) {
+		if (!list_empty(&epc_cg->lru.reclaimable) &&
+		    !__sgx_epc_cgroup_is_low(epc_cg)) {
+			sgx_epc_cgroup_iter_break(epc_cg, root);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+void sgx_epc_cgroup_isolate_pages(struct sgx_epc_cgroup *root,
+				  int *nr_to_scan, struct list_head *dst)
+{
+        struct sgx_epc_cgroup *epc_cg;
+        unsigned long epoch;
+	bool do_high;
+
+	if (!*nr_to_scan)
+		return;
+
+	/*
+	 * If we're not targeting a specific cgroup, try to reclaim only from
+	 * cgroups that are above their high limit.  If there are none, then go
+	 * ahead and grab anything available.
+	 */
+	do_high = !root;
+retry:
+        for (epc_cg = sgx_epc_cgroup_iter(NULL, root, &epoch);
+             epc_cg;
+             epc_cg = sgx_epc_cgroup_iter(epc_cg, root, &epoch)) {
+		if (do_high && page_counter_read(&epc_cg->pc) < epc_cg->high)
+			continue;
+
+                if (sgx_epc_cgroup_is_low(epc_cg, root)) {
+                        /*
+                         * Ignore low if all cgroups below @root are low,
+			 * in which case low is "normal".
+                         */
+                        if (!sgx_epc_cgroup_all_in_use_are_low(root))
+                                continue;
+                }
+
+                sgx_isolate_epc_pages(&epc_cg->lru, nr_to_scan, dst);
+                if (!*nr_to_scan) {
+                        sgx_epc_cgroup_iter_break(epc_cg, root);
+                        break;
+                }
+        }
+	if (*nr_to_scan && do_high) {
+		do_high = false;
+		goto retry;
+	}
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
+	 * that its guaranteed not to overflow 'int nr_to_scan'.
+	 */
+	nr_pages = max(nr_pages, SGX_EPC_RECLAIM_MIN_PAGES);
+	nr_pages = min(nr_pages, SGX_EPC_RECLAIM_MAX_PAGES);
+
+	return sgx_reclaim_epc_pages(nr_pages, rc->ignore_age);
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
+static inline void __sgx_epc_cgroup_reclaim_high(struct sgx_epc_cgroup *epc_cg)
+{
+	struct sgx_epc_reclaim_control rc;
+	unsigned long cur, high;
+
+	sgx_epc_reclaim_control_init(&rc, epc_cg);
+
+	for (;;) {
+		high = READ_ONCE(epc_cg->high);
+
+		cur = page_counter_read(&epc_cg->pc);
+		if (cur <= high)
+			break;
+
+		if (!sgx_epc_cgroup_reclaim_pages(cur - high, &rc)) {
+			if (sgx_epc_cgroup_reclaim_failed(&rc))
+				break;
+		}
+	}
+}
+
+static void sgx_epc_cgroup_reclaim_high(struct sgx_epc_cgroup *epc_cg)
+{
+	for (; epc_cg; epc_cg = parent_epc_cgroup(epc_cg))
+		__sgx_epc_cgroup_reclaim_high(epc_cg);
+}
+
+/*
+ * Scheduled by sgx_epc_cgroup_try_charge() to reclaim pages from the
+ * cgroup, either when the cgroup is at/near its maximum capacity or
+ * when the cgroup is above its high threshold.
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
+		max = READ_ONCE(epc_cg->pc.max);
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
+		cur = page_counter_read(&epc_cg->pc);
+		if (cur <= max)
+			break;
+
+		if (!sgx_epc_cgroup_reclaim_pages(cur - max, &rc)) {
+			if (sgx_epc_cgroup_reclaim_failed(&rc))
+				break;
+		}
+	}
+
+	sgx_epc_cgroup_reclaim_high(epc_cg);
+}
+
+static int __sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg,
+				       unsigned long nr_pages, bool reclaim)
+{
+	struct sgx_epc_reclaim_control rc;
+	unsigned long cur, max, over;
+	unsigned int nr_empty = 0;
+	struct page_counter *fail;
+
+	if (epc_cg == root_epc_cgroup) {
+		page_counter_charge(&epc_cg->pc, nr_pages);
+		return 0;
+	}
+
+	sgx_epc_reclaim_control_init(&rc, NULL);
+
+	for (;;) {
+		if (page_counter_try_charge(&epc_cg->pc, nr_pages, &fail))
+			break;
+
+		rc.epc_cg = container_of(fail, struct sgx_epc_cgroup, pc);
+		max = READ_ONCE(rc.epc_cg->pc.max);
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
+		cur = page_counter_read(&rc.epc_cg->pc);
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
+	css_get_many(&epc_cg->css, nr_pages);
+
+	for (; epc_cg; epc_cg = parent_epc_cgroup(epc_cg)) {
+		if (page_counter_read(&epc_cg->pc) >= epc_cg->high) {
+			if (!reclaim)
+				queue_work(sgx_epc_cg_wq, &epc_cg->reclaim_work);
+			else
+				sgx_epc_cgroup_reclaim_high(epc_cg);
+			break;
+		}
+	}
+	return 0;
+}
+
+
+/**
+ * sgx_epc_cgroup_try_charge - hierarchically try to charge a single EPC page
+ * @mm:			the mm_struct of the process to charge
+ * @reclaim:		whether or not synchronous reclaim is allowed
+ * @epc_cg_ptr:		out parameter for the charged EPC cgroup
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
+	epc_cg = sgx_epc_cgroup_from_mm(mm);
+	ret = __sgx_epc_cgroup_try_charge(epc_cg, 1, reclaim);
+	css_put(&epc_cg->css);
+
+	if (ret)
+		return ERR_PTR(ret);
+	return epc_cg;
+}
+
+/**
+ * sgx_epc_cgroup_uncharge - hierarchically uncharge EPC pages
+ * @epc_cg:	the charged epc cgroup
+ * @nr_pages:	the number of pages to uncharge
+ */
+void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg)
+{
+	if (sgx_epc_cgroup_disabled())
+		return;
+
+	page_counter_uncharge(&epc_cg->pc, 1);
+
+	if (epc_cg != root_epc_cgroup)
+		css_put_many(&epc_cg->css, 1);
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
+static struct cgroup_subsys_state *
+sgx_epc_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
+{
+	struct sgx_epc_cgroup *parent = sgx_epc_cgroup_from_css(parent_css);
+	struct sgx_epc_cgroup *epc_cg;
+
+	epc_cg = kzalloc(sizeof(struct sgx_epc_cgroup), GFP_KERNEL);
+	if (!epc_cg)
+		return ERR_PTR(-ENOMEM);
+
+	if (!parent)
+		root_epc_cgroup = epc_cg;
+
+	epc_cg->high = PAGE_COUNTER_MAX;
+	sgx_lru_init(&epc_cg->lru);
+	page_counter_init(&epc_cg->pc, parent ? &parent->pc : NULL);
+	INIT_WORK(&epc_cg->reclaim_work, sgx_epc_cgroup_reclaim_work_func);
+
+	return &epc_cg->css;
+}
+
+static void sgx_epc_cgroup_css_released(struct cgroup_subsys_state *css)
+{
+	struct sgx_epc_cgroup *epc_cg = sgx_epc_cgroup_from_css(css);
+	struct sgx_epc_cgroup *dead_cg = epc_cg;
+
+	while ((epc_cg = parent_epc_cgroup(epc_cg)))
+		cmpxchg(&epc_cg->reclaim_iter, dead_cg, NULL);
+}
+
+static void sgx_epc_cgroup_css_free(struct cgroup_subsys_state *css)
+{
+	struct sgx_epc_cgroup *epc_cg = sgx_epc_cgroup_from_css(css);
+
+	cancel_work_sync(&epc_cg->reclaim_work);
+	kfree(epc_cg);
+}
+
+static u64 sgx_epc_current_read(struct cgroup_subsys_state *css,
+				struct cftype *cft)
+{
+	struct sgx_epc_cgroup *epc_cg = sgx_epc_cgroup_from_css(css);
+
+	return (u64)page_counter_read(&epc_cg->pc) * PAGE_SIZE;
+}
+
+static int sgx_epc_low_show(struct seq_file *m, void *v)
+{
+	struct sgx_epc_cgroup *epc_cg = sgx_epc_cgroup_from_css(seq_css(m));
+	unsigned long low = READ_ONCE(epc_cg->pc.low);
+
+	if (low == PAGE_COUNTER_MAX)
+		seq_puts(m, "max\n");
+	else
+		seq_printf(m, "%llu\n", (u64)low * PAGE_SIZE);
+
+	return 0;
+}
+
+static ssize_t sgx_epc_low_write(struct kernfs_open_file *of,
+				 char *buf, size_t nbytes, loff_t off)
+{
+	struct sgx_epc_cgroup *epc_cg = sgx_epc_cgroup_from_css(of_css(of));
+	unsigned long low;
+	int err;
+
+	buf = strstrip(buf);
+	err = page_counter_memparse(buf, "max", &low);
+	if (err)
+		return err;
+
+	page_counter_set_low(&epc_cg->pc, low);
+
+	return nbytes;
+}
+
+static int sgx_epc_high_show(struct seq_file *m, void *v)
+{
+	struct sgx_epc_cgroup *epc_cg = sgx_epc_cgroup_from_css(seq_css(m));
+	unsigned long high = READ_ONCE(epc_cg->high);
+
+	if (high == PAGE_COUNTER_MAX)
+		seq_puts(m, "max\n");
+	else
+		seq_printf(m, "%llu\n", (u64)high * PAGE_SIZE);
+
+	return 0;
+}
+
+static ssize_t sgx_epc_high_write(struct kernfs_open_file *of,
+				  char *buf, size_t nbytes, loff_t off)
+{
+	struct sgx_epc_cgroup *epc_cg = sgx_epc_cgroup_from_css(of_css(of));
+	struct sgx_epc_reclaim_control rc;
+	unsigned long cur, high;
+	int err;
+
+	buf = strstrip(buf);
+	err = page_counter_memparse(buf, "max", &high);
+	if (err)
+		return err;
+
+	epc_cg->high = high;
+
+	sgx_epc_reclaim_control_init(&rc, epc_cg);
+
+	for (;;) {
+		cur = page_counter_read(&epc_cg->pc);
+		if (cur <= high)
+			break;
+
+		if (signal_pending(current))
+			break;
+
+		if (!sgx_epc_cgroup_reclaim_pages(cur - high, &rc)) {
+			if (sgx_epc_cgroup_reclaim_failed(&rc))
+				break;
+		}
+	}
+
+	return nbytes;
+}
+
+static int sgx_epc_max_show(struct seq_file *m, void *v)
+{
+	struct sgx_epc_cgroup *epc_cg = sgx_epc_cgroup_from_css(seq_css(m));
+	unsigned long max = READ_ONCE(epc_cg->pc.max);
+
+	if (max == PAGE_COUNTER_MAX)
+		seq_puts(m, "max\n");
+	else
+		seq_printf(m, "%llu\n", (u64)max * PAGE_SIZE);
+
+	return 0;
+}
+
+
+static ssize_t sgx_epc_max_write(struct kernfs_open_file *of, char *buf,
+				 size_t nbytes, loff_t off)
+{
+	struct sgx_epc_cgroup *epc_cg = sgx_epc_cgroup_from_css(of_css(of));
+	struct sgx_epc_reclaim_control rc;
+	unsigned int nr_empty = 0;
+	unsigned long cur, max;
+	int err;
+
+	buf = strstrip(buf);
+	err = page_counter_memparse(buf, "max", &max);
+	if (err)
+		return err;
+
+	xchg(&epc_cg->pc.max, max);
+
+	sgx_epc_reclaim_control_init(&rc, epc_cg);
+
+	for (;;) {
+		cur = page_counter_read(&epc_cg->pc);
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
+
+	return nbytes;
+}
+
+static struct cftype sgx_epc_cgroup_files[] = {
+	{
+		.name = "current",
+		.read_u64 = sgx_epc_current_read,
+	},
+	{
+		.name = "low",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = sgx_epc_low_show,
+		.write = sgx_epc_low_write,
+	},
+	{
+		.name = "high",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = sgx_epc_high_show,
+		.write = sgx_epc_high_write,
+	},
+	{
+		.name = "max",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = sgx_epc_max_show,
+		.write = sgx_epc_max_write,
+	},
+	{ }	/* terminate */
+};
+
+struct cgroup_subsys sgx_epc_cgrp_subsys = {
+	.css_alloc	= sgx_epc_cgroup_css_alloc,
+	.css_free	= sgx_epc_cgroup_css_free,
+	.css_released	= sgx_epc_cgroup_css_released,
+
+	.legacy_cftypes	= sgx_epc_cgroup_files,
+	.dfl_cftypes	= sgx_epc_cgroup_files,
+};
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
new file mode 100644
index 000000000000..226304a3d523
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2022 Intel Corporation. */
+#ifndef _INTEL_SGX_EPC_CGROUP_H_
+#define _INTEL_SGX_EPC_CGROUP_H_
+
+#include <asm/sgx.h>
+#include <linux/cgroup.h>
+#include <linux/list.h>
+#include <linux/page_counter.h>
+#include <linux/workqueue.h>
+
+#include "sgx.h"
+
+#ifndef CONFIG_CGROUP_SGX_EPC
+struct sgx_epc_cgroup;
+#else
+struct sgx_epc_cgroup {
+	struct cgroup_subsys_state	css;
+
+	struct page_counter	pc;
+	unsigned long		high;
+
+	struct sgx_epc_lru	lru;
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
+#endif
+
+#endif /* _INTEL_SGX_EPC_CGROUP_H_ */
diff --git a/include/linux/cgroup_subsys.h b/include/linux/cgroup_subsys.h
index 445235487230..ff7fbb3e057a 100644
--- a/include/linux/cgroup_subsys.h
+++ b/include/linux/cgroup_subsys.h
@@ -65,6 +65,10 @@ SUBSYS(rdma)
 SUBSYS(misc)
 #endif
 
+#if IS_ENABLED(CONFIG_CGROUP_SGX_EPC)
+SUBSYS(sgx_epc)
+#endif
+
 /*
  * The following subsystems are not supported on the default hierarchy.
  */
diff --git a/init/Kconfig b/init/Kconfig
index 80fe60fa77fb..aba7502b40b0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1178,6 +1178,18 @@ config CGROUP_MISC
 	  For more information, please check misc cgroup section in
 	  /Documentation/admin-guide/cgroup-v2.rst.
 
+config CGROUP_SGX_EPC
+	bool "Enclave Page Cache (EPC) controller for Intel SGX"
+	depends on X86_SGX && MEMCG
+	select PAGE_COUNTER
+	help
+	  Provides control over the EPC footprint of tasks in a cgroup.
+	  EPC is a subset of regular memory that is usable only by SGX
+	  enclaves and is very limited in quantity, e.g. less than 1%
+	  of total DRAM.
+
+          Say N if unsure.
+
 config CGROUP_DEBUG
 	bool "Debug controller"
 	default n
-- 
2.37.3

