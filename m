Return-Path: <cgroups+bounces-13570-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGQiAPX7fWkmUwIAu9opvQ
	(envelope-from <cgroups+bounces-13570-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 13:56:21 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A86B2C1D7F
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 13:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7ACF73003D1D
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 12:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D372652AF;
	Sat, 31 Jan 2026 12:56:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF424A06B
	for <cgroups@vger.kernel.org>; Sat, 31 Jan 2026 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769864169; cv=none; b=ssCnyCnA5aK7O3fT8e+yCZB6xgBBLW55xoagdt4HbIMzN3jKnyaN9JpHY5JnOnxo5RFMz/Ha3fKzOy4D4FcfQ4S4FsKWyBhbP6NAbWBdK1FYT5Wbp0m0Y/hCSW6B+QH0uLskcQqt8NSalIisn6/uu6PQIkGscyKQnwQlCr+RPcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769864169; c=relaxed/simple;
	bh=oURYD9tlVefoRIfQOj01sG8pXeg74/HP6wBM89lR3h0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cqMaorXG7R4XUdQAjrnHuI1FRekqt74zsoQteWMLBTNs0d6phllFmTanAAmwb646flfHOOpHHSMeXH5ERCGbo+ShJgzivEtHjvCMUv0o4qTfYfsf20ZWgbg4dvDCfBu5lt8+EKw5dfNJdxDAsgN6OVorMLzhgYy+Q7wWb3GQTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 31 Jan 2026 21:55:59 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org
Cc: chrisl@kernel.org,
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
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gunho.lee@lge.com,
	youngjun.park@lge.com,
	taejoon.song@lge.com
Subject: [RFC PATCH v3 2/5] mm: swap: associate swap devices with tiers
Date: Sat, 31 Jan 2026 21:54:51 +0900
Message-Id: <20260131125454.3187546-3-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131125454.3187546-1-youngjun.park@lge.com>
References: <20260131125454.3187546-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13570-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,vger.kernel.org,kvack.org,lge.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A86B2C1D7F
X-Rspamd-Action: no action

This patch connects swap devices to the swap tier infrastructure,
ensuring that devices are correctly assigned to tiers based on their
priority.

A `tier_mask` is added to identify the tier membership of swap devices.
Although tier-based allocation logic is not yet implemented, this
mapping is necessary to track which tier a device belongs to. Upon
activation, the device is assigned to a tier by matching its priority
against the configured tier ranges.

The infrastructure allows dynamic modification of tiers, such as
splitting or merging ranges. These operations are permitted provided
that the tier assignment of already configured swap devices remains
unchanged.

This patch also adds the documentation for the swap tier feature,
covering the core concepts, sysfs interface usage, and configuration
details.

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 Documentation/mm/swap-tier.rst | 109 +++++++++++++++++++++++++++++++++
 include/linux/swap.h           |   1 +
 mm/swap_state.c                |   2 +-
 mm/swap_tier.c                 | 100 +++++++++++++++++++++++++++---
 mm/swap_tier.h                 |  13 +++-
 mm/swapfile.c                  |   2 +
 6 files changed, 215 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/mm/swap-tier.rst

diff --git a/Documentation/mm/swap-tier.rst b/Documentation/mm/swap-tier.rst
new file mode 100644
index 000000000000..3386161b9b18
--- /dev/null
+++ b/Documentation/mm/swap-tier.rst
@@ -0,0 +1,109 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Chris Li <chrisl@kernel.org> Youngjun Park <youngjun.park@lge.com>
+
+==========
+Swap Tier
+==========
+
+Swap tier is a collection of user-named groups classified by priority ranges.
+It acts as a facilitation layer, allowing users to manage swap devices based
+on their speeds.
+
+Users are encouraged to assign swap device priorities according to device
+speed to fully utilize this feature. While the current implementation is
+integrated with cgroups, the concept is designed to be extensible for other
+subsystems in the future.
+
+Use case
+-------
+
+Users can perform selective swapping by choosing a swap tier assigned according
+to speed within a cgroup.
+
+For more information on cgroup v2, please refer to
+``Documentation/admin-guide/cgroup-v2.rst``.
+
+Priority Range
+--------------
+
+The specified tiers must cover the entire priority range from -1
+(DEF_SWAP_PRIO) to SHRT_MAX.
+
+Consistency
+-----------
+
+Tier consistency is guaranteed with a focus on maximizing flexibility. When a
+swap device is activated within a tier range, a reference is held from the
+start of the tier to the priority of that swap device. This ensures that the
+tier of region containing the active swap device does not disappear.
+
+If a request to add a new tier with a priority higher than the current swap
+device is received, the existing tier can be split.
+
+However, specifying a tier in a cgroup does not hold a reference to the tier.
+Consequently, the corresponding tier can disappear at any time.
+
+Configuration Interface
+-----------------------
+
+The swap tiers can be configured via the following interface:
+
+/sys/kernel/mm/swap/tiers
+
+Operations can be performed using the following syntax:
+
+* Add:    ``+"<tiername>":"<start_priority>"``
+* Remove: ``-"<tiername>"``
+* Modify: ``"<tiername>":"<start_priority>"``
+
+Multiple operations can be provided in a single write, separated by spaces (" ")
+or commas (",").
+
+When configuring tiers, the specified value represents the **start priority**
+of that tier. The end priority is automatically determined by the start
+priority of the next higher tier. Consequently, adding or modifying a tier
+automatically adjusts (splits or merges) the ranges of adjacent tiers to
+ensure continuity.
+
+Examples
+--------
+
+**1. Initialization**
+
+A tier starting at -1 is mandatory to cover the entire priority range up to
+SHRT_MAX. In this example, 'HDD' starts at 50, and 'NET' covers the remaining
+lower range starting from -1.
+
+::
+
+    # echo "+HDD:50, +NET:-1" > /sys/kernel/mm/swap/tiers
+    # cat /sys/kernel/mm/swap/tiers
+    Name             Idx   PrioStart   PrioEnd
+    HDD              0     50          32767
+    NET              1     -1          49
+
+**2. Modification and Splitting**
+
+Here, 'HDD' is moved to start at 80, and a new tier 'SSD' is added at 100.
+Notice how the ranges are automatically recalculated:
+* 'SSD' takes the top range. Split HDD Tier's range. (100 to SHRT_MAX).
+* 'HDD' is adjusted to the range between 'NET' and 'SSD' (80 to 99).
+* 'NET' automatically extends to fill the gap below 'HDD' (-1 to 79).
+
+::
+
+    # echo "HDD:80, +SSD:100" > /sys/kernel/mm/swap/tiers
+    # cat /sys/kernel/mm/swap/tiers
+    Name             Idx   PrioStart   PrioEnd
+    SSD              2     100         32767
+    HDD              0     80          99
+    NET              1     -1          79
+
+**3. Removal**
+
+Tiers can be removed using the '-' prefix.
+
+::
+
+    # echo "-SSD,-HDD,-NET" > /sys/kernel/mm/swap/tiers
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 62fc7499b408..1e68c220a0e7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -262,6 +262,7 @@ struct swap_info_struct {
 	struct percpu_ref users;	/* indicate and keep swap device valid. */
 	unsigned long	flags;		/* SWP_USED etc: see above */
 	signed short	prio;		/* swap priority of this type */
+	int tier_mask;			/* swap tier mask */
 	struct plist_node list;		/* entry in swap_active_head */
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* extent of the swap_map */
diff --git a/mm/swap_state.c b/mm/swap_state.c
index f1a7d9cdc648..d46ca61d2e42 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -997,7 +997,7 @@ static ssize_t tiers_store(struct kobject *kobj,
 			goto restore;
 	}
 
-	if (!swap_tiers_validate()) {
+	if (!swap_tiers_update()) {
 		ret = -EINVAL;
 		goto restore;
 	}
diff --git a/mm/swap_tier.c b/mm/swap_tier.c
index 3bd011abee7c..7741214312c7 100644
--- a/mm/swap_tier.c
+++ b/mm/swap_tier.c
@@ -14,7 +14,7 @@
  * @name: name of the swap_tier.
  * @prio: starting value of priority.
  * @list: linked list of tiers.
-*/
+ */
 static struct swap_tier {
 	char name[MAX_TIERNAME];
 	short prio;
@@ -34,6 +34,8 @@ static LIST_HEAD(swap_tier_inactive_list);
 	(!list_is_first(&(tier)->list, &swap_tier_active_list) ? \
 	list_prev_entry((tier), list)->prio - 1 : SHRT_MAX)
 
+#define MASK_TO_TIER(mask) (&swap_tiers[__ffs((mask))])
+
 #define for_each_tier(tier, idx) \
 	for (idx = 0, tier = &swap_tiers[0]; idx < MAX_SWAPTIER; \
 		idx++, tier = &swap_tiers[idx])
@@ -55,6 +57,26 @@ static bool swap_tier_is_active(void)
 	return !list_empty(&swap_tier_active_list) ? true : false;
 }
 
+static bool swap_tier_prio_in_range(struct swap_tier *tier, short prio)
+{
+	if (tier->prio <= prio && TIER_END_PRIO(tier) >= prio)
+		return true;
+
+	return false;
+}
+
+static bool swap_tier_prio_is_used(struct swap_tier *self, short prio)
+{
+	struct swap_tier *tier;
+
+	for_each_active_tier(tier) {
+		if (tier != self && tier->prio == prio)
+			return true;
+	}
+
+	return false;
+}
+
 static struct swap_tier *swap_tier_lookup(const char *name)
 {
 	struct swap_tier *tier;
@@ -67,12 +89,14 @@ static struct swap_tier *swap_tier_lookup(const char *name)
 	return NULL;
 }
 
+
 void swap_tiers_init(void)
 {
 	struct swap_tier *tier;
 	int idx;
 
 	BUILD_BUG_ON(BITS_PER_TYPE(int) < MAX_SWAPTIER);
+	BUILD_BUG_ON(MAX_SWAPTIER > TIER_DEFAULT_IDX);
 
 	for_each_tier(tier, idx) {
 		INIT_LIST_HEAD(&tier->list);
@@ -145,17 +169,35 @@ static struct swap_tier *swap_tier_prepare(const char *name, short prio)
 	return tier;
 }
 
-static int swap_tier_check_range(short prio)
+static int swap_tier_can_split_range(struct swap_tier *orig_tier,
+	short new_prio)
 {
+	struct swap_info_struct *p;
 	struct swap_tier *tier;
 
 	lockdep_assert_held(&swap_lock);
 	lockdep_assert_held(&swap_tier_lock);
 
-	for_each_active_tier(tier) {
-		/* No overwrite */
-		if (tier->prio == prio)
-			return -EINVAL;
+	plist_for_each_entry(p, &swap_active_head, list) {
+		if (p->tier_mask == TIER_DEFAULT_MASK)
+			continue;
+
+		tier = MASK_TO_TIER(p->tier_mask);
+		if (tier->prio > new_prio)
+			continue;
+		/*
+                 * Prohibit implicit tier reassignment.
+		 * Case 1: Prevent orig_tier devices from dropping out
+		 *         of the new range.
+		 */
+		if (orig_tier == tier && (p->prio < new_prio))
+			return -EBUSY;
+                /*
+                 * Case 2: Prevent other tier devices from entering
+                 *         the new range.
+                 */
+		else if (orig_tier != tier && (p->prio >= new_prio))
+			return -EBUSY;
 	}
 
 	return 0;
@@ -173,7 +215,10 @@ int swap_tiers_add(const char *name, int prio)
 	if (swap_tier_lookup(name))
 		return -EPERM;
 
-	ret = swap_tier_check_range(prio);
+	if (swap_tier_prio_is_used(NULL, prio))
+		return -EBUSY;
+
+	ret = swap_tier_can_split_range(NULL, prio);
 	if (ret)
 		return ret;
 
@@ -183,7 +228,6 @@ int swap_tiers_add(const char *name, int prio)
 		return ret;
 	}
 
-
 	swap_tier_insert_by_prio(tier);
 	return ret;
 }
@@ -200,6 +244,11 @@ int swap_tiers_remove(const char *name)
 	if (!tier)
 		return -EINVAL;
 
+	/* Simulate adding a tier to check for conflicts */
+	ret = swap_tier_can_split_range(NULL, tier->prio);
+	if (ret)
+		return ret;
+
 	/* Removing DEF_SWAP_PRIO merges into the higher tier. */
 	if (!list_is_singular(&swap_tier_active_list)
 		&& tier->prio == DEF_SWAP_PRIO)
@@ -225,7 +274,10 @@ int swap_tiers_modify(const char *name, int prio)
 	if (tier->prio == prio)
 		return 0;
 
-	ret = swap_tier_check_range(prio);
+	if (swap_tier_prio_is_used(tier, prio))
+		return -EBUSY;
+
+	ret = swap_tier_can_split_range(tier, prio);
 	if (ret)
 		return ret;
 
@@ -283,9 +335,26 @@ void swap_tiers_restore(struct swap_tier_save_ctx ctx[])
 	}
 }
 
-bool swap_tiers_validate(void)
+void swap_tiers_assign_dev(struct swap_info_struct *swp)
+{
+	struct swap_tier *tier;
+
+	lockdep_assert_held(&swap_lock);
+
+	for_each_active_tier(tier) {
+		if (swap_tier_prio_in_range(tier, swp->prio)) {
+			swp->tier_mask = TIER_MASK(tier);
+			return;
+		}
+	}
+
+	swp->tier_mask = TIER_DEFAULT_MASK;
+}
+
+bool swap_tiers_update(void)
 {
 	struct swap_tier *tier;
+	struct swap_info_struct *swp;
 
 	/*
 	 * Initial setting might not cover DEF_SWAP_PRIO.
@@ -300,5 +369,16 @@ bool swap_tiers_validate(void)
 			return false;
 	}
 
+	/*
+	 * If applied initially, the swap tier_mask may change
+	 * from the default value.
+	 */
+	plist_for_each_entry(swp, &swap_active_head, list) {
+		/* Tier is already configured */
+		if (swp->tier_mask != TIER_DEFAULT_MASK)
+			break;
+		swap_tiers_assign_dev(swp);
+	}
+
 	return true;
 }
diff --git a/mm/swap_tier.h b/mm/swap_tier.h
index 4b1b0602d691..de81d540e3b5 100644
--- a/mm/swap_tier.h
+++ b/mm/swap_tier.h
@@ -14,6 +14,9 @@
 #define MAX_SWAPTIER		8
 #endif
 
+/* Forward declarations */
+struct swap_info_struct;
+
 extern spinlock_t swap_tier_lock;
 
 struct swap_tier_save_ctx {
@@ -24,6 +27,10 @@ struct swap_tier_save_ctx {
 #define DEFINE_SWAP_TIER_SAVE_CTX(_name) \
 	struct swap_tier_save_ctx _name[MAX_SWAPTIER] = {0}
 
+#define TIER_ALL_MASK		(~0)
+#define TIER_DEFAULT_IDX	(31)
+#define TIER_DEFAULT_MASK	(1 << TIER_DEFAULT_IDX)
+
 /* Initialization and application */
 void swap_tiers_init(void);
 ssize_t swap_tiers_sysfs_show(char *buf);
@@ -34,5 +41,9 @@ int swap_tiers_modify(const char *name, int prio);
 
 void swap_tiers_save(struct swap_tier_save_ctx ctx[]);
 void swap_tiers_restore(struct swap_tier_save_ctx ctx[]);
-bool swap_tiers_validate(void);
+bool swap_tiers_update(void);
+
+/* Tier assignment */
+void swap_tiers_assign_dev(struct swap_info_struct *swp);
+
 #endif /* _SWAP_TIER_H */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index c27952b41d4f..4f8ce021c5bd 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2672,6 +2672,8 @@ static void _enable_swap_info(struct swap_info_struct *si)
 
 	/* Add back to available list */
 	add_to_avail_list(si, true);
+
+	swap_tiers_assign_dev(si);
 }
 
 static void enable_swap_info(struct swap_info_struct *si, int prio,
-- 
2.34.1


