Return-Path: <cgroups+bounces-3409-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D6391AC07
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5131F2262D
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 15:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126D3199386;
	Thu, 27 Jun 2024 15:57:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3941991DB;
	Thu, 27 Jun 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503874; cv=none; b=IoDdkA/bSthxdPQjL/v5BDG+ZX3Hi6mrXVzTrt+cO0Mc4V/agVrKRTnPqL5GVWMHBueJDyMQtpiIjC5nCFAh2Xk+iwLbbYPhTz5QECCNH5Zlbihr5s1GaXofkyD5GqqdPUGasl4Lnr96Tx8rjDlRFQvjAYebhKMBZ6+S95VHzOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503874; c=relaxed/simple;
	bh=cFxSy8p+3j+7K1KC8ch9Qd/8WMxZjw7wEPWnaTiGF40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwN2vU7uvde++v0A+ZqQUTMONkrEiHdVFx+IEBRzg8y8iky+mjXv8lYLbippLo89o50T4BuD4BLvuYqdINk75AmT33wSOGf1QQM6jC35oQ1ycR34VUAV2i2uq3/Qj3kiINzHpmWreKZ/W2LbosRyS1L94obZutVMwM6xTM92Cic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [RFC PATCH 1/6] mm/page_counter: Move calculating protection values to page_counter
Date: Thu, 27 Jun 2024 17:47:20 +0200
Message-ID: <20240627154754.74828-2-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627154754.74828-1-maarten.lankhorst@linux.intel.com>
References: <20240627154754.74828-1-maarten.lankhorst@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's a lot of math, and there is nothing memcontrol specific about it.
This makes it easier to use inside of the drm cgroup controller.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 include/linux/page_counter.h |   4 +
 mm/memcontrol.c              | 154 +------------------------------
 mm/page_counter.c            | 173 +++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+), 151 deletions(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 8cd858d912c4..904c52f97284 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -81,4 +81,8 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 	counter->watermark = page_counter_read(counter);
 }
 
+void page_counter_calculate_protection(struct page_counter *root,
+				       struct page_counter *counter,
+				       bool recursive_protection);
+
 #endif /* _LINUX_PAGE_COUNTER_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 71fe2a95b8bd..9454e1a3120e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7316,122 +7316,6 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.early_init = 0,
 };
 
