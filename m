Return-Path: <cgroups+bounces-11689-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3486C43E13
	for <lists+cgroups@lfdr.de>; Sun, 09 Nov 2025 13:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FBD3ADDB4
	for <lists+cgroups@lfdr.de>; Sun,  9 Nov 2025 12:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E262F12A3;
	Sun,  9 Nov 2025 12:50:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ED12ED869
	for <cgroups@vger.kernel.org>; Sun,  9 Nov 2025 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692604; cv=none; b=F0st7Igy7Ib4yDIJWY30oWY8oW8oJ+xNheFPdpIEX90glPSMt1vGst8dHICx1U0bjhKAyQKdonqbhJt9D7gwEgAkAtJIRUUv2TxBkCNUVvxTJ9JHbiRdwkJC2y2OeodWctyIMveQSiWcY5kuY82IdlLzp2cIY25lBtLatnSwBBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692604; c=relaxed/simple;
	bh=6llPHYJoDM/PfnNVkwHcdAjSkPIO2FXvUEhsIQpmGKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vq8GImADO4qv5lW4kx2YIm9yHE7jvpe0TReibpEnTenmx+8hh9Fbn2rivJbYcgSX5rd1Hq4rt/P1cGYNItRuPNolP+6wFFixlK4pjADiLXQnJksOFL24HcxU3DoQ8+coddFm1AHuivLAEs+pkTjFZgLOhkGUNdGQBZ/Dn5XsFSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 9 Nov 2025 21:49:53 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	youngjun.park@lge.com,
	gunho.lee@lge.com,
	taejoon.song@lge.com
Subject: [PATCH 2/3] mm: swap: introduce swap tier infrastructure
Date: Sun,  9 Nov 2025 21:49:46 +0900
Message-Id: <20251109124947.1101520-3-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251109124947.1101520-1-youngjun.park@lge.com>
References: <20251109124947.1101520-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Swap tier groups swap devices by priority ranges.
This allows different memory groups to use different swap devices.

Swap tiers are identified by names and configured with priority ranges.
Two special tiers are built-in: default (no name) tier and "zswap" tier.

Interface:
* /sys/kernel/mm/swap/tiers
- Write:
- Add format: "+ tierName:prio,tierName2:prio..."
- Example: echo "+ SSD:100,HDD:-1" > /sys/kernel/mm/swap/tiers
- Remove format: "- tierName,tierName2..."
- Example: echo "- SSD,HDD" > /sys/kernel/mm/swap/tiers
- Priority ranges merge when no cgroup references exist
- Minimum priority becomes -1 when tiers are configured above -1
- Read:
- Format: "Name             Idx   PrioStart   PrioEnd"
- Shows configured tiers with their priority ranges

