Return-Path: <cgroups+bounces-15050-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEQ4EBMixGmZwgQAu9opvQ
	(envelope-from <cgroups+bounces-15050-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 18:57:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DF532A2D5
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 18:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C5F63026BD9
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 17:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A9A410D22;
	Wed, 25 Mar 2026 17:55:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A62340B6FA
	for <cgroups@vger.kernel.org>; Wed, 25 Mar 2026 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461311; cv=none; b=UR8Xgmj3iCnOlCfIhnu7E6R6YplV7QW3ufiI/v5sLcYCuVYqS/vgkAdooFlRL7vAkSvJJoors8rRME21Dfy1OhSo7nJFQNv3wpCdxlknzAsp/elRbWsi7lB+tcxaIM+Hlnj2h2p0A/5V/E+ZPMkUmX81weCRVbdHo2nS0Q/zScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461311; c=relaxed/simple;
	bh=iKiBB8/3ib88iWIauxXoaKiDnn+Eg7L0aIUL+2QL1Hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsUTxSxFS5Tkn6vrRUXVdgIqV/ISu9oMF+xn/4eMgla7yCdeUetBata8Y/2E1Z3JMBO09Ovijv6gl2jIec6p8KeiRF4G6AIGXJzyxf7BfOMWzRFAPtdPcsVPvmiAv/otFwoN7Nekxku3a66So0jhb353IhHr1pVQqM5uZP6zfJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 26 Mar 2026 02:55:00 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Li <chrisl@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
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
	mkoutny@suse.com
Subject: [PATCH v5 3/4] mm: memcontrol: add interfaces for swap tier selection
Date: Thu, 26 Mar 2026 02:54:52 +0900
Message-Id: <20260325175453.2523280-4-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325175453.2523280-1-youngjun.park@lge.com>
References: <20260325175453.2523280-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-15050-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,suse.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lge.com:email,lge.com:mid]
X-Rspamd-Queue-Id: 42DF532A2D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Integrate swap tier infrastructure with cgroup to allow selecting specific
swap devices per cgroup.

Introduce `memory.swap.tiers` for configuring allowed tiers, and
`memory.swap.tiers.effective` for exposing the effective tiers.
The effective tiers are the intersection of the configured tiers and
the parent's effective tiers.

Note that cgroups do not pin swap tiers, similar to `cpuset` and CPU
hotplug, allowing configuration changes regardless of usage.

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 27 +++++++
 include/linux/memcontrol.h              |  3 +-
 mm/memcontrol.c                         | 95 +++++++++++++++++++++++++
 mm/swap_state.c                         |  5 +-
 mm/swap_tier.c                          | 93 +++++++++++++++++++++++-
 mm/swap_tier.h                          | 56 +++++++++++++--
 6 files changed, 268 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8ad0b2781317..6effe1bfe74d 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1850,6 +1850,33 @@ The following nested keys are defined.
 	Swap usage hard limit.  If a cgroup's swap usage reaches this
 	limit, anonymous memory of the cgroup will not be swapped out.
 
