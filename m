Return-Path: <cgroups+bounces-13571-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EAjKDP8fWkmUwIAu9opvQ
	(envelope-from <cgroups+bounces-13571-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 13:57:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15515C1D9E
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 13:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A61030292EE
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 12:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77711279336;
	Sat, 31 Jan 2026 12:56:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8325A640
	for <cgroups@vger.kernel.org>; Sat, 31 Jan 2026 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769864180; cv=none; b=B/yEfTBECtmQk4BuTYsEJkBCTSL7qusXqfojAovb6mV0aZjGgTPAqI31PGN82bkMVFDGcgE4mzAGqi0wImG8BO6T45B9E5sfvrJrIwiS1M0jwbliQ+/0E+N+HfcjPl/pDFZkJ9mCSnsu/kJ4Xf9GbcNP1SknB4Cf4wvTNOVBP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769864180; c=relaxed/simple;
	bh=aYFBQp/xBdjvMhL6Oe09UjWrgOAst8Z/rG7MbY5eIyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pVOtZmKryrcrxcKnRTnHH7xNMyNzEomyVtv62fVIumwMBCN5t+EzCMcCx/yu/N6xOFE0UPhiDC6FL8LN/Xu4qSeLE3WHFODJLyOBDVtrbjcbZnK+cQ2bUTFtU7DTJtN78Y1uF6xkUPtik4rwS1gJ/zSAGyQxYNtPFGABsu/ZKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 31 Jan 2026 21:56:08 +0900
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
Subject: [RFC PATCH v3 3/5] mm: memcontrol: add interface for swap tier selection
Date: Sat, 31 Jan 2026 21:54:52 +0900
Message-Id: <20260131125454.3187546-4-youngjun.park@lge.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13571-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,vger.kernel.org,kvack.org,lge.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lge.com:mid,lge.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,swap.events:url]
X-Rspamd-Queue-Id: 15515C1D9E
X-Rspamd-Action: no action

This patch integrates the swap tier infrastructure with cgroup,
enabling the selection of specific swap devices per cgroup by
configuring allowed swap tiers.

The new `memory.swap.tiers` interface controls allowed swap tiers via a mask.
By default, the mask is set to include all tiers, allowing specific tiers to
be excluded or restored. Note that effective tiers are calculated separately
using a dedicated mask to respect the cgroup hierarchy. Consequently,
configured tiers may differ from effective ones, as they must be a subset
of the parent's.

Note that cgroups do not pin swap tiers. This is similar to the
`cpuset` controller, which does not prevent CPU hotplug. This
approach ensures flexibility by allowing tier configuration changes
regardless of cgroup usage.

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 27 ++++++++
 include/linux/memcontrol.h              |  3 +-
 mm/memcontrol.c                         | 85 +++++++++++++++++++++++
 mm/swap_state.c                         |  6 +-
 mm/swap_tier.c                          | 89 ++++++++++++++++++++++++-
 mm/swap_tier.h                          | 39 ++++++++++-
 mm/swapfile.c                           |  4 ++
 7 files changed, 246 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 7f5b59d95fce..776a908ce1b9 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1848,6 +1848,33 @@ The following nested keys are defined.
 	Swap usage hard limit.  If a cgroup's swap usage reaches this
 	limit, anonymous memory of the cgroup will not be swapped out.
 
+  memory.swap.tiers
+        A read-write nested-keyed file which exists on non-root
+        cgroups. The default is to enable all tiers.
+
+        This interface allows selecting which swap tiers a cgroup can
+        use for swapping out memory.
+
+        The effective tiers are inherited from the parent. Only tiers
+        effective in the parent can be effective in the child. However,
+        the child can explicitly disable tiers allowed by the parent.
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
+          +    Enable this tier
+          -    Disable this tier
+
   memory.swap.events
 	A read-only flat-keyed file which exists on non-root cgroups.
 	The following entries are defined.  Unless specified
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b6c82c8f73e1..542bee1b5f60 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -283,7 +283,8 @@ struct mem_cgroup {
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
index 007413a53b45..5fcf8ebe0ca8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -68,6 +68,7 @@
 #include <net/ip.h>
 #include "slab.h"
 #include "memcontrol-v1.h"
+#include "swap_tier.h"
 
 #include <linux/uaccess.h>
 
@@ -3691,6 +3692,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
 	lru_gen_exit_memcg(memcg);
 	memcg_wb_domain_exit(memcg);
+	swap_tiers_memcg_sync_mask(memcg);
 	__mem_cgroup_free(memcg);
 }
 
