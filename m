Return-Path: <cgroups+bounces-15404-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBsKOhER52nL3QEAu9opvQ
	(envelope-from <cgroups+bounces-15404-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 07:54:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABB24369A0
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 07:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 661FF3025C7C
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C687D33C192;
	Tue, 21 Apr 2026 05:53:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D57337110
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 05:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776750819; cv=none; b=Aw6fvQCE8g3SskWVdYilBndMO5Mk/j1aFgeisIlyq6xC4mt4hUZuxDMXHCrUVdeH8tL2HirJx5O5q7LPBNIzs2P7ZwuYeMgMFK6yB76qLDIXmACQSw8PBKEg1narBXV6moM/NP7JRPvTrAfmXXLvICBWGfaW81g5RTVZq+/AAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776750819; c=relaxed/simple;
	bh=vxXSl/7//BwDQiiHK8TtAZRbdCMhETJLbFmv3IMcSaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WmOyw+oWbxaQy2S0yZZfdCTpwXnUKhsmW94kJPDMjuk+2OyPI+MbjqliJh3WPMXoHCNEfsgXca0k8QbxwhXV8fdh0WH5sjb720zLBUdqTixF/fvnRyNs6GhO1BXDG+K/kpCPpIEHVrkQQJRMn2G3sfkkjzH5L2MeX5GCtuOms0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 21 Apr 2026 14:53:29 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	youngjun.park@lge.com,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
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
	gunho.lee@lge.com,
	taejoon.song@lge.com,
	hyungjun.cho@lge.com,
	mkoutny@suse.com,
	baver.bae@lge.com,
	matia.kim@lge.com
Subject: [PATCH v6 1/4] mm: swap: introduce swap tier infrastructure
Date: Tue, 21 Apr 2026 14:53:20 +0900
Message-Id: <20260421055323.940344-2-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421055323.940344-1-youngjun.park@lge.com>
References: <20260421055323.940344-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15404-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7ABB24369A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch introduces the "Swap tier" concept, which serves as an
abstraction layer for managing swap devices based on their performance
characteristics (e.g., NVMe, HDD, Network swap).

Swap tiers are user-named groups representing priority ranges.
Tier names must consist of alphanumeric characters and underscores.
These tiers collectively cover the entire priority space from -1
(`DEF_SWAP_PRIO`) to `SHRT_MAX`.

To configure tiers, a new sysfs interface is exposed at
/sys/kernel/mm/swap/tiers. The input parser evaluates commands from
left to right and supports batch input, allowing users to add or remove
multiple tiers in a single write operation.

Tier management enforces continuous priority ranges anchored by start
priorities. Operations trigger range splitting or merging, but overwriting
start priorities is forbidden. Merging expands lower tiers upwards to
preserve configured start priorities, except when removing `DEF_SWAP_PRIO`,
which merges downwards.

Suggested-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 MAINTAINERS     |   2 +
 mm/Kconfig      |  12 ++
 mm/Makefile     |   2 +-
 mm/swap.h       |   4 +
 mm/swap_state.c |  74 ++++++++++++
 mm/swap_tier.c  | 302 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/swap_tier.h  |  20 ++++
 mm/swapfile.c   |   8 +-
 8 files changed, 420 insertions(+), 4 deletions(-)
 create mode 100644 mm/swap_tier.c
 create mode 100644 mm/swap_tier.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 76d8291237be..83a181acd50b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17033,6 +17033,8 @@ F:	mm/swap.c
 F:	mm/swap.h
 F:	mm/swap_table.h
 F:	mm/swap_state.c
+F:	mm/swap_tier.c
+F:	mm/swap_tier.h
 F:	mm/swapfile.c
 
 MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE)
diff --git a/mm/Kconfig b/mm/Kconfig
index 0a43bb80df4f..d8242ceee7dd 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -19,6 +19,18 @@ menuconfig SWAP
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 
+config NR_SWAP_TIERS
+        int "Number of swap device tiers"
+        depends on SWAP
+        default 4
+        range 1 31
+        help
+          Sets the number of swap device tiers. Swap devices are
+          grouped into tiers based on their priority, allowing the
+          system to prefer faster devices over slower ones.
+
+          If unsure, say 4.
+
 config ZSWAP
 	bool "Compressed cache for swap pages"
 	depends on SWAP
diff --git a/mm/Makefile b/mm/Makefile
index 8ad2ab08244e..db6449f84991 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -75,7 +75,7 @@ ifdef CONFIG_MMU
 	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
 endif
 
-obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o swap_tier.o
 obj-$(CONFIG_ZSWAP)	+= zswap.o
 obj-$(CONFIG_HAS_DMA)	+= dmapool.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o hugetlb_sysfs.o hugetlb_sysctl.o