-/*
- * This function calculates an individual cgroup's effective
- * protection which is derived from its own memory.min/low, its
- * parent's and siblings' settings, as well as the actual memory
- * distribution in the tree.
- *
- * The following rules apply to the effective protection values:
- *
- * 1. At the first level of reclaim, effective protection is equal to
- *    the declared protection in memory.min and memory.low.
- *
- * 2. To enable safe delegation of the protection configuration, at
- *    subsequent levels the effective protection is capped to the
- *    parent's effective protection.
- *
- * 3. To make complex and dynamic subtrees easier to configure, the
- *    user is allowed to overcommit the declared protection at a given
- *    level. If that is the case, the parent's effective protection is
- *    distributed to the children in proportion to how much protection
- *    they have declared and how much of it they are utilizing.
- *
- *    This makes distribution proportional, but also work-conserving:
- *    if one cgroup claims much more protection than it uses memory,
- *    the unused remainder is available to its siblings.
- *
- * 4. Conversely, when the declared protection is undercommitted at a
- *    given level, the distribution of the larger parental protection
- *    budget is NOT proportional. A cgroup's protection from a sibling
- *    is capped to its own memory.min/low setting.
- *
- * 5. However, to allow protecting recursive subtrees from each other
- *    without having to declare each individual cgroup's fixed share
- *    of the ancestor's claim to protection, any unutilized -
- *    "floating" - protection from up the tree is distributed in
- *    proportion to each cgroup's *usage*. This makes the protection
- *    neutral wrt sibling cgroups and lets them compete freely over
- *    the shared parental protection budget, but it protects the
- *    subtree as a whole from neighboring subtrees.
- *
- * Note that 4. and 5. are not in conflict: 4. is about protecting
- * against immediate siblings whereas 5. is about protecting against
- * neighboring subtrees.
- */
-static unsigned long effective_protection(unsigned long usage,
-					  unsigned long parent_usage,
-					  unsigned long setting,
-					  unsigned long parent_effective,
-					  unsigned long siblings_protected)
-{
-	unsigned long protected;
-	unsigned long ep;
-
-	protected = min(usage, setting);
-	/*
-	 * If all cgroups at this level combined claim and use more
-	 * protection than what the parent affords them, distribute
-	 * shares in proportion to utilization.
-	 *
-	 * We are using actual utilization rather than the statically
-	 * claimed protection in order to be work-conserving: claimed
-	 * but unused protection is available to siblings that would
-	 * otherwise get a smaller chunk than what they claimed.
-	 */
-	if (siblings_protected > parent_effective)
-		return protected * parent_effective / siblings_protected;
-
-	/*
-	 * Ok, utilized protection of all children is within what the
-	 * parent affords them, so we know whatever this child claims
-	 * and utilizes is effectively protected.
-	 *
-	 * If there is unprotected usage beyond this value, reclaim
-	 * will apply pressure in proportion to that amount.
-	 *
-	 * If there is unutilized protection, the cgroup will be fully
-	 * shielded from reclaim, but we do return a smaller value for
-	 * protection than what the group could enjoy in theory. This
-	 * is okay. With the overcommit distribution above, effective
-	 * protection is always dependent on how memory is actually
-	 * consumed among the siblings anyway.
-	 */
-	ep = protected;
-
-	/*
-	 * If the children aren't claiming (all of) the protection
-	 * afforded to them by the parent, distribute the remainder in
-	 * proportion to the (unprotected) memory of each cgroup. That
-	 * way, cgroups that aren't explicitly prioritized wrt each
-	 * other compete freely over the allowance, but they are
-	 * collectively protected from neighboring trees.
-	 *
-	 * We're using unprotected memory for the weight so that if
-	 * some cgroups DO claim explicit protection, we don't protect
-	 * the same bytes twice.
-	 *
-	 * Check both usage and parent_usage against the respective
-	 * protected values. One should imply the other, but they
-	 * aren't read atomically - make sure the division is sane.
-	 */
-	if (!(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT))
-		return ep;
-	if (parent_effective > siblings_protected &&
-	    parent_usage > siblings_protected &&
-	    usage > protected) {
-		unsigned long unclaimed;
-
-		unclaimed = parent_effective - siblings_protected;
-		unclaimed *= usage - protected;
-		unclaimed /= parent_usage - siblings_protected;
-
-		ep += unclaimed;
-	}
-
-	return ep;
-}
-
 /**
  * mem_cgroup_calculate_protection - check if memory consumption is in the normal range
  * @root: the top ancestor of the sub-tree being checked
@@ -7443,8 +7327,8 @@ static unsigned long effective_protection(unsigned long usage,
 void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 				     struct mem_cgroup *memcg)
 {
-	unsigned long usage, parent_usage;
-	struct mem_cgroup *parent;
+	bool recursive_protection =
+		cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT;
 
 	if (mem_cgroup_disabled())
 		return;
@@ -7452,39 +7336,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 	if (!root)
 		root = root_mem_cgroup;
 
-	/*
-	 * Effective values of the reclaim targets are ignored so they
-	 * can be stale. Have a look at mem_cgroup_protection for more
-	 * details.
-	 * TODO: calculation should be more robust so that we do not need
-	 * that special casing.
-	 */
-	if (memcg == root)
-		return;
-
-	usage = page_counter_read(&memcg->memory);
-	if (!usage)
-		return;
-
-	parent = parent_mem_cgroup(memcg);
-
-	if (parent == root) {
-		memcg->memory.emin = READ_ONCE(memcg->memory.min);
-		memcg->memory.elow = READ_ONCE(memcg->memory.low);
-		return;
-	}
-
-	parent_usage = page_counter_read(&parent->memory);
-
-	WRITE_ONCE(memcg->memory.emin, effective_protection(usage, parent_usage,
-			READ_ONCE(memcg->memory.min),
-			READ_ONCE(parent->memory.emin),
-			atomic_long_read(&parent->memory.children_min_usage)));
-
-	WRITE_ONCE(memcg->memory.elow, effective_protection(usage, parent_usage,
-			READ_ONCE(memcg->memory.low),
-			READ_ONCE(parent->memory.elow),
-			atomic_long_read(&parent->memory.children_low_usage)));
+	page_counter_calculate_protection(&root->memory, &memcg->memory, recursive_protection);
 }
 
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
diff --git a/mm/page_counter.c b/mm/page_counter.c
index db20d6452b71..8ee49cbf71be 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -262,3 +262,176 @@ int page_counter_memparse(const char *buf, const char *max,
 
 	return 0;
 }