+  memory.swap.tiers
+        A read-write file which exists on non-root cgroups.
+        Format is similar to cgroup.subtree_control.
+
+        Controls which swap tiers this cgroup is allowed to swap
+        out to. All tiers are enabled by default.
+
+          (-|+)TIER [(-|+)TIER ...]
+
+        "-" disables a tier, "+" re-enables it.
+        Entries are whitespace-delimited.
+
+        Changes here are combined with parent restrictions to
+        compute memory.swap.tiers.effective.
+
+        If a tier is removed from /sys/kernel/mm/swap/tiers,
+        any prior disable for that tier is invalidated.
+
+  memory.swap.tiers.effective
+        A read-only file which exists on non-root cgroups.
+
+        Shows the tiers this cgroup can actually swap out to.
+        This is the intersection of the parent's effective tiers
+        and this cgroup's own memory.swap.tiers configuration.
+        A child cannot enable a tier that is disabled in its
+        parent.
+
   memory.swap.events
 	A read-only flat-keyed file which exists on non-root cgroups.
 	The following entries are defined.  Unless specified
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0782c72a1997..5603d6ce905f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -281,7 +281,8 @@ struct mem_cgroup {
 	/* per-memcg mm_struct list */
 	struct lru_gen_mm_list mm_list;
 #endif
-
+	int tier_mask;
+	int tier_effective_mask;
 #ifdef CONFIG_MEMCG_V1
 	/* Legacy consumer-oriented counters */
 	struct page_counter kmem;		/* v1 only */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ac7b46c4d67e..5d7036b3926f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -68,6 +68,7 @@
 #include <net/ip.h>
 #include "slab.h"
 #include "memcontrol-v1.h"
+#include "swap_tier.h"
 
 #include <linux/uaccess.h>
 
@@ -4086,6 +4087,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	WRITE_ONCE(memcg->zswap_writeback, true);
 #endif
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
+	memcg->tier_mask = TIER_ALL_MASK;
+	swap_tiers_memcg_inherit_mask(memcg, parent);
+
 	if (parent) {
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
 
@@ -5694,6 +5698,86 @@ static int swap_events_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int swap_tier_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	swap_tiers_mask_show(m, memcg->tier_mask);
+	return 0;
+}
+
+static ssize_t swap_tier_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	char *pos, *token;
+	int ret = 0;
+	int original_mask;
+
+	pos = strstrip(buf);
+
+	spin_lock(&swap_tier_lock);
+	if (!*pos) {
+		memcg->tier_mask = TIER_ALL_MASK;
+		goto sync;
+	}
+
+	original_mask = memcg->tier_mask;
+
+	while ((token = strsep(&pos, " \t\n")) != NULL) {
+		int mask;
+
+		if (!*token)
+			continue;
+
+		if (token[0] != '-' && token[0] != '+') {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		mask = swap_tiers_mask_lookup(token+1);
+		if (!mask) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		/*
+		 * if child already set, cannot add that tiers for hierarch mismatching.
+		 * parent compatible, child must respect parent selected swap device.
+		 */
+		switch (token[0]) {
+		case '-':
+			memcg->tier_mask &= ~mask;
+			break;
+		case '+':
+			memcg->tier_mask |= mask;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+
+		if (ret)
+			goto err;
+	}
+
+sync:
+	swap_tiers_memcg_sync_mask(memcg);
+err:
+	if (ret)
+		memcg->tier_mask = original_mask;
+	spin_unlock(&swap_tier_lock);
+	return ret ? ret : nbytes;
+}
+
+static int swap_tier_effective_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	swap_tiers_mask_show(m, memcg->tier_effective_mask);
+	return 0;
+}
+
 static struct cftype swap_files[] = {
 	{
 		.name = "swap.current",
@@ -5726,6 +5810,17 @@ static struct cftype swap_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
 		.seq_show = swap_events_show,
 	},
+	{
+		.name = "swap.tiers",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_tier_show,
+		.write = swap_tier_write,
+	},
+	{
+		.name = "swap.tiers.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_tier_effective_show,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 847096e2f3e5..2d1bc6bc09d3 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -938,6 +938,7 @@ static ssize_t tiers_store(struct kobject *kobj,
 	char *p, *token, *name, *tmp;
 	int ret = 0;
 	short prio;
+	int mask = 0;
 
 	tmp = kstrdup(buf, GFP_KERNEL);
 	if (!tmp)
@@ -970,7 +971,7 @@ static ssize_t tiers_store(struct kobject *kobj,
 				goto restore;
 			break;
 		case '-':
-			ret = swap_tiers_remove(token + 1);
+			ret = swap_tiers_remove(token + 1, &mask);
 			if (ret)
 				goto restore;
 			break;
@@ -980,7 +981,7 @@ static ssize_t tiers_store(struct kobject *kobj,
 		}
 	}
 
-	if (!swap_tiers_update()) {
+	if (!swap_tiers_update(mask)) {
 		ret = -EINVAL;
 		goto restore;
 	}
diff --git a/mm/swap_tier.c b/mm/swap_tier.c
index 91aac55d3a8b..64365569b970 100644
--- a/mm/swap_tier.c
+++ b/mm/swap_tier.c
@@ -244,7 +244,7 @@ int swap_tiers_add(const char *name, int prio)
 	return ret;
 }
 
-int swap_tiers_remove(const char *name)
+int swap_tiers_remove(const char *name, int *mask)
 {
 	int ret = 0;
 	struct swap_tier *tier;
@@ -267,6 +267,7 @@ int swap_tiers_remove(const char *name)
 		list_prev_entry(tier, list)->prio = DEF_SWAP_PRIO;
 
 	swap_tier_inactivate(tier);
+	*mask |= TIER_MASK(tier);
 
 	return ret;
 }
@@ -327,7 +328,24 @@ void swap_tiers_assign_dev(struct swap_info_struct *swp)
 	swp->tier_mask = TIER_DEFAULT_MASK;
 }
 
-bool swap_tiers_update(void)
+/*
+ * When a tier is removed, set its bit in every memcg's tier_mask and
+ * tier_effective_mask. This prevents stale tier indices from being
+ * silently filtered out if the same index is reused later.
+ */
+static void swap_tier_memcg_propagate(int mask)
+{
+	struct mem_cgroup *child;
+
+	rcu_read_lock();
+	for_each_mem_cgroup_tree(child, root_mem_cgroup) {
+		child->tier_mask |= mask;
+		child->tier_effective_mask |= mask;
+	}
+	rcu_read_unlock();
+}
+
+bool swap_tiers_update(int mask)
 {
 	struct swap_tier *tier;
 	struct swap_info_struct *swp;
@@ -357,6 +375,77 @@ bool swap_tiers_update(void)
 			break;
 		swap_tiers_assign_dev(swp);
 	}
+	/*
+	 * XXX: Unused tiers default to ON, disabled after next tier added.
+	 * Use removed tier mask to clear settings for removed/re-added tiers.
+	 * (Could hold tier refs, but better to keep cgroup config independent)
+	 */
+	if (mask)
+		swap_tier_memcg_propagate(mask);
 
 	return true;
 }
+
+void swap_tiers_mask_show(struct seq_file *m, int mask)
+{
+	struct swap_tier *tier;
+
+	spin_lock(&swap_tier_lock);
+	for_each_active_tier(tier) {
+		if (mask & TIER_MASK(tier))
+			seq_printf(m, "%s ", tier->name);
+	}
+	spin_unlock(&swap_tier_lock);
+	seq_puts(m, "\n");
+}
+
+int swap_tiers_mask_lookup(const char *name)
+{
+	struct swap_tier *tier;
+
+	lockdep_assert_held(&swap_tier_lock);
+
+	for_each_active_tier(tier) {
+		if (!strcmp(name, tier->name))
+			return TIER_MASK(tier);
+	}
+
+	return 0;
+}
+
+static void __swap_tier_memcg_inherit_mask(struct mem_cgroup *memcg,
+	struct mem_cgroup *parent)
+{
+	int effective_mask
+		= parent ? parent->tier_effective_mask : TIER_ALL_MASK;
+
+	memcg->tier_effective_mask
+		= effective_mask & memcg->tier_mask;
+}
+
+/* Computes the initial effective mask from the parent's effective mask. */
+void swap_tiers_memcg_inherit_mask(struct mem_cgroup *memcg,
+	struct mem_cgroup *parent)
+{
+	spin_lock(&swap_tier_lock);
+	rcu_read_lock();
+	__swap_tier_memcg_inherit_mask(memcg, parent);
+	rcu_read_unlock();
+	spin_unlock(&swap_tier_lock);
+}
+
+/*
+ * Called when a memcg's tier_mask is modified. Walks the subtree
+ * and recomputes each descendant's effective mask against its parent.
+ */
+void swap_tiers_memcg_sync_mask(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *child;
+
+	lockdep_assert_held(&swap_tier_lock);
+
+	rcu_read_lock();
+	for_each_mem_cgroup_tree(child, memcg)
+		__swap_tier_memcg_inherit_mask(child, parent_mem_cgroup(child));
+	rcu_read_unlock();
+}
diff --git a/mm/swap_tier.h b/mm/swap_tier.h
index 6f281e95ed81..329c6a4f375f 100644
--- a/mm/swap_tier.h
+++ b/mm/swap_tier.h
@@ -10,21 +10,65 @@ struct swap_info_struct;
 
 extern spinlock_t swap_tier_lock;
 
-#define TIER_ALL_MASK		(~0)
-#define TIER_DEFAULT_IDX	(31)
-#define TIER_DEFAULT_MASK	(1 << TIER_DEFAULT_IDX)
-
 /* Initialization and application */
 void swap_tiers_init(void);
 ssize_t swap_tiers_sysfs_show(char *buf);
 
 int swap_tiers_add(const char *name, int prio);
-int swap_tiers_remove(const char *name);
+int swap_tiers_remove(const char *name, int *mask);
 
 void swap_tiers_snapshot(void);
 void swap_tiers_snapshot_restore(void);
-bool swap_tiers_update(void);
+bool swap_tiers_update(int mask);
 
 /* Tier assignment */
 void swap_tiers_assign_dev(struct swap_info_struct *swp);
+
+#ifdef CONFIG_SWAP
+/* Memcg related functions */
+void swap_tiers_mask_show(struct seq_file *m, int mask);
+void swap_tiers_memcg_inherit_mask(struct mem_cgroup *memcg,
+	struct mem_cgroup *parent);
+void swap_tiers_memcg_sync_mask(struct mem_cgroup *memcg);
+#else
+static inline void swap_tiers_mask_show(struct seq_file *m, int mask) {}
+static inline void swap_tiers_memcg_inherit_mask(struct mem_cgroup *memcg,
+	struct mem_cgroup *parent) {}
+static inline void swap_tiers_memcg_sync_mask(struct mem_cgroup *memcg) {}
+static inline void __swap_tiers_memcg_sync_mask(struct mem_cgroup *memcg) {}
+#endif
+
+/* Mask and tier lookup */
+int swap_tiers_mask_lookup(const char *name);
+
+/**
+ * swap_tiers_mask_test - Check if the tier mask is valid
+ * @tier_mask: The tier mask to check
+ * @mask: The mask to compare against
+ *
+ * Return: true if condition matches, false otherwise
+ */
+static inline bool swap_tiers_mask_test(int tier_mask, int mask)
+{
+	return tier_mask & mask;
+}
+
+#define TIER_ALL_MASK		(~0)
+#define TIER_DEFAULT_IDX	(31)
+#define TIER_DEFAULT_MASK	(1 << TIER_DEFAULT_IDX)
+
+#ifdef CONFIG_MEMCG
+static inline int folio_tier_effective_mask(struct folio *folio)
+{
+	struct mem_cgroup *memcg = folio_memcg(folio);
+
+	return memcg ? memcg->tier_effective_mask : TIER_ALL_MASK;
+}
+#else
+static inline int folio_tier_effective_mask(struct folio *folio)
+{
+	return TIER_ALL_MASK;
+}
+#endif
+
 #endif /* _SWAP_TIER_H */
-- 
2.34.1


