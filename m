Return-Path: <cgroups+bounces-17019-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0ESiHyIyMmoswgUAu9opvQ
	(envelope-from <cgroups+bounces-17019-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 07:35:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D7B6969C6
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 07:35:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lge.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17019-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17019-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A707D300CDAE
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 05:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BC138F249;
	Wed, 17 Jun 2026 05:35:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED84390C8E
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 05:35:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781674510; cv=none; b=mxpWtOLMylCZ0n8YVcQt9RRNManXvAcuzxcWC/1hsCGEZPSZ7khDdNYC+haghwUDWJ7atvcwY7mjJpOC6hqk95al/RpXP1aThGirYrJ6Z4hm7KZJHhvkD/OJLkh4dpuA7e9RiDrob1+fAV27OCADaGTFm+FOO1dEhDsq8eJbxnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781674510; c=relaxed/simple;
	bh=P73QfqNb7iM/PcUxB+VQP4vs1tgHtoziaMj80EB4Rug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZQHgmCBfStK8B0rWKCWYYGWAv6wmGkBC3w1U2X3rhnTxRIAZW2LHXDptzLpW07d4pM4yJTPwtzgjYAEoA52DKp/AEi7THXKVWHtH5rvjKob/uJK3CEmv16sxttwhJugZO03GklxLUij2CfAOMPxKvWhYTvBe4rS3MoN3jWgZFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 17 Jun 2026 14:34:55 +0900
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
	baoquan.he@linux.dev,
	baohua@kernel.org,
	yosry@kernel.org,
	gunho.lee@lge.com,
	taejoon.song@lge.com,
	hyungjun.cho@lge.com,
	mkoutny@suse.com,
	baver.bae@lge.com,
	matia.kim@lge.com
Subject: [PATCH v8 2/4] mm: swap: associate swap devices with tiers
Date: Wed, 17 Jun 2026 14:34:45 +0900
Message-Id: <20260617053447.2831896-3-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617053447.2831896-1-youngjun.park@lge.com>
References: <20260617053447.2831896-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17019-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:yosry@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,suse.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lge.com:email,lge.com:mid,lge.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39D7B6969C6

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

Reviewed-by: Baoquan He <baoquan.he@linux.dev>
Signed-off-by: Youngjun Park <youngjun.park@lge.com>

diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index 7aa2a8886908..a0d1447c5569 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -21,6 +21,7 @@ see the :doc:`admin guide <../admin-guide/mm/index>`.
    page_reclaim
    swap
    swap-table
+   swap-tier
    page_cache
    shmfs
    oom
diff --git a/Documentation/mm/swap-tier.rst b/Documentation/mm/swap-tier.rst
new file mode 100644
index 000000000000..0fb4a1153a67
--- /dev/null
+++ b/Documentation/mm/swap-tier.rst
@@ -0,0 +1,150 @@
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
+swap device is activated within a tier range, the tier covering that device's
+priority is guaranteed not to disappear or change while the device remains
+active. Adding a new tier may split the range of an existing tier, but the
+active device's tier assignment remains unchanged.
+
+However, specifying a tier in a cgroup does not guarantee the tier's existence.
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
+
+Tier names must consist of alphanumeric characters and underscores. Multiple
+operations can be provided in a single write, separated by commas (",") or
+whitespace (spaces, tabs, newlines).
+
+When configuring tiers, the specified value represents the **start priority**
+of that tier. The end priority is automatically determined by the start
+priority of the next higher tier. Consequently, adding a tier
+automatically adjusts the ranges of adjacent tiers to ensure continuity.
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
+**2. Adding a New Tier (split)**
+
+A new tier 'SSD' is added at priority 100, splitting the existing 'HDD' tier.
+The ranges are automatically recalculated:
+
+* 'SSD' takes the top range (100 to SHRT_MAX).
+* 'HDD' is adjusted to the range between 'NET' and 'SSD' (50 to 99).
+* 'NET' remains unchanged (-1 to 49).
+
+::
+
+    # echo "+SSD:100" > /sys/kernel/mm/swap/tiers
+    # cat /sys/kernel/mm/swap/tiers
+    Name             Idx   PrioStart   PrioEnd
+    SSD              2     100         32767
+    HDD              0     50          99
+    NET              1     -1          49
+
+**3. Removal (merge)**
+
+Tiers can be removed using the '-' prefix.
+::
+
+    # echo "-SSD" > /sys/kernel/mm/swap/tiers
+
+When a tier is removed, its priority range is merged into the adjacent
+tier. The merge direction is always upward (the tier below expands),
+except when the lowest tier is removed — in that case the tier above
+shifts its starting priority down to -1 to maintain full range coverage.
+
+::
+
+    Initial state:
+    Name             Idx   PrioStart   PrioEnd
+    SSD              2     100         32767
+    HDD              1     50          99
+    NET              0     -1          49
+
+    # echo "-SSD" > /sys/kernel/mm/swap/tiers
+
+    Name             Idx   PrioStart   PrioEnd
+    HDD              1     50          32767       <- merged with SSD's range
+    NET              0     -1          49
+
+    # echo "-NET" > /sys/kernel/mm/swap/tiers
+
+    Name             Idx   PrioStart   PrioEnd
+    HDD              1     -1          32767       <- shifted down to -1
+
+**4. Interaction with Active Swap Devices**
+
+If a swap device is active (swapon), the tier covering that device's
+priority cannot be removed. Splitting the active tier's range is only
+allowed above the device's priority.
+
+Assume a swap device is active at priority 60 (inside 'HDD' tier).
+
+::
+
+    # swapon -p 60 /dev/zram0
+
+    Name             Idx   PrioStart   PrioEnd
+    HDD              0     50          32767
+    NET              1     -1          49
+
+    # echo "-HDD" > /sys/kernel/mm/swap/tiers
+    -bash: echo: write error: Device or resource busy
+
+    # echo "+SSD:60" > /sys/kernel/mm/swap/tiers
+    -bash: echo: write error: Device or resource busy
+
+    # echo "+SSD:100" > /sys/kernel/mm/swap/tiers
+
+    Name             Idx   PrioStart   PrioEnd
+    SSD              2     100         32767
+    HDD              0     50          99          <- device (prio 60) stays here
+    NET              1     -1          49
diff --git a/MAINTAINERS b/MAINTAINERS
index d1bb3b4b1e1c..4293048be1ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17052,6 +17052,7 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-mm-swap
 F:	Documentation/mm/swap-table.rst
+F:	Documentation/mm/swap-tier.rst
 F:	include/linux/swap.h
 F:	include/linux/swapfile.h
 F:	include/linux/swapops.h
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 6d72778e6cc3..21286945770a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -250,6 +250,7 @@ struct swap_info_struct {
 	struct percpu_ref users;	/* indicate and keep swap device valid. */
 	unsigned long	flags;		/* SWP_USED etc: see above */
 	signed short	prio;		/* swap priority of this type */
+	int tier_mask;			/* swap tier mask */
 	struct plist_node list;		/* entry in swap_active_head */
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* size of this swap device */
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 762d9ca6ad5a..2f382d4dcbdc 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -1063,7 +1063,7 @@ static ssize_t tiers_store(struct kobject *kobj,
 		}
 	}
 
-	if (!swap_tiers_validate()) {
+	if (!swap_tiers_update()) {
 		ret = -EINVAL;
 		goto restore;
 	}
diff --git a/mm/swap_tier.c b/mm/swap_tier.c
index ac7a3c2a48cb..6b57cadb3e95 100644
--- a/mm/swap_tier.c
+++ b/mm/swap_tier.c
@@ -38,6 +38,8 @@ static LIST_HEAD(swap_tier_inactive_list);
 	(!list_is_first(&(tier)->list, &swap_tier_active_list) ? \
 	list_prev_entry((tier), list)->prio - 1 : SHRT_MAX)
 
+#define MASK_TO_TIER(mask) (&swap_tiers[__ffs((mask))])
+
 #define for_each_tier(tier, idx) \
 	for (idx = 0, tier = &swap_tiers[0]; idx < MAX_SWAPTIER; \
 		idx++, tier = &swap_tiers[idx])
@@ -59,6 +61,26 @@ static bool swap_tier_is_active(void)
 	return !list_empty(&swap_tier_active_list);
 }
 
+static bool swap_tier_prio_in_range(struct swap_tier *tier, short prio)
+{
+	if (tier->prio <= prio && TIER_END_PRIO(tier) >= prio)
+		return true;
+
+	return false;
+}
+
+static bool swap_tier_prio_is_used(short prio)
+{
+	struct swap_tier *tier;
+
+	for_each_active_tier(tier) {
+		if (tier->prio == prio)
+			return true;
+	}
+
+	return false;
+}
+
 static struct swap_tier *swap_tier_lookup(const char *name)
 {
 	struct swap_tier *tier;
@@ -99,6 +121,7 @@ void swap_tiers_init(void)
 	int idx;
 
 	BUILD_BUG_ON(BITS_PER_TYPE(int) < MAX_SWAPTIER);
+	BUILD_BUG_ON(MAX_SWAPTIER > TIER_DEFAULT_IDX);
 
 	for_each_tier(tier, idx) {
 		INIT_LIST_HEAD(&tier->list);
@@ -149,17 +172,29 @@ static struct swap_tier *swap_tier_prepare(const char *name, short prio)
 	return tier;
 }
 
-static int swap_tier_check_range(short prio)
+static int swap_tier_can_split_range(short new_prio)
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
+		if (!swap_tier_prio_in_range(tier, new_prio))
+			continue;
+
+		/*
+		 * Device sits in a tier that spans new_prio;
+		 * splitting here would reassign it to a
+		 * different tier.
+		 */
+		if (p->prio >= new_prio)
+			return -EBUSY;
 	}
 
 	return 0;
@@ -199,7 +234,11 @@ int swap_tiers_add(const char *name, int prio)
 	if (!swap_tier_validate_name(name))
 		return -EINVAL;
 
-	ret = swap_tier_check_range(prio);
+	/* No overwrite */
+	if (swap_tier_prio_is_used(prio))
+		return -EBUSY;
+
+	ret = swap_tier_can_split_range(prio);
 	if (ret)
 		return ret;
 
@@ -226,6 +265,11 @@ int swap_tiers_remove(const char *name)
 	if (!tier)
 		return -EINVAL;
 
+	/* Simulate adding a tier to check for conflicts */
+	ret = swap_tier_can_split_range(tier->prio);
+	if (ret)
+		return ret;
+
 	/* Removing DEF_SWAP_PRIO merges into the higher tier. */
 	if (!list_is_singular(&swap_tier_active_list)
 		&& tier->prio == DEF_SWAP_PRIO)
@@ -236,13 +280,15 @@ int swap_tiers_remove(const char *name)
 	return ret;
 }
 