diff --git a/mm/swap.h b/mm/swap.h
index a77016f2423b..fda8363bee73 100644
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
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 1415a5c54a43..04a6f1766b36 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -25,6 +25,7 @@
 #include "internal.h"
 #include "swap_table.h"
 #include "swap.h"
+#include "swap_tier.h"
 
 /*
  * swapper_space is a fiction, retained to simplify the path through
@@ -924,8 +925,81 @@ static ssize_t vma_ra_enabled_store(struct kobject *kobj,
 }
 static struct kobj_attribute vma_ra_enabled_attr = __ATTR_RW(vma_ra_enabled);
 
+static ssize_t tiers_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	return swap_tiers_sysfs_show(buf);
+}
+
+static ssize_t tiers_store(struct kobject *kobj,
+			    struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	char *p, *token, *name, *tmp;
+	int ret = 0;
+	short prio;
+
+	tmp = kstrdup(buf, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	spin_lock(&swap_lock);
+	spin_lock(&swap_tier_lock);
+	swap_tiers_snapshot();
+
+	p = tmp;
+	while ((token = strsep(&p, ", \t\n")) != NULL) {
+		if (!*token)
+			continue;
+
+		switch (token[0]) {
+		case '+':
+			name = token + 1;
+			token = strchr(name, ':');
+			if (!token) {
+				ret = -EINVAL;
+				goto restore;
+			}
+			*token++ = '\0';
+			if (kstrtos16(token, 10, &prio)) {
+				ret = -EINVAL;
+				goto restore;
+			}
+			ret = swap_tiers_add(name, prio);
+			if (ret)
+				goto restore;
+			break;
+		case '-':
+			ret = swap_tiers_remove(token + 1);
+			if (ret)
+				goto restore;
+			break;
+		default:
+			ret = -EINVAL;
+			goto restore;
+		}
+	}
+
+	if (!swap_tiers_validate()) {
+		ret = -EINVAL;
+		goto restore;
+	}
+	goto out;
+
+restore:
+	swap_tiers_snapshot_restore();
+out:
+	spin_unlock(&swap_tier_lock);
+	spin_unlock(&swap_lock);
+	kfree(tmp);
+	return ret ? ret : count;
+}
+
+static struct kobj_attribute tier_attr = __ATTR_RW(tiers);
+
 static struct attribute *swap_attrs[] = {
 	&vma_ra_enabled_attr.attr,
+	&tier_attr.attr,
 	NULL,
 };
 
diff --git a/mm/swap_tier.c b/mm/swap_tier.c
new file mode 100644
index 000000000000..9490e891c5fe
--- /dev/null
+++ b/mm/swap_tier.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/swap.h>
+#include <linux/memcontrol.h>
+#include "memcontrol-v1.h"
+#include <linux/sysfs.h>
+#include <linux/plist.h>
+
+#include "swap.h"
+#include "swap_tier.h"
+
+#define MAX_SWAPTIER	CONFIG_NR_SWAP_TIERS
+#define MAX_TIERNAME	16
+
+/*
+ * struct swap_tier - structure representing a swap tier.
+ *
+ * @name: name of the swap_tier.
+ * @prio: starting value of priority.
+ * @list: linked list of tiers.
+ */
+static struct swap_tier {
+	char name[MAX_TIERNAME];
+	short prio;
+	struct list_head list;
+} swap_tiers[MAX_SWAPTIER];
+
+DEFINE_SPINLOCK(swap_tier_lock);
+/* active swap priority list, sorted in descending order */
+static LIST_HEAD(swap_tier_active_list);
+/* unused swap_tier object */
+static LIST_HEAD(swap_tier_inactive_list);
+
+#define TIER_IDX(tier)	((tier) - swap_tiers)
+#define TIER_MASK(tier)	(1U << TIER_IDX(tier))
+#define TIER_INACTIVE_PRIO (DEF_SWAP_PRIO - 1)
+#define TIER_IS_ACTIVE(tier) ((tier->prio) !=  TIER_INACTIVE_PRIO)
+#define TIER_END_PRIO(tier) \
+	(!list_is_first(&(tier)->list, &swap_tier_active_list) ? \
+	list_prev_entry((tier), list)->prio - 1 : SHRT_MAX)
+
+#define for_each_tier(tier, idx) \
+	for (idx = 0, tier = &swap_tiers[0]; idx < MAX_SWAPTIER; \
+		idx++, tier = &swap_tiers[idx])
+
+#define for_each_active_tier(tier) \
+	list_for_each_entry(tier, &swap_tier_active_list, list)
+
+#define for_each_inactive_tier(tier) \
+	list_for_each_entry(tier, &swap_tier_inactive_list, list)
+
+/*
+ * Naming Convention:
+ *   swap_tiers_*() - Public/exported functions
+ *   swap_tier_*()  - Private/internal functions
+ */
+
+static bool swap_tier_is_active(void)
+{
+	return !list_empty(&swap_tier_active_list) ? true : false;
+}
+
+static struct swap_tier *swap_tier_lookup(const char *name)
+{
+	struct swap_tier *tier;
+
+	for_each_active_tier(tier) {
+		if (!strcmp(tier->name, name))
+			return tier;
+	}
+
+	return NULL;
+}
+
+/* Insert new tier into the active list sorted by priority. */
+static void swap_tier_activate(struct swap_tier *new)
+{
+	struct list_head *pos = &swap_tier_active_list;
+	struct swap_tier *tier;
+
+	for_each_active_tier(tier) {
+		if (tier->prio <= new->prio) {
+			pos = &tier->list;
+			break;
+		}
+	}
+
+	list_add_tail(&new->list, pos);
+}
+
+static void swap_tier_inactivate(struct swap_tier *tier)
+{
+	list_move(&tier->list, &swap_tier_inactive_list);
+	tier->prio = TIER_INACTIVE_PRIO;
+}
+
+void swap_tiers_init(void)
+{
+	struct swap_tier *tier;
+	int idx;
+
+	BUILD_BUG_ON(BITS_PER_TYPE(int) < MAX_SWAPTIER);
+
+	for_each_tier(tier, idx) {
+		INIT_LIST_HEAD(&tier->list);
+		swap_tier_inactivate(tier);
+	}
+}
+
+ssize_t swap_tiers_sysfs_show(char *buf)
+{
+	struct swap_tier *tier;
+	ssize_t len = 0;
+
+	len += sysfs_emit_at(buf, len, "%-16s %-5s %-11s %-11s\n",
+			 "Name", "Idx", "PrioStart", "PrioEnd");
+
+	spin_lock(&swap_tier_lock);
+	for_each_active_tier(tier) {
+		len += sysfs_emit_at(buf, len, "%-16s %-5td %-11d %-11d\n",
+				     tier->name,
+				     TIER_IDX(tier),
+				     tier->prio,
+				     TIER_END_PRIO(tier));
+	}
+	spin_unlock(&swap_tier_lock);
+
+	return len;
+}
+
+static struct swap_tier *swap_tier_prepare(const char *name, short prio)
+{
+	struct swap_tier *tier;
+
+	lockdep_assert_held(&swap_tier_lock);
+
+	if (prio < DEF_SWAP_PRIO)
+		return ERR_PTR(-EINVAL);
+
+	if (list_empty(&swap_tier_inactive_list))
+		return ERR_PTR(-ENOSPC);
+
+	tier = list_first_entry(&swap_tier_inactive_list,
+		struct swap_tier, list);
+
+	list_del_init(&tier->list);
+	strscpy(tier->name, name, MAX_TIERNAME);
+	tier->prio = prio;
+
+	return tier;
+}
+
+static int swap_tier_check_range(short prio)
+{
+	struct swap_tier *tier;
+
+	lockdep_assert_held(&swap_lock);
+	lockdep_assert_held(&swap_tier_lock);
+
+	for_each_active_tier(tier) {
+		/* No overwrite */
+		if (tier->prio == prio)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool swap_tier_validate_name(const char *name)
+{
+	int len;
+
+	if (!name || !*name)
+		return false;
+
+	len = strlen(name);
+	if (len >= MAX_TIERNAME)
+		return false;
+
+	while (*name) {
+		if (!isalnum(*name) && *name != '_')
+			return false;
+		name++;
+	}
+	return true;
+}
+
+int swap_tiers_add(const char *name, int prio)
+{
+	int ret;
+	struct swap_tier *tier;
+
+	lockdep_assert_held(&swap_lock);
+	lockdep_assert_held(&swap_tier_lock);
+
+	/* Duplicate check */
+	if (swap_tier_lookup(name))
+		return -EEXIST;
+
+	if (!swap_tier_validate_name(name))
+		return -EINVAL;
+
+	ret = swap_tier_check_range(prio);
+	if (ret)
+		return ret;
+
+	tier = swap_tier_prepare(name, prio);
+	if (IS_ERR(tier)) {
+		ret = PTR_ERR(tier);
+		return ret;
+	}
+
+	swap_tier_activate(tier);
+
+	return ret;
+}
+
+int swap_tiers_remove(const char *name)
+{
+	int ret = 0;
+	struct swap_tier *tier;
+
+	lockdep_assert_held(&swap_lock);
+	lockdep_assert_held(&swap_tier_lock);
+
+	tier = swap_tier_lookup(name);
+	if (!tier)
+		return -EINVAL;
+
+	/* Removing DEF_SWAP_PRIO merges into the higher tier. */
+	if (!list_is_singular(&swap_tier_active_list)
+		&& tier->prio == DEF_SWAP_PRIO)
+		list_prev_entry(tier, list)->prio = DEF_SWAP_PRIO;
+
+	swap_tier_inactivate(tier);
+
+	return ret;
+}
+
+static struct swap_tier swap_tiers_snap[MAX_SWAPTIER];
+/*
+ * XXX: When multiple operations (adds and removes) are submitted in a
+ * single write, reverting each individually on failure is complex and
+ * error-prone. Instead, snapshot the entire state beforehand and
+ * restore it wholesale if any operation fails.
+ */
+void swap_tiers_snapshot(void)
+{
+	BUILD_BUG_ON(sizeof(swap_tiers_snap) != sizeof(swap_tiers));
+
+	lockdep_assert_held(&swap_lock);
+	lockdep_assert_held(&swap_tier_lock);
+
+	memcpy(swap_tiers_snap, swap_tiers, sizeof(swap_tiers));
+}
+
+void swap_tiers_snapshot_restore(void)
+{
+	struct swap_tier *tier;
+	int idx;
+
+	lockdep_assert_held(&swap_lock);
+	lockdep_assert_held(&swap_tier_lock);
+
+	memcpy(swap_tiers, swap_tiers_snap, sizeof(swap_tiers));
+
+	INIT_LIST_HEAD(&swap_tier_active_list);
+	INIT_LIST_HEAD(&swap_tier_inactive_list);
+
+	/*
+	 * memcpy copied snapshot-time list pointers into each tier's
+	 * list_head.  Those references are stale, so re-init every
+	 * tier before re-linking into the freshly initialised global
+	 * lists below.
+	 */
+	for_each_tier(tier, idx) {
+		INIT_LIST_HEAD(&tier->list);
+
+		if (TIER_IS_ACTIVE(tier))
+			swap_tier_activate(tier);
+		else
+			swap_tier_inactivate(tier);
+	}
+}
+
+bool swap_tiers_validate(void)
+{
+	struct swap_tier *tier;
+
+	/*
+	 * Initial setting might not cover DEF_SWAP_PRIO.
+	 * Swap tier must cover the full range (DEF_SWAP_PRIO to SHRT_MAX).
+	 */
+	if (swap_tier_is_active()) {
+		tier = list_last_entry(&swap_tier_active_list,
+			struct swap_tier, list);
+
+		if (tier->prio != DEF_SWAP_PRIO)
+			return false;
+	}
+
+	return true;
+}
diff --git a/mm/swap_tier.h b/mm/swap_tier.h
new file mode 100644
index 000000000000..a1395ec02c24
--- /dev/null
+++ b/mm/swap_tier.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SWAP_TIER_H
+#define _SWAP_TIER_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+
+extern spinlock_t swap_tier_lock;
+
+/* Initialization and application */
+void swap_tiers_init(void);
+ssize_t swap_tiers_sysfs_show(char *buf);
+
+int swap_tiers_add(const char *name, int prio);
+int swap_tiers_remove(const char *name);
+
+void swap_tiers_snapshot(void);
+void swap_tiers_snapshot_restore(void);
+bool swap_tiers_validate(void);
+#endif /* _SWAP_TIER_H */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index c7e173b93e11..114e5d943de8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -49,6 +49,7 @@
 #include "swap_table.h"
 #include "internal.h"
 #include "swap.h"
+#include "swap_tier.h"
 
 static void swap_range_alloc(struct swap_info_struct *si,
 			     unsigned int nr_entries);
@@ -64,7 +65,8 @@ static void move_cluster(struct swap_info_struct *si,
  *
  * Also protects swap_active_head total_swap_pages, and the SWP_WRITEOK flag.
  */
-static DEFINE_SPINLOCK(swap_lock);
+DEFINE_SPINLOCK(swap_lock);
+
 static unsigned int nr_swapfiles;
 atomic_long_t nr_swap_pages;
 /*
@@ -75,7 +77,6 @@ atomic_long_t nr_swap_pages;
 EXPORT_SYMBOL_GPL(nr_swap_pages);
 /* protected with swap_lock. reading in vm_swap_full() doesn't need lock */
 long total_swap_pages;
-#define DEF_SWAP_PRIO  -1
 unsigned long swapfile_maximum_size;
 #ifdef CONFIG_MIGRATION
 bool swap_migration_ad_supported;
@@ -88,7 +89,7 @@ static const char Bad_offset[] = "Bad swap offset entry ";
  * all active swap_info_structs
  * protected with swap_lock, and ordered by priority.
  */
-static PLIST_HEAD(swap_active_head);
+PLIST_HEAD(swap_active_head);
 
 /*
  * all available (active, not full) swap_info_structs
@@ -3890,6 +3891,7 @@ static int __init swapfile_init(void)
 		swap_migration_ad_supported = true;
 #endif	/* CONFIG_MIGRATION */
 
+	swap_tiers_init();
 	return 0;
 }
 subsys_initcall(swapfile_init);
-- 
2.34.1