* /sys/fs/cgroup/*/memory.swap.tiers
- Read: Shows written operations and final merged result
- Write: Format "(+/-)tierName (+/-)tierName2..."
- Example: echo "+ +SSD -HDD" > memory.swap.tier
- Override semantics (echo "" clears all settings)
- + enables tier, - disables tier
- No prefix inherits parent settings
- +/- alone affects all tiers (+ enables all, - disables all)
- Root cgroup defaults to "+" (all swap devices enabled)

Special tiers:
- "" (default): for inheritance
- "zswap": for zswap integration

Suggested-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  32 ++
 MAINTAINERS                             |   2 +
 include/linux/memcontrol.h              |   4 +
 include/linux/swap.h                    |   3 +
 mm/Kconfig                              |  13 +
 mm/Makefile                             |   1 +
 mm/swap.h                               |   4 +
 mm/swap_tier.c                          | 602 ++++++++++++++++++++++++
 mm/swap_tier.h                          |  75 +++
 mm/swapfile.c                           |   5 +-
 10 files changed, 738 insertions(+), 3 deletions(-)
 create mode 100644 mm/swap_tier.c
 create mode 100644 mm/swap_tier.h

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3345961c30ac..ed8ef33b4d6a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1850,6 +1850,38 @@ The following nested keys are defined.
 	Swap usage hard limit.  If a cgroup's swap usage reaches this
 	limit, anonymous memory of the cgroup will not be swapped out.
 
+  memory.swap.tiers
+        A read-write nested-keyed file which exists on non-root
+        cgroups. The default is empty (inherits from parent).
+
+        This interface allows selecting which swap tiers a cgroup can
+        use for swapping out memory.
+
+        When read, the file shows two lines:
+          - The first line shows the operation string that was
+            written to this file.
+          - The second line shows the effective operation after
+            merging with parent settings.
+
+        When writing, the format is:
+          (+/-)(TIER_NAME) (+/-)(TIER_NAME) ...
+
+        Valid tier names are those configured in
+        /sys/kernel/mm/swap/tiers.
+
+        Each tier can be prefixed with:
+          +    Enable this tier (always on)
+          -     Disable this tier (always off)
+          none  Inherit from parent (incremental merge)
+
+        Special default tier operations (+ or - without tier name):
+          +    Ignore parent settings, enable all swap tiers, then
+                apply subsequent operations
+          -     Ignore parent settings, disable all swap tiers, then
+                apply subsequent operations
+          none  Inherit all tier settings from parent, then apply
+                subsequent operations incrementally
+
   memory.swap.events
 	A read-only flat-keyed file which exists on non-root cgroups.
 	The following entries are defined.  Unless specified
diff --git a/MAINTAINERS b/MAINTAINERS
index fa519cbc4b88..3416d466d011 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16517,6 +16517,8 @@ F:	mm/swap.c
 F:	mm/swap.h
 F:	mm/swap_table.h
 F:	mm/swap_state.c
+F:	mm/swap_tier.c
+F	mm/swap_tier.h
 F:	mm/swapfile.c
 
 MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE)
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 966f7c1a0128..1224029620ed 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -283,6 +283,10 @@ struct mem_cgroup {
 	/* per-memcg mm_struct list */
 	struct lru_gen_mm_list mm_list;
 #endif
+#ifdef CONFIG_SWAP_TIER
+	int tiers_onoff;
+	int tiers_mask;
+#endif
 
 #ifdef CONFIG_MEMCG_V1
 	/* Legacy consumer-oriented counters */
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 90fa27bb7796..8911eff9d37a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -271,6 +271,9 @@ struct swap_info_struct {
 	struct percpu_ref users;	/* indicate and keep swap device valid. */
 	unsigned long	flags;		/* SWP_USED etc: see above */
 	signed short	prio;		/* swap priority of this type */
+#ifdef CONFIG_SWAP_TIER
+	int tier_idx;
+#endif
 	struct plist_node list;		/* entry in swap_active_head */
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* extent of the swap_map */
diff --git a/mm/Kconfig b/mm/Kconfig
index e1fb11f36ede..78173ffe65d6 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -163,6 +163,19 @@ endmenu
 
 endif
 
+config SWAP_TIER
+	default n
+	bool "Swap tier"
+	depends on SWAP && MEMCG && SYSFS
+	help
+          Swap tier is a concept proposed to group swap devices by
+          priority ranges, allowing cgroups to select and use a desired
+          swap_tier. This enables more flexible control over swap usage
+          across different workloads.
+          It is possible to assign a name for identifying a swap tier,
+          and to configure the priority range used for selecting swap
+          devices within that tier.
+
 menu "Slab allocator options"
 
 config SLUB
diff --git a/mm/Makefile b/mm/Makefile
index 00ceb2418b64..9e98799f2edf 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -76,6 +76,7 @@ ifdef CONFIG_MMU
 endif
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_SWAP_TIER)	+= swap_tier.o
 obj-$(CONFIG_ZSWAP)	+= zswap.o
 obj-$(CONFIG_HAS_DMA)	+= dmapool.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o hugetlb_sysfs.o hugetlb_sysctl.o
diff --git a/mm/swap.h b/mm/swap.h
index d034c13d8dd2..b116282690c8 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -16,6 +16,10 @@ extern int page_cluster;
 #define swap_entry_order(order)	0
 #endif
 
