Return-Path: <cgroups+bounces-8741-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF81FB07EBE
	for <lists+cgroups@lfdr.de>; Wed, 16 Jul 2025 22:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9007D4A78CC
	for <lists+cgroups@lfdr.de>; Wed, 16 Jul 2025 20:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E946E2C15BF;
	Wed, 16 Jul 2025 20:21:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3928C2D1
	for <cgroups@vger.kernel.org>; Wed, 16 Jul 2025 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697271; cv=none; b=MwEp1ENLFegVefuBhSjV5lQ45B1RgdYv15QSo5YCZZl9QKmYVGFHy9UhgIZLKcLxOkCEX8LMyN0j/QdnW5HlF4o7unst2fztiuXjy/MEy2a8QeKsGFcAfNDO44Mcb4rReWs+clvU+RNCU03UzyfDuknGXL2P6ZIeev3nXYK7gWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697271; c=relaxed/simple;
	bh=Z/BWOFpvwZAZAJI47MPQixk2F9MhyQLIGpRqWCZMwbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPV/MN6gay2tZBNFgeHaQWtBls8A85rIcpOUVIzFDWigDJRQbqsdtOcU98hte7d5jS13F7ODhj2thC2JCbSV6TjIB6w0PaBqmHCQdEWvB5WE3UfZrCGcZ9akAENWodlrB8ChfhPS3DFiPl7wJ8hN8K0cMI0oD2twtuxfj9iOq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 17 Jul 2025 05:20:55 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	chrisl@kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gunho.lee@lge.com,
	iamjoonsoo.kim@lge.com,
	taejoon.song@lge.com,
	Youngjun Park <youngjun.park@lge.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for cgroup-based swap priority
Date: Thu, 17 Jul 2025 05:20:03 +0900
Message-Id: <20250716202006.3640584-2-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716202006.3640584-1-youngjun.park@lge.com>
References: <20250716202006.3640584-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In resource-constrained environments with limited RAM and storage, it is
often desirable to utilize remote or heterogeneous storage devices as swap
targets. To maximize responsiveness under memory pressure, particularly for
latency-critical applications, it is important to control which cgroups use
which swap devices.

This patch introduces a mechanism for assigning swap device priorities on a
per-cgroup basis. By allowing cgroups to customize the relative priority of
available swap devices, faster local swap can be reserved for critical
workloads, while background tasks can be directed to slower or remote swap.

This commit provides the base infrastructure for priority tracking:

- Introduces `memory.swap.priority`, a new cgroup2 interface that allows
  setting per-device priorities using `<id> <priority>` pairs. The swap
  device ID corresponds to the identifier in `/proc/swaps`.

- Internally, priorities are tracked with `struct swap_cgroup_priority`,
  which holds dynamically allocated pnode structures (`struct
  swap_cgroup_priority_pnode`) per device.

- Objects are created on-demand when the cgroup interface is written to,
  and automatically freed when:
    - The configured priorities match the global system defaults
    - The memory cgroup is removed

- Swapon and swapoff propagation is supported:
    - When a new swap device is activated, default values (e.g.,
      `default none`, `default disabled`) determine how the cgroup treats
      that device
    - When a swap device is removed via `swapoff`, it is cleared from all
      affected cgroups

- Priority semantics follow the global swap rules:
    - Higher values are preferred
    - Equal values round-robin
    - Negative values follow NUMA-aware fallback

The default value mechanism (`default none`, `default disabled`) was proposed
by Michal Koutný and integrated into the design to better support swapon
propagation and reduce configuration overhead.

The general design, including how to track priorities and manage per-cgroup
objects, was refined through internal discussions with Joonsoo Kim.

Enforcement logic within the swap allocator is introduced in the next patch.

Suggested-by: Michal Koutný <mkoutny@suse.com>
Suggested-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  62 ++
 MAINTAINERS                             |   2 +
 include/linux/memcontrol.h              |   3 +
 include/linux/swap.h                    |   3 +
 mm/Kconfig                              |  14 +
 mm/Makefile                             |   1 +
 mm/memcontrol.c                         |  91 ++-
 mm/swap_cgroup_priority.c               | 739 ++++++++++++++++++++++++
 mm/swap_cgroup_priority.h               |  86 +++
 mm/swapfile.c                           |  17 +-
 10 files changed, 1009 insertions(+), 9 deletions(-)
 create mode 100644 mm/swap_cgroup_priority.c
 create mode 100644 mm/swap_cgroup_priority.h

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index bd98ea3175ec..35fb9677f0d6 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1839,6 +1839,68 @@ The following nested keys are defined.
 	higher than the limit for an extended period of time.  This
 	reduces the impact on the workload and memory management.
 