+
+
+/*
+ * This function calculates an individual page counter's effective
+ * protection which is derived from its own memory.min/low, its
+ * parent's and siblings' settings, as well as the actual memory
+ * distribution in the tree.
+ *
+ * The following rules apply to the effective protection values:
+ *
+ * 1. At the first level of reclaim, effective protection is equal to
+ *    the declared protection in memory.min and memory.low.
+ *
+ * 2. To enable safe delegation of the protection configuration, at
+ *    subsequent levels the effective protection is capped to the
+ *    parent's effective protection.
+ *
+ * 3. To make complex and dynamic subtrees easier to configure, the
+ *    user is allowed to overcommit the declared protection at a given
+ *    level. If that is the case, the parent's effective protection is
+ *    distributed to the children in proportion to how much protection
+ *    they have declared and how much of it they are utilizing.
+ *
+ *    This makes distribution proportional, but also work-conserving:
+ *    if one counter claims much more protection than it uses memory,
+ *    the unused remainder is available to its siblings.
+ *
+ * 4. Conversely, when the declared protection is undercommitted at a
+ *    given level, the distribution of the larger parental protection
+ *    budget is NOT proportional. A counter's protection from a sibling
+ *    is capped to its own memory.min/low setting.
+ *
+ * 5. However, to allow protecting recursive subtrees from each other
+ *    without having to declare each individual counter's fixed share
+ *    of the ancestor's claim to protection, any unutilized -
+ *    "floating" - protection from up the tree is distributed in
+ *    proportion to each counter's *usage*. This makes the protection
+ *    neutral wrt sibling cgroups and lets them compete freely over
+ *    the shared parental protection budget, but it protects the
+ *    subtree as a whole from neighboring subtrees.
+ *
+ * Note that 4. and 5. are not in conflict: 4. is about protecting
+ * against immediate siblings whereas 5. is about protecting against
+ * neighboring subtrees.
+ */
+static unsigned long effective_protection(unsigned long usage,
+					  unsigned long parent_usage,
+					  unsigned long setting,
+					  unsigned long parent_effective,
+					  unsigned long siblings_protected,
+					  bool recursive_protection)
+{
+	unsigned long protected;
+	unsigned long ep;
+
+	protected = min(usage, setting);
+	/*
+	 * If all cgroups at this level combined claim and use more
+	 * protection than what the parent affords them, distribute
+	 * shares in proportion to utilization.
+	 *
+	 * We are using actual utilization rather than the statically
+	 * claimed protection in order to be work-conserving: claimed
+	 * but unused protection is available to siblings that would
+	 * otherwise get a smaller chunk than what they claimed.
+	 */
+	if (siblings_protected > parent_effective)
+		return protected * parent_effective / siblings_protected;
+
+	/*
+	 * Ok, utilized protection of all children is within what the
+	 * parent affords them, so we know whatever this child claims
+	 * and utilizes is effectively protected.
+	 *
+	 * If there is unprotected usage beyond this value, reclaim
+	 * will apply pressure in proportion to that amount.
+	 *
+	 * If there is unutilized protection, the cgroup will be fully
+	 * shielded from reclaim, but we do return a smaller value for
+	 * protection than what the group could enjoy in theory. This
+	 * is okay. With the overcommit distribution above, effective
+	 * protection is always dependent on how memory is actually
+	 * consumed among the siblings anyway.
+	 */
+	ep = protected;
+
+	/*
+	 * If the children aren't claiming (all of) the protection
+	 * afforded to them by the parent, distribute the remainder in
+	 * proportion to the (unprotected) memory of each cgroup. That
+	 * way, cgroups that aren't explicitly prioritized wrt each
+	 * other compete freely over the allowance, but they are
+	 * collectively protected from neighboring trees.
+	 *
+	 * We're using unprotected memory for the weight so that if
+	 * some cgroups DO claim explicit protection, we don't protect
+	 * the same bytes twice.
+	 *
+	 * Check both usage and parent_usage against the respective
+	 * protected values. One should imply the other, but they
+	 * aren't read atomically - make sure the division is sane.
+	 */
+	if (!recursive_protection)
+		return ep;
+
+	if (parent_effective > siblings_protected &&
+	    parent_usage > siblings_protected &&
+	    usage > protected) {
+		unsigned long unclaimed;
+
+		unclaimed = parent_effective - siblings_protected;
+		unclaimed *= usage - protected;
+		unclaimed /= parent_usage - siblings_protected;
+
+		ep += unclaimed;
+	}
+
+	return ep;
+}
+
+
+/**
+ * page_counter_calculate_protection - check if memory consumption is in the normal range
+ * @root: the top ancestor of the sub-tree being checked
+ * @memcg: the memory cgroup to check
+ * @recursive_protection: Whether to use memory_recursiveprot behavior.
+ *
+ * Calculates elow/emin thresholds for given page_counter.
+ *
+ * WARNING: This function is not stateless! It can only be used as part
+ *          of a top-down tree iteration, not for isolated queries.
+ */
+void page_counter_calculate_protection(struct page_counter *root,
+				       struct page_counter *counter,
+				       bool recursive_protection)
+{
+	unsigned long usage, parent_usage;
+	struct page_counter *parent = counter->parent;
+
+	/*
+	 * Effective values of the reclaim targets are ignored so they
+	 * can be stale. Have a look at mem_cgroup_protection for more
+	 * details.
+	 * TODO: calculation should be more robust so that we do not need
+	 * that special casing.
+	 */
+	if (root == counter)
+		return;
+
+	usage = page_counter_read(counter);
+	if (!usage)
+		return;
+
+	if (parent == root) {
+		counter->emin = READ_ONCE(counter->min);
+		counter->elow = READ_ONCE(counter->low);
+		return;
+	}
+
+	parent_usage = page_counter_read(parent);
+
+	WRITE_ONCE(counter->emin, effective_protection(usage, parent_usage,
+			READ_ONCE(counter->min),
+			READ_ONCE(parent->emin),
+			atomic_long_read(&parent->children_min_usage),
+			recursive_protection));
+
+	WRITE_ONCE(counter->elow, effective_protection(usage, parent_usage,
+			READ_ONCE(counter->low),
+			READ_ONCE(parent->elow),
+			atomic_long_read(&parent->children_low_usage),
+			recursive_protection));
+}
-- 
2.45.2