-static struct swap_tier swap_tiers_snap[MAX_SWAPTIER];
 /*
- * XXX: When multiple operations (adds and removes) are submitted in a
- * single write, reverting each individually on failure is complex and
- * error-prone. Instead, snapshot the entire state beforehand and
- * restore it wholesale if any operation fails.
+ * XXX: Static global snapshot buffer for batch operations. Small
+ * and used once per write, so a static global is not bad.
+ * When multiple adds/removes are submitted in a single write,
+ * reverting each individually on failure is error-prone. Instead,
+ * snapshot beforehand and restore wholesale if any operation fails.
  */
+static struct swap_tier swap_tiers_snap[MAX_SWAPTIER];
+
 void swap_tiers_snapshot(void)
 {
 	BUILD_BUG_ON(sizeof(swap_tiers_snap) != sizeof(swap_tiers));
@@ -282,10 +328,30 @@ void swap_tiers_snapshot_restore(void)
 	}
 }
 
-bool swap_tiers_validate(void)
+void swap_tiers_assign_dev(struct swap_info_struct *swp)
 {
 	struct swap_tier *tier;
 
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
+{
+	struct swap_tier *tier;
+	struct swap_info_struct *swp;
+
+	lockdep_assert_held(&swap_lock);
+	lockdep_assert_held(&swap_tier_lock);
+
 	/*
 	 * Initial setting might not cover DEF_SWAP_PRIO.
 	 * Swap tier must cover the full range (DEF_SWAP_PRIO to SHRT_MAX).
@@ -298,5 +364,16 @@ bool swap_tiers_validate(void)
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
index a1395ec02c24..3e355f857363 100644
--- a/mm/swap_tier.h
+++ b/mm/swap_tier.h
@@ -5,8 +5,15 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 
+/* Forward declarations */
+struct swap_info_struct;
+
 extern spinlock_t swap_tier_lock;
 
+#define TIER_ALL_MASK		(~0)
+#define TIER_DEFAULT_IDX	(31)
+#define TIER_DEFAULT_MASK	(1U << TIER_DEFAULT_IDX)
+
 /* Initialization and application */
 void swap_tiers_init(void);
 ssize_t swap_tiers_sysfs_show(char *buf);
@@ -16,5 +23,9 @@ int swap_tiers_remove(const char *name);
 
 void swap_tiers_snapshot(void);
 void swap_tiers_snapshot_restore(void);
-bool swap_tiers_validate(void);
+bool swap_tiers_update(void);
+
+/* Tier assignment */
+void swap_tiers_assign_dev(struct swap_info_struct *swp);
+
 #endif /* _SWAP_TIER_H */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 3f7225dbc6cd..9a86ebe992f4 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3036,6 +3036,8 @@ static void _enable_swap_info(struct swap_info_struct *si)
 
 	/* Add back to available list */
 	add_to_avail_list(si, true);
+
+	swap_tiers_assign_dev(si);
 }
 
 /*
-- 
2.34.1