+  memory.swap.priority
+    A read-write flat-keyed file which exists on non-root cgroups.
+    This interface allows you to set per-swap-device priorities for the current
+    cgroup and to define how they differ from the global swap system.
+
+    To assign priorities or define specific behaviors for swap devices
+    in the current cgroup, write one or more lines in the following
+    formats:
+
+     - <swap_device_id> <priority>
+     - <swap_device_id> disabled
+     - <swap_device_id> none
+     - default none
+     - default disabled
+
+    Each <swap_device_id> refers to a unique swap device registered
+    in the system. You can check the ID, device path, and current
+    priority of active swap devices through the `/proc/swaps` file.
+    This provides a clear mapping between swap devices and the IDs
+    used in this interface.
+
+    The 'default' keyword sets the fallback priority behavior rule for
+    this cgroup. If no specific entry matches a swap device, this default
+    applies.
+
+    * 'default none': This is the default if no configuration
+      is explicitly written. Swap devices follow the system-wide
+      swap priorities.
+
+    * 'default disabled': All swap devices are excluded from this cgroup’s
+      swap priority list and will not be used by this cgroup.
+
+    The priority semantics are consistent with the global swap system:
+
+      - Higher numerical values indicate higher preference.
+      - See Documentation/admin-guide/mm/swap_numa.rst for details on
+        swap NUMA autobinding and negative priority rules.
+
+    The handling of negative priorities in this cgroup interface
+    has specific behaviors for assignment and restoration:
+
+    * Negative Priority Assignment
+      This interface allows you to explicitly override priorities with negative
+      values. When you do so, the total number of negative slots and their order
+      may shift depending on how the new value compares to existing ones:
+
+      - If you override an existing priority (whether originally positive or negative)
+        with a smaller (more negative) number, it may push other negative priorities
+        upward (toward zero).
+
+      - If you override an existing negative priority with a larger
+        (less negative) number, it may push other negative priorities
+        downward (more negative).
+
+    * Negative Priority Restoration with 'none'
+      When restoring a device’s priority to its global value using 'none',
+      if the original priority was negative, it might not revert to the exact
+      same global negative value if the total number of negative priorities
+      in the cgroup has decreased. In such cases, you may need to adjust
+      other negative priorities to restore the same ordering as the global
+      swap configuration.
+
   memory.zswap.current
 	A read-only single value file which exists on non-root
 	cgroups.
diff --git a/MAINTAINERS b/MAINTAINERS
index 60bba48f5479..d51ddc2272a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6169,6 +6169,8 @@ F:	mm/memcontrol.c
 F:	mm/memcontrol-v1.c
 F:	mm/memcontrol-v1.h
 F:	mm/swap_cgroup.c
+F:	mm/swap_cgroup_priority.c
+F:	mm/swap_cgroup_priority.h
 F:	samples/cgroup/*
 F:	tools/testing/selftests/cgroup/memcg_protection.m
 F:	tools/testing/selftests/cgroup/test_hugetlb_memcg.c
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 87b6688f124a..625e59f9ecd2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -218,6 +218,9 @@ struct mem_cgroup {
 	bool zswap_writeback;
 #endif
 
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+	struct swap_cgroup_priority *swap_priority;
+#endif
 	/* vmpressure notifications */
 	struct vmpressure vmpressure;
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index bc0e1c275fc0..bfddbec2ee28 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -339,6 +339,9 @@ struct swap_info_struct {
 	struct work_struct discard_work; /* discard worker */
 	struct work_struct reclaim_work; /* reclaim worker */
 	struct list_head discard_clusters; /* discard clusters list */
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+	u64 id;
+#endif
 	struct plist_node avail_lists[]; /*
 					   * entries in swap_avail_heads, one
 					   * entry per node.
diff --git a/mm/Kconfig b/mm/Kconfig
index 781be3240e21..43751e8d0bc4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -190,6 +190,20 @@ config ZSMALLOC_CHAIN_SIZE
 
 	  For more information, see zsmalloc documentation.
 
+config SWAP_CGROUP_PRIORITY
+	bool "Per cgroup swap priority (EXPERIMENTAL)"
+	depends on SWAP && CGROUPS
+	default n
+	help
+          Enable per-cgroup swap device priority control.
+
+          This option allows configuring swap device priorities on a
+          per-cgroup basis, and makes it possible to exclude specific swap
+          devices from use by a cgroup.
+
+          If no configuration is set for a cgroup, it falls back to the
+          system-wide swap device priorities defined at swapon time.
+
 menu "Slab allocator options"
 
 config SLUB
diff --git a/mm/Makefile b/mm/Makefile
index 1a7a11d4933d..dde27ee58a8d 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -76,6 +76,7 @@ ifdef CONFIG_MMU
 endif
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_SWAP_CGROUP_PRIORITY) += swap_cgroup_priority.o
 obj-$(CONFIG_ZSWAP)	+= zswap.o
 obj-$(CONFIG_HAS_DMA)	+= dmapool.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 70fdeda1120b..ea207d498ad6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -69,6 +69,8 @@
 #include <net/ip.h>
 #include "slab.h"
 #include "memcontrol-v1.h"
+#include "swap.h"
+#include "swap_cgroup_priority.h"
 
 #include <linux/uaccess.h>
 
@@ -3700,6 +3702,9 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
 	lru_gen_exit_memcg(memcg);
 	memcg_wb_domain_exit(memcg);
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+	delete_swap_cgroup_priority(memcg);
+#endif
 	__mem_cgroup_free(memcg);
 }
 
@@ -3793,6 +3798,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
 	memcg1_soft_limit_reset(memcg);
+
 #ifdef CONFIG_ZSWAP
 	memcg->zswap_max = PAGE_COUNTER_MAX;
 	WRITE_ONCE(memcg->zswap_writeback, true);
@@ -3800,7 +3806,6 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
-
 		page_counter_init(&memcg->memory, &parent->memory, memcg_on_dfl);
 		page_counter_init(&memcg->swap, &parent->swap, false);
 #ifdef CONFIG_MEMCG_V1
@@ -5401,6 +5406,82 @@ static int swap_events_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+static ssize_t swap_cgroup_priority_write(struct kernfs_open_file *of,
+					  char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	u64 id;
+	int prio;
+	int ret;
+	char first_token[32];
+	char second_token[32];
+	char dummy[2];
+	char *stripped_buf;
+	int num_parsed;
+
+	stripped_buf = strstrip(buf);
+	num_parsed = sscanf(stripped_buf, "%31s %31s %1s", first_token,
+			    second_token, dummy);
+	if (num_parsed == 2) {
+		if (strcmp(first_token, "default") == 0) {
+			if (strcmp(second_token, "none") == 0)
+				ret = apply_swap_cgroup_priority(
+					memcg, DEFAULT_ID, SWAP_PRIORITY_GLOBAL);
+			else if (strcmp(second_token, "disabled") == 0)
+				ret = apply_swap_cgroup_priority(
+					memcg, DEFAULT_ID, SWAP_PRIORITY_DISABLE);
+			else
+				ret = -EINVAL;
+		} else {
+			ret = kstrtoull(first_token, 10, &id);
+			if (ret)
+				return -EINVAL;
+
+			if (strcmp(second_token, "none") == 0) {
+				ret = apply_swap_cgroup_priority(
+					memcg, id, SWAP_PRIORITY_GLOBAL);
+			} else if (strcmp(second_token, "disabled") == 0) {
+				ret = apply_swap_cgroup_priority(
+					memcg, id, SWAP_PRIORITY_DISABLE);
+			} else {
+				ret = kstrtoint(second_token, 10, &prio);
+				if (ret)
+					return -EINVAL;
+				if (prio == -1)
+					return -EINVAL;
+				else if (prio > SHRT_MAX || prio < SHRT_MIN)
+					return -EINVAL;
+				ret = apply_swap_cgroup_priority(memcg, id,
+								 prio);
+			}
+		}
+	} else if (num_parsed == 1) {
+		if (strcmp(first_token, "none") == 0)
+			ret = apply_swap_cgroup_priority(
+				memcg, id, SWAP_PRIORITY_GLOBAL);
+		else if (strcmp(first_token, "disabled") == 0)
+			ret = apply_swap_cgroup_priority(
+				memcg, id, SWAP_PRIORITY_DISABLE);
+		else
+			ret = -EINVAL;
+	} else {
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	return nbytes;
+}
+
+static int swap_cgroup_priority_show(struct seq_file *m, void *v)
+{
+	show_swap_cgroup_priority(m);
+	return 0;
+}
+#endif
+
 static struct cftype swap_files[] = {
 	{
 		.name = "swap.current",
@@ -5433,6 +5514,14 @@ static struct cftype swap_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
 		.seq_show = swap_events_show,
 	},
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+	{
+		.name = "swap.priority",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_cgroup_priority_show,
+		.write = swap_cgroup_priority_write,
+	},
+#endif
 	{ }	/* terminate */
 };
 