+#define DEF_SWAP_PRIO  -1
+
+extern spinlock_t swap_lock;
+extern struct plist_head swap_active_head;
 extern struct swap_info_struct *swap_info[];
 
 /*
diff --git a/mm/swap_tier.c b/mm/swap_tier.c
new file mode 100644
index 000000000000..4301e3c766b9
--- /dev/null
+++ b/mm/swap_tier.c
@@ -0,0 +1,602 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/swap.h>
+#include <linux/rcupdate.h>
+#include <linux/memcontrol.h>
+#include <linux/plist.h>
+#include <linux/sysfs.h>
+#include <linux/sort.h>
+
+#include "swap_tier.h"
+
+/*
+ * struct swap_tier - Structure representing a swap tier.
+ *
+ * @name:		Name of the swap_tier.
+ * @prio_st:		Starting value of priority.
+ * @prio_end:		Ending value of priority.
+ * @list:		Linked list of active tiers.
+ * @inactive_list:	Linked list of inactive tiers.
+ * @kref:		Reference count (held by swap device and memory cgroup).
+ */
+static struct swap_tier {
+	char name[MAX_TIERNAME];
+	short prio_st;
+	short prio_end;
+	union {
+		struct plist_node list;
+		struct list_head inactive_list;
+	};
+	struct kref ref;
+} swap_tiers[MAX_SWAPTIER];
+
+static DEFINE_SPINLOCK(swap_tier_lock);
+
+/* Active swap priority list, reserved tier first, sorted in descending order */
+static PLIST_HEAD(swap_tier_active_list);
+/* Unused swap_tier object */
+static LIST_HEAD(swap_tier_inactive_list);
+
+#define TIER_IDX(tier)	((tier) - swap_tiers)
+
+#define for_each_active_tier(tier) \
+	plist_for_each_entry(tier, &swap_tier_active_list, list)
+
+#define for_each_tier(tier, idx) \
+	for (idx = 0, tier = &swap_tiers[0]; idx < MAX_SWAPTIER; \
+		idx++, tier = &swap_tiers[idx])
+
+static int nr_swaptiers = SWAP_TIER_RESERVED_CNT;
+
+#define SKIP_REPLACE_IDX	-1
+#define NULL_TIER               -1
+
+/*
+ * Naming Convention:
+ *   swap_tiers_*() - Public/exported functions
+ *   swap_tier_*()  - Private/internal functions
+ */
+
+static bool swap_tier_replace_marked(int idx)
+{
+	return idx != SKIP_REPLACE_IDX;
+}
+
+static bool swap_tier_is_active(void)
+{
+	return nr_swaptiers > SWAP_TIER_RESERVED_CNT;
+}
+
+static bool swap_tier_prio_in_range(struct swap_tier *tier, short prio)
+{
+	if (tier->prio_st <= prio && tier->prio_end >= prio)
+		return true;
+
+	return false;
+}
+
+/* swap_tiers initialization */
+void swap_tiers_init(void)
+{
+	struct swap_tier *tier;
+	int idx;
+
+	BUILD_BUG_ON(BITS_PER_TYPE(int) < MAX_SWAPTIER * 2);
+
+	for_each_tier(tier, idx) {
+		if (idx < SWAP_TIER_RESERVED_CNT) {
+			/* for display fisrt */
+			plist_node_init(&tier->list, -SHRT_MAX);
+			plist_add(&tier->list, &swap_tier_active_list);
+			kref_init(&tier->ref);
+		} else {
+			INIT_LIST_HEAD(&tier->inactive_list);
+			list_add_tail(&tier->inactive_list, &swap_tier_inactive_list);
+		}
+	}
+
+	strscpy(swap_tiers[SWAP_TIER_DEFAULT].name, DEFAULT_TIER_NAME);
+#ifdef CONFIG_ZSWAP
+	strscpy(swap_tiers[SWAP_TIER_ZSWAP].name, ZSWAP_TIER_NAME);
+#endif
+}
+
+static bool swap_tier_alive(struct swap_tier *tier)
+{
+	lockdep_assert_held(&swap_tier_lock);
+	return (kref_read(&tier->ref) > 1) ? true : false;
+}
+
+static void swap_tier_get(struct swap_tier *tier)
+{
+	lockdep_assert_held(&swap_tier_lock);
+	kref_get(&tier->ref);
+}
+
+static void swap_tier_remove(struct swap_tier *tier);
+static void swap_tier_release(struct kref *ref)
+{
+	struct swap_tier *tier = container_of(ref, struct swap_tier, ref);
+
+	swap_tier_remove(tier);
+}
+
+static void swap_tier_put(struct swap_tier *tier)
+{
+	lockdep_assert_held(&swap_tier_lock);
+	kref_put(&tier->ref, swap_tier_release);
+}
+
+static int swap_tier_cmp(const void *p, const void *p2)
+{
+	const struct tiers_desc *tp = p;
+	const struct tiers_desc *tp2 = p2;
+
+	return tp2->prio_st - tp->prio_st;
+}
+
+static void swap_tier_get_mask(int mask)
+{
+	struct swap_tier *tier;
+
+	lockdep_assert_held(&swap_tier_lock);
+
+	for_each_active_tier(tier) {
+		int tier_mask = TIER_MASK(TIER_IDX(tier), TIER_FULL_MASK);
+
+		if (mask & tier_mask)
+			swap_tier_get(tier);
+	}
+}
+
+static void swap_tier_put_mask(int mask)
+{
+	struct swap_tier *tier;
+
+	lockdep_assert_held(&swap_tier_lock);
+
+	for_each_active_tier(tier) {
+		int tier_mask = TIER_MASK(TIER_IDX(tier), TIER_FULL_MASK);
+
+		if (mask & tier_mask)
+			swap_tier_put(tier);
+	}
+}
+
+static bool swap_tier_is_default(struct swap_tier *tier)
+{
+	int idx = TIER_IDX(tier);
+
+	return idx < SWAP_TIER_RESERVED_CNT ? true : false;
+}
+
+/*
+ * Check if tier priority range can be split. If input falls within a
+ * referenced range, splitting is not allowed and an error is returned.
+ * If priority start is the same but tier has no reference, mark
+ * SKIP_REPLACE_IDX to allow replacement at apply time.
+ */
+static int swap_tier_can_split_range(struct tiers_desc *desc)
+{
+	struct swap_tier *tier;
+	int ret = 0;
+
+	lockdep_assert_held(&swap_tier_lock);
+	desc->tier_idx = SKIP_REPLACE_IDX;
+
+	for_each_active_tier(tier) {
+		if (swap_tier_is_default(tier))
+			continue;
+
+		if (tier->prio_st > desc->prio_st)
+			continue;
+
+		/* If start priorities match, replace tier name */
+		if (tier->prio_st == desc->prio_st)
+			desc->tier_idx = TIER_IDX(tier);
+
+		if (swap_tier_alive(tier))
+			ret = -EBUSY;
+
+		break;
+	}
+
+	return ret;
+}
+
+static void swap_tier_prepare(struct tiers_desc *desc)
+{
+	struct swap_tier *tier;
+
+	lockdep_assert_held(&swap_tier_lock);
+
+	if (WARN_ON(list_empty(&swap_tier_inactive_list)))
+		return;
+
+	if (swap_tier_replace_marked(desc->tier_idx))
+		return;
+
+	tier = list_first_entry(&swap_tier_inactive_list,
+		struct swap_tier, inactive_list);
+
+	list_del(&tier->inactive_list);
+	strscpy(tier->name, desc->name, MAX_TIERNAME);
+	tier->prio_st = desc->prio_st;
+	plist_node_init(&tier->list, -tier->prio_st);
+	kref_init(&tier->ref);
+
+	plist_add(&tier->list, &swap_tier_active_list);
+	nr_swaptiers++;
+}
+
+static void swap_tier_apply(struct tiers_desc *desc, int nr)
+{
+	struct plist_node *pnode;
+	struct swap_info_struct *p = NULL;
+	struct swap_tier *tier;
+	int prio_end = SHRT_MAX;
+
+	lockdep_assert_held(&swap_lock);
+	lockdep_assert_held(&swap_tier_lock);
+
+	for (int i = 0; i < nr; i++) {
+		int idx = desc[i].tier_idx;
+
+		if (swap_tier_replace_marked(idx))
+			strscpy(swap_tiers[idx].name, desc[i].name, MAX_TIERNAME);
+	}
+
+	for_each_active_tier(tier) {
+		if (swap_tier_is_default(tier))
+			continue;
+
+		tier->prio_end = prio_end;
+		prio_end = tier->prio_st - 1;
+	}
+
+	/* TODO: use swapfiles ?*/
+	if (plist_head_empty(&swap_active_head))
+		return;
+
+	for_each_active_tier(tier) {
+		plist_for_each_continue(pnode, &swap_active_head) {
+			p = container_of(pnode, struct swap_info_struct, list);
+			if (p->tier_idx != NULL_TIER)
+				continue;
+			if (!swap_tier_prio_in_range(tier, p->prio))
+				break;
+			swap_tier_get(tier);
+		}
+	}
+}
+
+int swap_tiers_add(struct tiers_desc desc[], int nr)
+{
+	struct swap_tier *tier;
+	int ret = 0;
+
+	if (nr <= 0)
+		return -EINVAL;
+
+	sort(desc, nr, sizeof(desc[0]), swap_tier_cmp, NULL);
+
+	for (int i = 0; i < nr; i++) {
+		if (i > 0 && desc[i].prio_st == desc[i-1].prio_st)
+			return -EINVAL;
+
+		for (int j = i+1; j < nr; j++) {
+			if (!strcmp(desc[i].name, desc[j].name))
+				return -EINVAL;
+		}
+
+		for_each_active_tier(tier) {
+			if (!strcmp(desc[i].name, tier->name))
+				return -EALREADY;
+		}
+	}
+
+	spin_lock(&swap_lock);
+	spin_lock(&swap_tier_lock);
+
+	/* Tier set must cover all priorities */
+	if (!swap_tier_is_active() && desc[nr-1].prio_st != DEF_SWAP_PRIO)
+		desc[nr-1].prio_st = DEF_SWAP_PRIO;
+
+	if (nr + nr_swaptiers > MAX_SWAPTIER) {
+		ret = -ERANGE;
+		goto out;
+	}
+
+	for (int i = 0; i < nr; i++) {
+		ret = swap_tier_can_split_range(&desc[i]);
+		if (ret)
+			goto out;
+	}
+
+	for (int i = 0; i < nr; i++)
+		swap_tier_prepare(&desc[i]);
+
+	swap_tier_apply(desc, nr);
+out:
+	spin_unlock(&swap_tier_lock);
+	spin_unlock(&swap_lock);
+
+	return ret;
+}
+
+static void swap_tier_remove(struct swap_tier *tier)
+{
+	bool least_prio_merge = false;
+	struct plist_node *next;
+	struct swap_tier *merge_tier;
+
+	lockdep_assert_held(&swap_tier_lock);
+
+	if (tier->prio_st == DEF_SWAP_PRIO) {
+		least_prio_merge = true;
+		next = plist_prev(&tier->list);
+	} else
+		next = plist_next(&tier->list);
+
+	plist_del(&tier->list, &swap_tier_active_list);
+	INIT_LIST_HEAD(&tier->inactive_list);
+	list_add_tail(&tier->inactive_list, &swap_tier_inactive_list);
+	nr_swaptiers--;
+
+	if (nr_swaptiers == SWAP_TIER_RESERVED_CNT)
+		return;
+
+	merge_tier = container_of(next, struct swap_tier, list);
+	/*
+	 * When the first tier is removed, the rule that all priorities
+	 * must be covered should be maintained. The next tier inherits the
+	 * start value of the removed first tier.
+	 */
+	if (least_prio_merge)
+		merge_tier->prio_st = DEF_SWAP_PRIO;
+	else
+		merge_tier->prio_end = tier->prio_end;
+}
+
+int swap_tiers_remove(struct tiers_desc desc[], int nr)
+{
+	int cnt = 0;
+	int ret = 0;
+	struct swap_tier *tier;
+
+	for (int i = 0; i < nr; i++) {
+		for (int j = i+1; j < nr; j++) {
+			if (!strcmp(desc[i].name, desc[j].name))
+				return -EINVAL;
+		}
+	}
+
+	spin_lock(&swap_tier_lock);
+	if (nr <= 0 || nr > nr_swaptiers) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (int i = 0; i < nr; i++) {
+		for_each_active_tier(tier) {
+			if (swap_tier_is_default(tier))
+				continue;
+
+			if (!strcmp(desc[i].name, tier->name)) {
+				if (swap_tier_alive(tier)) {
+					ret = -EBUSY;
+					goto out;
+				}
+				desc[i].tier_idx = TIER_IDX(tier);
+				cnt++;
+			}
+		}
+	}
+
+	if (cnt != nr) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (int i = 0; i < nr; i++)
+		swap_tier_put(&swap_tiers[desc[i].tier_idx]);
+
+out:
+	spin_unlock(&swap_tier_lock);
+	return ret;
+}
+
+ssize_t swap_tiers_show_sysfs(char *buf)
+{
+	struct swap_tier *tier;
+	ssize_t len = 0;
+
+	spin_lock(&swap_tier_lock);
+	len += sysfs_emit_at(buf, len, "%-16s %-5s %-11s %-11s\n",
+			 "Name", "Idx", "PrioStart", "PrioEnd");
+	for_each_active_tier(tier) {
+		if (swap_tier_is_default(tier))
+			len += sysfs_emit_at(buf, len, "%-16s %-5ld\n",
+					     tier->name,
+					     TIER_IDX(tier));
+		else {
+			len += sysfs_emit_at(buf, len, "%-16s %-5ld %-11d %-11d\n",
+					     tier->name,
+					     TIER_IDX(tier),
+					     tier->prio_st,
+					     tier->prio_end);
+		}
+		if (len >= PAGE_SIZE)
+			break;
+	}
+	spin_unlock(&swap_tier_lock);
+
+	return len;
+}
+
+static void swap_tier_show_mask(struct seq_file *m, int memcg_mask)
+{
+	struct swap_tier *tier;
+	int idx;
+
+	for_each_active_tier(tier) {
+		idx = TIER_IDX(tier);
+		int tier_on_mask = TIER_MASK(idx, TIER_ON_MASK);
+		int tier_off_mask = TIER_MASK(idx, TIER_OFF_MASK);
+
+		if (memcg_mask & tier_on_mask)
+			seq_printf(m, "+%s ", tier->name);
+		else if (memcg_mask & tier_off_mask)
+			seq_printf(m, "-%s ", tier->name);
+	}
+	seq_puts(m, "\n");
+}
+
+static bool swap_tier_has_default(int mask)
+{
+	return mask & DEFAULT_FULL_MASK;
+}
+
+/*
+ * TODO: Simplify tier mask collection design if possible.
+ *
+ * Current approach uses two separate fields per cgroup:
+ *   - tiers_onoff: 2-bit per tier to indicate on/off state
+ *   - tiers_mask:  2-bit per tier to indicate if the tier is configured
+ *
+ * Trade-off to consider:
+ *   - Pre-compute at cgroup setup time (faster runtime, complex invalidation)
+ *   - Keep runtime calculation (simpler, but repeated parent walks)
+ */
+static int swap_tier_collect_mask(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *p;
+	int onoff, mask, merge, new;
+
+	if (!memcg)
+		return DEFAULT_ON_MASK;
+
+	onoff = memcg->tiers_onoff;
+	mask = memcg->tiers_mask;
+
+	rcu_read_lock();
+	for (p = parent_mem_cgroup(memcg); p && !swap_tier_has_default(onoff);
+		p = parent_mem_cgroup(p)) {
+		merge = mask | p->tiers_mask;
+		new = merge ^ mask;
+		onoff |= p->tiers_onoff & new;
+		mask = merge;
+	}
+	rcu_read_unlock();
+
+	return onoff;
+}
+
+int swap_tiers_collect_compare_mask(struct mem_cgroup *memcg)
+{
+	int onoff;
+
+	onoff = swap_tier_collect_mask(memcg);
+
+	/* Make common case fast */
+	if (onoff & DEFAULT_ON_MASK)
+		return onoff;
+	/*
+	 * Root memcg has DEFAULT_ON_MASK; defaults are covered.
+	 * Checking DEFAULT_OFF_MASK suffices; only each tier's ON bit is checked.
+	 * ON flag is inverted and compared with each swap device's OFF mask.
+	 */
+	return ~(onoff << 1);
+}
+
+void swap_tiers_show_memcg(struct seq_file *m, struct mem_cgroup *memcg)
+{
+	spin_lock(&swap_tier_lock);
+	if (memcg->tiers_onoff)
+		swap_tier_show_mask(m, memcg->tiers_onoff);
+	else
+		seq_puts(m, "\n");
+	swap_tier_show_mask(m, swap_tier_collect_mask(memcg));
+	spin_unlock(&swap_tier_lock);
+}
+
+void swap_tiers_assign(struct swap_info_struct *swp)
+{
+	struct swap_tier *tier;
+
+	spin_lock(&swap_tier_lock);
+	swp->tier_idx = NULL_TIER;
+
+	for_each_active_tier(tier) {
+		if (swap_tier_is_default(tier))
+			continue;
+		if (swap_tier_prio_in_range(tier, swp->prio)) {
+			swp->tier_idx = TIER_IDX(tier);
+			swap_tier_get(tier);
+			break;
+		}
+	}
+	spin_unlock(&swap_tier_lock);
+}
+
+void swap_tiers_release(struct swap_info_struct *swp)
+{
+	spin_lock(&swap_tier_lock);
+	if (swp->tier_idx != NULL_TIER)
+		swap_tier_put(&swap_tiers[swp->tier_idx]);
+	spin_unlock(&swap_tier_lock);
+}
+
+/* not incremental, but reset. */
+int swap_tiers_get_mask(struct tiers_desc *desc, int nr, struct mem_cgroup *memcg)
+{
+	struct swap_tier *tier;
+	int ret = 0;
+	int tiers_mask = 0;
+	int tiers_onoff = 0;
+	int cnt = 0;
+
+	for (int i = 0; i < nr; i++) {
+		for (int j = i+1; j < nr; j++) {
+			if (!strcmp(desc[i].name, desc[j].name))
+				return -EINVAL;
+		}
+	}
+
+	spin_lock(&swap_tier_lock);
+	/* nr 0 is allowed for deletion */
+	if (nr < 0 || nr > nr_swaptiers) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (int i = 0; i < nr; i++) {
+		for_each_active_tier(tier) {
+			if (!strcmp(desc[i].name, tier->name)) {
+				tiers_mask |= TIER_MASK(TIER_IDX(tier), TIER_FULL_MASK);
+				tiers_onoff |= TIER_MASK(TIER_IDX(tier), desc[i].ops);
+				cnt++;
+				break;
+			}
+		}
+	}
+
+	if (cnt != nr) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	swap_tier_put_mask(memcg->tiers_mask);
+	swap_tier_get_mask(tiers_mask);
+	memcg->tiers_mask = tiers_mask;
+	memcg->tiers_onoff = tiers_onoff;
+out:
+	spin_unlock(&swap_tier_lock);
+	return ret;
+}
+
+void swap_tiers_put_mask(struct mem_cgroup *memcg)
+{
+	spin_lock(&swap_tier_lock);
+	swap_tier_put_mask(memcg->tiers_mask);
+	spin_unlock(&swap_tier_lock);
+}
diff --git a/mm/swap_tier.h b/mm/swap_tier.h
new file mode 100644
index 000000000000..f4b4e385638a
--- /dev/null
+++ b/mm/swap_tier.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SWAP_TIER_H
+#define _SWAP_TIER_H
+
+#include "swap.h"
+#include <linux/memcontrol.h>
+
+#ifdef CONFIG_SWAP_TIER
+
+enum swap_tiers_index {
+	SWAP_TIER_DEFAULT,
+#ifdef CONFIG_ZSWAP
+	SWAP_TIER_ZSWAP,
+#endif
+	SWAP_TIER_RESERVED_CNT,
+};
+
+#define MAX_TIERNAME			16
+#define MAX_SWAPTIER			12
+
+#define TIER_MASK(idx, mask)		((mask) << (idx) * 2)
+#define TIER_ON_MASK			(1 << 0)
+#define TIER_OFF_MASK			(1 << 1)
+#define TIER_FULL_MASK			(TIER_ON_MASK | TIER_OFF_MASK)
+
+#define DEFAULT_ON_MASK			TIER_MASK(SWAP_TIER_DEFAULT, TIER_ON_MASK)
+#define DEFAULT_OFF_MASK		TIER_MASK(SWAP_TIER_DEFAULT, TIER_OFF_MASK)
+#define DEFAULT_FULL_MASK		(DEFAULT_ON_MASK | DEFAULT_OFF_MASK)
+
+#define DEFAULT_TIER_NAME		""
+#define ZSWAP_TIER_NAME			"ZSWAP"
+
+struct tiers_desc {
+	char name[MAX_TIERNAME];
+	union {
+		signed short prio_st;
+		signed short ops;
+	};
+	int tier_idx;
+};
+
+void swap_tiers_init(void);
+int swap_tiers_add(struct tiers_desc desc[], int nr);
+int swap_tiers_remove(struct tiers_desc desc[], int nr);
+ssize_t swap_tiers_show_sysfs(char *buf);
+void swap_tiers_show_memcg(struct seq_file *m, struct mem_cgroup *memcg);
+void swap_tiers_assign(struct swap_info_struct *swp);
+void swap_tiers_release(struct swap_info_struct *swp);
+int swap_tiers_get_mask(struct tiers_desc *desc, int nr, struct mem_cgroup *memcg);
+void swap_tiers_put_mask(struct mem_cgroup *memcg);
+static inline bool swap_tiers_test_off(int tier_idx, int mask)
+{
+	return TIER_MASK(tier_idx, TIER_OFF_MASK) & mask;
+}
+int swap_tiers_collect_compare_mask(struct mem_cgroup *memcg);
+#else
+static inline void swap_tiers_init(void)
+{
+}
+static inline void swap_tiers_assign(struct swap_info_struct *swp)
+{
+}
+static inline void swap_tiers_release(struct swap_info_struct *swp)
+{
+}
+static inline bool swap_tiers_test_off(int tier_off_mask, int mask)
+{
+	return false;
+}
+static inline int swap_tiers_collect_compare_mask(struct mem_cgroup *memcg);
+{
+	return 0;
+}
+#endif
+#endif
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 3bb77c9a4879..a5c90e419ff3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -63,7 +63,7 @@ static void move_cluster(struct swap_info_struct *si,
 			 struct swap_cluster_info *ci, struct list_head *list,
 			 enum swap_cluster_flags new_flags);
 
-static DEFINE_SPINLOCK(swap_lock);
+DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
 atomic_long_t nr_swap_pages;
 /*
@@ -74,7 +74,6 @@ atomic_long_t nr_swap_pages;
 EXPORT_SYMBOL_GPL(nr_swap_pages);
 /* protected with swap_lock. reading in vm_swap_full() doesn't need lock */
 long total_swap_pages;
-#define DEF_SWAP_PRIO  -1
 unsigned long swapfile_maximum_size;
 #ifdef CONFIG_MIGRATION
 bool swap_migration_ad_supported;
@@ -89,7 +88,7 @@ static const char Unused_offset[] = "Unused swap offset entry ";
  * all active swap_info_structs
  * protected with swap_lock, and ordered by priority.
  */
-static PLIST_HEAD(swap_active_head);
+PLIST_HEAD(swap_active_head);
 
 /*
  * all available (active, not full) swap_info_structs
-- 
2.34.1