@@ -3792,6 +3794,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	WRITE_ONCE(memcg->zswap_writeback, true);
 #endif
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
+	memcg->tier_mask = TIER_ALL_MASK;
+	swap_tiers_memcg_inherit_mask(memcg, parent);
+
 	if (parent) {
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
 
@@ -5352,6 +5357,80 @@ static int swap_events_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int swap_tier_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	swap_tiers_mask_show(m, memcg->tier_mask);
+	swap_tiers_mask_show(m, memcg->tier_effective_mask);
+
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
+	__swap_tiers_memcg_sync_mask(memcg);
+err:
+	if (ret)
+		memcg->tier_mask = original_mask;
+	spin_unlock(&swap_tier_lock);
+	return ret ? ret : nbytes;
+}
+
 static struct cftype swap_files[] = {
 	{
 		.name = "swap.current",
@@ -5384,6 +5463,12 @@ static struct cftype swap_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
 		.seq_show = swap_events_show,
 	},
+	{
+		.name = "swap.tiers",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_tier_show,
+		.write = swap_tier_write,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index d46ca61d2e42..c0dcab74779d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -961,6 +961,8 @@ static ssize_t tiers_store(struct kobject *kobj,
 	char *p, *token, *name, *tmp;
 	int ret = 0;
 	short prio;
+	int mask = 0;
+
 	DEFINE_SWAP_TIER_SAVE_CTX(ctx);
 
 	tmp = kstrdup(buf, GFP_KERNEL);
@@ -978,7 +980,7 @@ static ssize_t tiers_store(struct kobject *kobj,
 			continue;
 
 		if (token[0] == '-') {
-			ret = swap_tiers_remove(token + 1);
+			ret = swap_tiers_remove(token + 1, &mask);
 		} else {
 
 			name = strsep(&token, ":");
@@ -997,7 +999,7 @@ static ssize_t tiers_store(struct kobject *kobj,
 			goto restore;
 	}
 
-	if (!swap_tiers_update()) {
+	if (!swap_tiers_update(mask)) {
 		ret = -EINVAL;
 		goto restore;
 	}
diff --git a/mm/swap_tier.c b/mm/swap_tier.c
index 7741214312c7..0e067ba545cb 100644
--- a/mm/swap_tier.c
+++ b/mm/swap_tier.c
@@ -232,7 +232,7 @@ int swap_tiers_add(const char *name, int prio)
 	return ret;
 }
 
-int swap_tiers_remove(const char *name)
+int swap_tiers_remove(const char *name, int *mask)
 {
 	int ret = 0;
 	struct swap_tier *tier;
@@ -255,6 +255,8 @@ int swap_tiers_remove(const char *name)
 		list_prev_entry(tier, list)->prio = DEF_SWAP_PRIO;
 
 	list_move(&tier->list, &swap_tier_inactive_list);
+	*mask |= TIER_MASK(tier);
+
 	return ret;
 }
 
@@ -351,7 +353,17 @@ void swap_tiers_assign_dev(struct swap_info_struct *swp)
 	swp->tier_mask = TIER_DEFAULT_MASK;
 }
 
-bool swap_tiers_update(void)
+static void swap_tier_memcg_propagate(int mask)
+{
+	struct mem_cgroup *child;
+
+	for_each_mem_cgroup_tree(child, root_mem_cgroup) {
+		child->tier_mask |= mask;
+		child->tier_effective_mask |= mask;
+	}
+}
+
+bool swap_tiers_update(int mask)
 {
 	struct swap_tier *tier;
 	struct swap_info_struct *swp;
@@ -379,6 +391,79 @@ bool swap_tiers_update(void)
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
+void swap_tiers_memcg_inherit_mask(struct mem_cgroup *memcg,
+	struct mem_cgroup *parent)
+{
+	spin_lock(&swap_tier_lock);
+	__swap_tier_memcg_inherit_mask(memcg, parent);
+	spin_unlock(&swap_tier_lock);
+}
+
+void __swap_tiers_memcg_sync_mask(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *child;
+
+	lockdep_assert_held(&swap_tier_lock);
+
+	if (memcg == root_mem_cgroup)
+		return;
+
+	for_each_mem_cgroup_tree(child, memcg)
+		__swap_tier_memcg_inherit_mask(child, parent_mem_cgroup(child));
+}
+
+void swap_tiers_memcg_sync_mask(struct mem_cgroup *memcg)
+{
+	spin_lock(&swap_tier_lock);
+	memcg->tier_mask = TIER_ALL_MASK;
+	__swap_tiers_memcg_sync_mask(memcg);
+	spin_unlock(&swap_tier_lock);
+}
diff --git a/mm/swap_tier.h b/mm/swap_tier.h
index de81d540e3b5..9024c82c807a 100644
--- a/mm/swap_tier.h
+++ b/mm/swap_tier.h
@@ -31,19 +31,54 @@ struct swap_tier_save_ctx {
 #define TIER_DEFAULT_IDX	(31)
 #define TIER_DEFAULT_MASK	(1 << TIER_DEFAULT_IDX)
 
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
 /* Initialization and application */
 void swap_tiers_init(void);
 ssize_t swap_tiers_sysfs_show(char *buf);
 
 int swap_tiers_add(const char *name, int prio);
-int swap_tiers_remove(const char *name);
+int swap_tiers_remove(const char *name, int *mask);
 int swap_tiers_modify(const char *name, int prio);
 
 void swap_tiers_save(struct swap_tier_save_ctx ctx[]);
 void swap_tiers_restore(struct swap_tier_save_ctx ctx[]);
-bool swap_tiers_update(void);
+bool swap_tiers_update(int mask);
 
 /* Tier assignment */
 void swap_tiers_assign_dev(struct swap_info_struct *swp);
 
+/* Memcg related functions */
+void swap_tiers_mask_show(struct seq_file *m, int mask);
+void swap_tiers_memcg_inherit_mask(struct mem_cgroup *memcg,
+	struct mem_cgroup *parent);
+void swap_tiers_memcg_sync_mask(struct mem_cgroup *memcg);
+void __swap_tiers_memcg_sync_mask(struct mem_cgroup *memcg);
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
 #endif /* _SWAP_TIER_H */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4f8ce021c5bd..e04811e10431 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1348,10 +1348,14 @@ static bool swap_alloc_fast(struct folio *folio)
 static void swap_alloc_slow(struct folio *folio)
 {
 	struct swap_info_struct *si, *next;
+	int mask = folio_tier_effective_mask(folio);
 
 	spin_lock(&swap_avail_lock);
 start_over:
 	plist_for_each_entry_safe(si, next, &swap_avail_head, avail_list) {
+		if (!swap_tiers_mask_test(si->tier_mask, mask))
+			continue;
+
 		/* Rotate the device and switch to a new cluster */
 		plist_requeue(&si->avail_list, &swap_avail_head);
 		spin_unlock(&swap_avail_lock);
-- 
2.34.1