diff --git a/mm/swap_cgroup_priority.c b/mm/swap_cgroup_priority.c
new file mode 100644
index 000000000000..abbefa6de63a
--- /dev/null
+++ b/mm/swap_cgroup_priority.c
@@ -0,0 +1,739 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 LG Electronics Inc.
+ *
+ * This file is part of the Linux kernel and implements per-cgroup
+ * swap device priority control.
+ *
+ * This feature allows configuring the preference and exclusion of
+ * swap devices on a per-cgroup basis.
+ *
+ * If no configuration is set, the system-wide swap priorities
+ * assigned at swapon time will apply.
+ *
+ * Author: Youngjun Park <youngjun.park@lge.com>
+ */
+#include <linux/swap.h>
+#include <linux/rcupdate.h>
+#include <linux/memcontrol.h>
+#include <linux/plist.h>
+#include "swap.h"
+#include "swap_cgroup_priority.h"
+#include "memcontrol-v1.h"
+
+static LIST_HEAD(swap_cgroup_priority_list);
+
+/*
+ * struct swap_cgroup_priority
+ *
+ * This structure is RCU protected. Its lifecycle is determined by its
+ * owning memcg or when its 'distance' reaches zero. The 'distance' field
+ * tracks priority differences from global swap. If zero, and its default_prio
+ * follows global swap priority(SWAP_PRIORITY_GLOBAL), the object is destroyed.
+ *
+ * pnode - Array of pointers to swap device priority nodes.
+ * owner - The owning memory cgroup.
+ * rcu - RCU free callback.
+ * link - Global linked list entry.
+ * least_priority - Current lowest priority.
+ * distance - Priority differences from global swap priority.
+ * default_prio - Default priority for this cgroup.
+ * plist - Priority list head.
+ */
+struct swap_cgroup_priority {
+	struct swap_cgroup_priority_pnode *pnode[MAX_SWAPFILES];
+	struct mem_cgroup *owner;
+
+	union {
+		struct rcu_head rcu;
+		struct list_head link;
+	};
+
+	int least_priority;
+	s8 distance;
+	int default_prio;
+	struct plist_head plist[];
+};
+
+/*
+ * struct swap_cgroup_priority_pnode
+ *
+ * This structure represents a priority node for a specific swap device
+ * within a cgroup.
+ *
+ * swap - Pointer to the associated swap device.
+ * id - Unique identifier for the swap device.
+ * prio - Configured priority for this device.
+ * avail_lists - Connections to various priority lists.
+ */
+struct swap_cgroup_priority_pnode {
+	struct swap_info_struct *swap;
+	u64 id;
+	signed short prio;
+	struct plist_node avail_lists[];
+};
+
+/*
+ * Even with a zero distance, a swap device isn't assigned if it doesn't
+ * meet global swap priority conditions; thus, we don't clear it.
+ */
+static bool should_clear_swap_cgroup_priority(
+	struct swap_cgroup_priority *swap_priority)
+{
+	WARN_ON_ONCE(swap_priority->distance < 0 ||
+		swap_priority->distance > MAX_SWAPFILES);
+
+	if (swap_priority->distance == 0 &&
+	    swap_priority->default_prio == SWAP_PRIORITY_GLOBAL)
+		return true;
+
+	return false;
+}
+
+/*
+ * swapdev_id
+ *
+ * A unique identifier for a swap device.
+ *
+ * This ID ensures stable identification for users and crucial synchronization
+ * for swap cgroup priority settings. It provides a reliable reference even if
+ * device paths or numbers change.
+ */
+static atomic64_t swapdev_id_counter;
+
+void get_swapdev_id(struct swap_info_struct *si)
+{
+	si->id = atomic64_inc_return(&swapdev_id_counter);
+}
+
+static struct swap_cgroup_priority *get_swap_cgroup_priority(
+	struct mem_cgroup *memcg)
+{
+	if (!memcg)
+		return NULL;
+
+	return rcu_dereference(memcg->swap_priority);
+}
+
+static struct swap_cgroup_priority_pnode *alloc_swap_cgroup_priority_pnode(
+	gfp_t gfp)
+{
+	struct swap_cgroup_priority_pnode *pnode;
+	pnode = kvzalloc(struct_size(pnode, avail_lists, nr_node_ids),
+			 gfp);
+
+	return pnode;
+}
+
+static void free_swap_cgroup_priority_pnode(
+	struct swap_cgroup_priority_pnode *pnode)
+{
+	if (pnode)
+		kvfree(pnode);
+}
+
+static void free_swap_cgroup_priority(
+	struct swap_cgroup_priority *swap_priority)
+{
+	for (int i = 0; i < MAX_SWAPFILES; i++)
+		free_swap_cgroup_priority_pnode(swap_priority->pnode[i]);
+
+	kvfree(swap_priority);
+}
+
+static struct swap_cgroup_priority *alloc_swap_cgroup_priority(void)
+{
+	struct swap_cgroup_priority *swap_priority;
+
+	swap_priority = kvzalloc(struct_size(swap_priority, plist, nr_node_ids),
+				 GFP_KERNEL);
+	if (!swap_priority)
+		return NULL;
+
+	/*
+	 * Pre-allocates pnode array up to nr_swapfiles at init.
+	 * Individual pnodes are assigned on swapon, but not freed
+	 * on swapoff. This avoids complex ref-counting, simplifying
+	 * the structure for swap cgroup priority management.
+	 */
+	for (int i = 0; i < nr_swapfiles; i++) {
+		swap_priority->pnode[i] = alloc_swap_cgroup_priority_pnode(
+						GFP_KERNEL);
+		if (!swap_priority->pnode[i]) {
+			free_swap_cgroup_priority(swap_priority);
+			return NULL;
+		}
+
+	}
+
+	return swap_priority;
+}
+
+static void rcu_free_swap_cgroup_priority(struct rcu_head *rcu)
+{
+	struct swap_cgroup_priority *swap_priority
+		= container_of(rcu, struct swap_cgroup_priority, rcu);
+
+	free_swap_cgroup_priority(swap_priority);
+}
+
+void show_swap_cgroup_priority(struct seq_file *m)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+	struct swap_cgroup_priority *swap_priority;
+
+	spin_lock(&swap_lock);
+	swap_priority = memcg->swap_priority;
+	if (!swap_priority || swap_priority->owner != memcg) {
+		spin_unlock(&swap_lock);
+		return;
+	}
+
+	if (swap_priority->default_prio != SWAP_PRIORITY_GLOBAL)
+		seq_printf(m,  "default disabled\n");
+
+	for (int i = 0; i < nr_swapfiles; i++) {
+		struct swap_info_struct *si = swap_info[i];
+		struct swap_cgroup_priority_pnode *pnode;
+		signed short prio;
+
+		if (!(si->flags & SWP_USED) || !(si->flags & SWP_WRITEOK))
+			continue;
+
+		pnode = swap_priority->pnode[i];
+
+		if (WARN_ON_ONCE(!pnode))
+			continue;
+
+		prio = pnode->prio;
+		if (prio == si->prio)
+			continue;
+
+		seq_printf(m,  "%lld", si->id);
+		if (prio != SWAP_PRIORITY_DISABLE)
+			seq_printf(m,  " %d\n", prio);
+		else
+			seq_printf(m,  " disabled\n");
+	}
+
+	spin_unlock(&swap_lock);
+}
+
+static void __delete_swap_cgroup_priority(struct mem_cgroup *memcg);
+void purge_swap_cgroup_priority(void)
+{
+	struct swap_cgroup_priority *swap_priority, *tmp;
+
+	spin_lock(&swap_avail_lock);
+	list_for_each_entry_safe(swap_priority, tmp, &swap_cgroup_priority_list,
+				 link) {
+
+		if (should_clear_swap_cgroup_priority(swap_priority))
+			__delete_swap_cgroup_priority(swap_priority->owner);
+	}
+	spin_unlock(&swap_avail_lock);
+}
+
+bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg,
+				swp_entry_t *entry, int order)
+{
+	struct swap_cgroup_priority *swap_priority;
+	struct swap_cgroup_priority_pnode *pnode, *next;
+	struct swap_info_struct *si;
+	unsigned long offset;
+	int node;
+
+	/* TODO
+	 * Per-cpu swapdev cache can't be used directly as cgroup-specific
+	 * priorities may select different devices.
+	 */
+	spin_lock(&swap_avail_lock);
+	node = numa_node_id();
+
+	swap_priority = get_swap_cgroup_priority(memcg);
+swap_priority_check:
+	if (!swap_priority) {
+		spin_unlock(&swap_avail_lock);
+		return false;
+	}
+
+start_over:
+	plist_for_each_entry_safe(pnode, next, &swap_priority->plist[node],
+				  avail_lists[node]) {
+		si = pnode->swap;
+		plist_requeue(&pnode->avail_lists[node],
+			&swap_priority->plist[node]);
+		spin_unlock(&swap_avail_lock);
+		if (get_swap_device_info(si)) {
+			offset = cluster_alloc_swap_entry(si, order,
+							  SWAP_HAS_CACHE);
+			put_swap_device(si);
+			if (offset) {
+				*entry = swp_entry(si->type, offset);
+				return true;
+			}
+
+			if (order)
+				return false;
+		}
+
+		spin_lock(&swap_avail_lock);
+		/*
+		 * If 'swap_cgroup_priority' changes while we're holding a lock,
+		 * we must verify its state to ensure memory validness.
+		 */
+		if (memcg->swap_priority != swap_priority)
+			goto swap_priority_check;
+
+		if (plist_node_empty(&next->avail_lists[node]))
+			goto start_over;
+	}
+	spin_unlock(&swap_avail_lock);
+
+	return false;
+}
+
+/* add_to_avail_list (swapon / swapusage > 0) */
+void activate_swap_cgroup_priority(struct swap_info_struct *swp,
+				   bool swapon)
+{
+	struct swap_cgroup_priority *swap_priority;
+	int i;
+
+	list_for_each_entry(swap_priority, &swap_cgroup_priority_list, link) {
+		struct swap_cgroup_priority_pnode *pnode =
+			swap_priority->pnode[swp->type];
+
+		if (WARN_ON_ONCE(!pnode))
+			continue;
+
+		/* Exclude reinsert */
+		if (swapon && pnode->id != swp->id) {
+			pnode->swap = swp;
+			if (swap_priority->default_prio == SWAP_PRIORITY_GLOBAL) {
+				if (swp->prio >= 0)
+					pnode->prio = swp->prio;
+				else
+					pnode->prio =
+						--swap_priority->least_priority;
+			} else {
+				pnode->prio = SWAP_PRIORITY_DISABLE;
+				swap_priority->distance++;
+			}
+		}
+
+		/* NUMA priority handling */
+		for_each_node(i) {
+			if (swapon) {
+				if (pnode->prio < 0 && swap_node(swp) == i) {
+					plist_node_init(
+						&pnode->avail_lists[i],
+						1);
+				} else {
+					plist_node_init(
+						&pnode->avail_lists[i],
+						-pnode->prio);
+				}
+			}
+
+			if (pnode->prio != SWAP_PRIORITY_DISABLE)
+				plist_add(&pnode->avail_lists[i],
+					  &swap_priority->plist[i]);
+		}
+	}
+}
+
+/* del_from_avail_list (swapoff / swap usage <= 0) */
+void deactivate_swap_cgroup_priority(struct swap_info_struct *swp,
+				     bool swapoff)
+{
+	struct swap_cgroup_priority *swap_priority, *tmp;
+	int nid, i;
+
+	list_for_each_entry_safe(swap_priority, tmp, &swap_cgroup_priority_list,
+				 link) {
+		struct swap_cgroup_priority_pnode *pnode =
+			swap_priority->pnode[swp->type];
+
+		if (WARN_ON_ONCE(!pnode))
+			continue;
+
+		if (swapoff) {
+			if (pnode->prio != swp->prio)
+				swap_priority->distance--;
+		}
+
+		if (pnode->prio == SWAP_PRIORITY_DISABLE)
+			continue;
+
+		if (swapoff && pnode->prio < 0) {
+			struct swap_cgroup_priority_pnode *tmp;
+			/*
+			 * NUMA priority handling
+			 * mimic swapoff prio adjustment without plist
+			 */
+			for (int i = 0; i < nr_swapfiles; i++) {
+				tmp = swap_priority->pnode[i];
+				if (!tmp || tmp->prio > pnode->prio ||
+				    tmp->swap == swp)
+					continue;
+				tmp->prio++;
+				for_each_node(nid) {
+					if (tmp->avail_lists[nid].prio != 1)
+						tmp->avail_lists[nid].prio--;
+				}
+			}
+
+			swap_priority->least_priority++;
+		}
+
+		for_each_node(i)
+			plist_del(&pnode->avail_lists[i],
+				&swap_priority->plist[i]);
+	}
+}
+
+static void apply_swap_cgroup_priority_pnode(
+	struct swap_cgroup_priority *swap_priority,
+	struct swap_cgroup_priority_pnode *pnode,
+	int prio,
+	bool clear)
+{
+	int nid;
+
+	if (clear && pnode->prio != SWAP_PRIORITY_DISABLE) {
+		for_each_node(nid) {
+			plist_del(&pnode->avail_lists[nid],
+				&swap_priority->plist[nid]);
+		}
+	}
+
+	if (pnode->swap->prio != prio && pnode->swap->prio == pnode->prio)
+		swap_priority->distance++;
+	else if (pnode->swap->prio == prio && pnode->swap->prio != pnode->prio)
+		swap_priority->distance--;
+
+	pnode->prio = prio;
+	for_each_node(nid) {
+		if (pnode->prio >= 0) {
+			plist_node_init(&pnode->avail_lists[nid],
+				-pnode->prio);
+		} else {
+			if (swap_node(pnode->swap) == nid)
+				plist_node_init(
+					&pnode->avail_lists[nid],
+					1);
+			else
+				plist_node_init(
+					&pnode->avail_lists[nid],
+					-pnode->prio);
+		}
+
+		/*
+		 * Check SWP_WRITEOK for skipping
+		 * 1. reinsert case when swapoff fails
+		 * 2. on-going swapon before adding avail list
+		 */
+		if (pnode->prio != SWAP_PRIORITY_DISABLE &&
+		    (pnode->swap->flags & SWP_WRITEOK))
+			plist_add(&pnode->avail_lists[nid],
+				&swap_priority->plist[nid]);
+	}
+}
+
+static int __apply_swap_cgroup_priority(
+	struct swap_cgroup_priority *swap_priority, u64 id, int prio, bool new)
+{
+	struct swap_cgroup_priority_pnode *pnode;
+	struct swap_info_struct *si;
+	int old_prio;
+	int type;
+
+	if (new)
+		swap_priority->least_priority = least_priority;
+
+	if (id == DEFAULT_ID) {
+		swap_priority->default_prio = prio;
+		if (new)
+			goto assign_prio;
+
+		goto out;
+	}
+
+	for (type = 0; type < nr_swapfiles; type++) {
+		si = swap_info[type];
+		if (id == si->id)
+			break;
+		si = NULL;
+	}
+
+	if (!si)
+		return -EIO;
+
+	if (!(si->flags & SWP_USED) || !(si->flags & SWP_WRITEOK))
+		return -EFAULT;
+
+	if (si->id != id)
+		return -EINVAL;
+
+	if (prio == SWAP_PRIORITY_GLOBAL)
+		prio = si->prio;
+
+	pnode = swap_priority->pnode[type];
+	/* Assigning the same priority has no effect. */
+	if (!new && pnode && pnode->prio == prio)
+		return 0;
+	else if (new && si->prio == prio)
+		return 0;
+
+	if (new) {
+		pnode->id = id;
+		pnode->swap = si;
+		pnode->prio = si->prio;
+	}
+	old_prio = pnode->prio;
+
+	/*
+	 * When a new negative priority is added, least_priority decreases.
+	 * When a negative priority is deleted, least_priority increases.
+	 */
+	if (prio < SWAP_PRIORITY_DISABLE && old_prio >= SWAP_PRIORITY_DISABLE)
+		swap_priority->least_priority--;
+	else if (prio >= SWAP_PRIORITY_DISABLE &&
+		 old_prio < SWAP_PRIORITY_DISABLE)
+		swap_priority->least_priority++;
+
+	if (prio < swap_priority->least_priority)
+		prio = swap_priority->least_priority;
+
+	apply_swap_cgroup_priority_pnode(swap_priority, pnode, prio, !new);
+
+	/*
+	 * This logic adjusts priorities according to global swap on/off rule.
+	 * Priorities at or above SWAP_PRIORITY_DISABLE don't affect other swap
+	 * device priorities. However, negative priorities below this threshold
+	 * influence each other based on their values. Adjustments are made if a
+	 * swap device's priority becomes negative and starts influencing others,
+	 * or if it moves out of the negative range and stops influencing them.
+	 */
+assign_prio:
+	for (int i = 0; i < nr_swapfiles; i++) {
+		int changed_prio;
+		si = swap_info[i];
+		/*
+		 * nr_swapfiles may have increased after initial alloc
+		 * due to missing swap_lock
+		 */
+		if (!(pnode = swap_priority->pnode[si->type])) {
+			pnode = alloc_swap_cgroup_priority_pnode(GFP_ATOMIC);
+			if (!pnode)
+				return -ENOMEM;
+			swap_priority->pnode[si->type] = pnode;
+		}
+
+		/*
+		 * Does not check SWP_WRITEOK. device could be reinserted.
+		 * Ensure si->map is valid before proceeding.
+		 * This prevents missing swapon failures where SWP_USED
+		 * state persists unexpectedly.
+		 */
+		if (!(si->flags & SWP_USED) || !si->swap_map)
+			continue;
+
+		if (si->id == id)
+			continue;
+
+		if (si->id != pnode->id) {
+			pnode->id = si->id;
+			pnode->prio = si->prio;
+			pnode->swap = si;
+		}
+
+		changed_prio = pnode->prio;
+
+		/*
+		 * A new negative value is added,
+		 * so all values lower than it are shifted backward by one.
+		 */
+		if (old_prio >= SWAP_PRIORITY_DISABLE &&
+		    prio < SWAP_PRIORITY_DISABLE &&
+		    (pnode->prio < SWAP_PRIORITY_DISABLE &&
+		    pnode->prio <= prio)) {
+			changed_prio--;
+		/*
+		 * One negative value is removed,
+		 * so all higher values are shifted forward by one.
+		 */
+		} else if (old_prio < SWAP_PRIORITY_DISABLE &&
+			   prio >= SWAP_PRIORITY_DISABLE &&
+			   (pnode->prio < SWAP_PRIORITY_DISABLE &&
+			   pnode->prio <= old_prio)) {
+			changed_prio++;
+		} else if (old_prio < SWAP_PRIORITY_DISABLE &&
+			   prio < SWAP_PRIORITY_DISABLE) {
+			/*
+			 * If it was negative already but becomes smaller,
+			 * shift all values in range backward by one.
+			 */
+			if (old_prio > prio &&
+			    (prio <= pnode->prio && old_prio >= pnode->prio)) {
+				changed_prio++;
+			/*
+			 * If it was negative already but becomes larger,
+			 * shift all values in range forward by one.
+			 */
+			} else if (old_prio < prio &&
+				   (prio >= pnode->prio &&
+				   old_prio <= pnode->prio)) {
+				changed_prio--;
+			}
+		}
+
+		if (!new && changed_prio == pnode->prio)
+			continue;
+
+		apply_swap_cgroup_priority_pnode(
+			swap_priority, pnode, changed_prio, !new);
+	}
+
+out:
+	if (should_clear_swap_cgroup_priority(swap_priority))
+		return 1;
+
+	return 0;
+}
+
+int prepare_swap_cgroup_priority(int type)
+{
+	struct swap_cgroup_priority *swap_priority;
+	int err = 0;
+
+	spin_lock(&swap_avail_lock);
+	list_for_each_entry_rcu(swap_priority,
+				&swap_cgroup_priority_list, link) {
+		if (!swap_priority->pnode[type]) {
+			swap_priority->pnode[type] =
+				alloc_swap_cgroup_priority_pnode(GFP_ATOMIC);
+
+			if (!swap_priority->pnode[type]) {
+				err = -ENOMEM;
+				break;
+			}
+		}
+
+	}
+	spin_unlock(&swap_avail_lock);
+
+	return err;
+}
+
+int apply_swap_cgroup_priority(struct mem_cgroup *memcg, u64 id, int prio)
+{
+	struct swap_cgroup_priority *swap_priority;
+	int nid;
+	bool new = false;
+	int err = 0;
+
+	rcu_read_lock();
+	swap_priority = rcu_dereference(memcg->swap_priority);
+	if (swap_priority && swap_priority->owner == memcg) {
+		rcu_read_unlock();
+		goto prio_set;
+	}
+	rcu_read_unlock();
+	new = true;
+
+	/* No need to define "global swap priority" for a new cgroup. */
+	if (new && prio == SWAP_PRIORITY_GLOBAL)
+		return 0;
+
+	swap_priority = alloc_swap_cgroup_priority();
+	if (!swap_priority)
+		return -ENOMEM;
+
+	/* Just initialize. may changed on __apply_swap_cgroup_priority */
+	swap_priority->default_prio = SWAP_PRIORITY_GLOBAL;
+	INIT_LIST_HEAD(&swap_priority->link);
+	for_each_node(nid)
+		plist_head_init(&swap_priority->plist[nid]);
+
+prio_set:
+	spin_lock(&swap_lock);
+	spin_lock(&swap_avail_lock);
+
+	/* Simultaneous calls to the same interface.*/
+	if (new && memcg->swap_priority &&
+	    memcg->swap_priority->owner == memcg) {
+		new = false;
+		free_swap_cgroup_priority(swap_priority);
+		swap_priority = memcg->swap_priority;
+	}
+
+	err = __apply_swap_cgroup_priority(swap_priority, id, prio, new);
+	if (err) {
+		/*
+		 * The difference with the global swap priority is now zero.
+		 * Remove the swap priority.
+		 */
+		if (err == 1) {
+			err = 0;
+			__delete_swap_cgroup_priority(memcg);
+		}
+
+		goto error_locked;
+	}
+
+	if (new) {
+		swap_priority->owner = memcg;
+		list_add_rcu(&swap_priority->link, &swap_cgroup_priority_list);
+		memcg->swap_priority = swap_priority;
+
+		for (int i = 0; i < nr_swapfiles; i++) {
+			if (!swap_priority->pnode[i]->swap) {
+				free_swap_cgroup_priority_pnode(
+					swap_priority->pnode[i]);
+				swap_priority->pnode[i] = NULL;
+			}
+		}
+	}
+
+	spin_unlock(&swap_avail_lock);
+	spin_unlock(&swap_lock);
+
+	return 0;
+
+error_locked:
+	spin_unlock(&swap_avail_lock);
+	spin_unlock(&swap_lock);
+
+	if (!new)
+		return err;
+
+	free_swap_cgroup_priority(swap_priority);
+	return err;
+}
+
+static void __delete_swap_cgroup_priority(struct mem_cgroup *memcg)
+{
+	struct swap_cgroup_priority *swap_priority = memcg->swap_priority;
+
+	lockdep_assert_held(&swap_avail_lock);
+
+	if (!swap_priority)
+		return;
+
+	/* If using a cached swap_priority, there is no need to remove it. */
+	if (swap_priority->owner != memcg)
+		return;
+
+	rcu_assign_pointer(memcg->swap_priority, NULL);
+	list_del_rcu(&swap_priority->link);
+	call_rcu(&swap_priority->rcu, rcu_free_swap_cgroup_priority);
+}
+
+void delete_swap_cgroup_priority(struct mem_cgroup *memcg)
+{
+	spin_lock(&swap_avail_lock);
+	__delete_swap_cgroup_priority(memcg);
+	spin_unlock(&swap_avail_lock);
+}
diff --git a/mm/swap_cgroup_priority.h b/mm/swap_cgroup_priority.h
new file mode 100644
index 000000000000..253e95623270
--- /dev/null
+++ b/mm/swap_cgroup_priority.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SWAP_CGROUP_PRIORITY_H
+#define _SWAP_CGROUP_PRIORITY_H
+#include <linux/swap.h>
+
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+#include <linux/limits.h>
+/*
+ * A priority of -1 is not assigned to global swap entries,
+ * based on the kernel's specific negative priority assignment rules.
+ */
+#define SWAP_PRIORITY_DISABLE	-1
+/*
+ * (SHRT_MAX + 1) exceeds the maximum 'prio' value for signed short.
+ * This marks it as an invalid or special priority state, not for standard use.
+ */
+#define SWAP_PRIORITY_GLOBAL	SHRT_MAX+1
+/*
+ * ID 0 is reserved/unused in kernel swap management, allowing its use
+ * for special internal states or flags, as swap IDs typically start from 1.
+ */
+#define DEFAULT_ID		0
+
+/* linux/mm/swapfile.c */
+extern spinlock_t swap_lock;
+extern int least_priority;
+extern unsigned int nr_swapfiles;
+extern spinlock_t swap_avail_lock;
+extern struct swap_info_struct *swap_info[MAX_SWAPFILES];
+int swap_node(struct swap_info_struct *si);
+unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int order,
+				       unsigned char usage);
+bool get_swap_device_info(struct swap_info_struct *si);
+
+/* linux/mm/swap_cgroup_priority.c */
+int apply_swap_cgroup_priority(struct mem_cgroup *memcg, u64 id, int prio);
+void activate_swap_cgroup_priority(struct swap_info_struct *swp, bool swapon);
+void deactivate_swap_cgroup_priority(struct swap_info_struct *swp,
+				     bool swapoff);
+int prepare_swap_cgroup_priority(int type);
+void show_swap_cgroup_priority(struct seq_file *m);
+void get_swapdev_id(struct swap_info_struct *si);
+void purge_swap_cgroup_priority(void);
+bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg, swp_entry_t *entry,
+				int order);
+void delete_swap_cgroup_priority(struct mem_cgroup *memcg);
+#else
+int swap_node(struct swap_info_struct *si);
+unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int order,
+				       unsigned char usage);
+bool get_swap_device_info(struct swap_info_struct *si);
+
+static inline int apply_swap_cgroup_priority(struct mem_cgroup *memcg, int id,
+					     int prio)
+{
+	return 0;
+}
+static inline void activate_swap_cgroup_priority(struct swap_info_struct *swp,
+						 bool swapon)
+{
+}
+static inline void deactivate_swap_cgroup_priority(struct swap_info_struct *swp, 
+						   bool swapoff)
+{
+}
+static inline int prepare_swap_cgroup_priority(int type)
+{
+	return 0;
+}
+
+static inline void get_swapdev_id(struct swap_info_struct *si)
+{
+}
+static inline void purge_swap_cgroup_priority(void)
+{
+}
+static inline bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg,
+					      swp_entry_t *entry, int order)
+{
+	return false;
+}
+static inline void delete_swap_cgroup_priority(struct mem_cgroup *memcg)
+{
+}
+#endif
+#endif
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 68ce283e84be..4b56f117b2b0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -48,6 +48,7 @@
 #include <linux/swap_cgroup.h>
 #include "internal.h"
 #include "swap.h"
+#include "swap_cgroup_priority.h"
 
 static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 				 unsigned char);
@@ -62,8 +63,8 @@ static struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
 					      unsigned long offset);
 static inline void unlock_cluster(struct swap_cluster_info *ci);
 
-static DEFINE_SPINLOCK(swap_lock);
-static unsigned int nr_swapfiles;
+DEFINE_SPINLOCK(swap_lock);
+unsigned int nr_swapfiles;
 atomic_long_t nr_swap_pages;
 /*
  * Some modules use swappable objects and may try to swap them out under
@@ -73,7 +74,7 @@ atomic_long_t nr_swap_pages;
 EXPORT_SYMBOL_GPL(nr_swap_pages);
 /* protected with swap_lock. reading in vm_swap_full() doesn't need lock */
 long total_swap_pages;
-static int least_priority = -1;
+int least_priority = -1;
 unsigned long swapfile_maximum_size;
 #ifdef CONFIG_MIGRATION
 bool swap_migration_ad_supported;
@@ -103,9 +104,9 @@ static PLIST_HEAD(swap_active_head);
  * before any swap_info_struct->lock.
  */
 static struct plist_head *swap_avail_heads;
-static DEFINE_SPINLOCK(swap_avail_lock);
+DEFINE_SPINLOCK(swap_avail_lock);
 
-static struct swap_info_struct *swap_info[MAX_SWAPFILES];
+struct swap_info_struct *swap_info[MAX_SWAPFILES];
 
 static DEFINE_MUTEX(swapon_mutex);
 
@@ -878,7 +879,7 @@ static void swap_reclaim_work(struct work_struct *work)
  * Try to allocate swap entries with specified order and try set a new
  * cluster for current CPU too.
  */
-static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int order,
+unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int order,
 					      unsigned char usage)
 {
 	struct swap_cluster_info *ci;
@@ -1156,7 +1157,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	swap_usage_sub(si, nr_entries);
 }
 
-static bool get_swap_device_info(struct swap_info_struct *si)
+bool get_swap_device_info(struct swap_info_struct *si)
 {
 	if (!percpu_ref_tryget_live(&si->users))
 		return false;
@@ -2536,7 +2537,7 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 	return generic_swapfile_activate(sis, swap_file, span);
 }
 
-static int swap_node(struct swap_info_struct *si)
+int swap_node(struct swap_info_struct *si)
 {
 	struct block_device *bdev;
 
-- 
2.34.1


