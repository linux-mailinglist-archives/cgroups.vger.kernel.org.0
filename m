Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1553126E6A
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2019 21:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfLSUHm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Dec 2019 15:07:42 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39998 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfLSUHd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Dec 2019 15:07:33 -0500
Received: by mail-qv1-f65.google.com with SMTP id dp13so2737631qvb.7
        for <cgroups@vger.kernel.org>; Thu, 19 Dec 2019 12:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xhnsM6+i6PGg0LZOZdtt3M5JWJhYXNMihWGbHtyPi9Y=;
        b=VgFrbe7VG7KwWLfV/nS4/zUzfwC7Pf536oWSgQ2AOxOsw4Dnj5j8ToIT7+Ot3O5QBp
         WflITjv4O6Piy4b/Q0LskNKxVwFLGnGJTzZeqgzCm/2F6+kQVY7Q6eBGZK/cVmrPufXs
         0/+ajn551IAgPhIIdMmMsjwv27wiwum2iJ+3jmiK0y2+7HNvxYj7NfwOvljQR7wzzU7A
         hGXL6fIt10IPRcF9uQLzMHPRysEoj3Gw5iMgQvahBunEZ+3aBAIgTNMXYMV7iE+UnLob
         k9sVJ+DqTCk1fSNDf4PwOf0kd0gQqypMQ2J3+m4KoOVA4GoG6eRdwqywxCHRJkYyE3zR
         uncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhnsM6+i6PGg0LZOZdtt3M5JWJhYXNMihWGbHtyPi9Y=;
        b=cYRkPIJsQ8Fw/uUCeaAAgqt0f13GjLLIooYvdXFsqp/IZp+IBYaWe4YPlYVqjkK1kL
         gX+7R76KA4tbUOhTc7LFhL8iIW/t4iWs3W/R89qJzRNK30KHsymMj6Qb727tAYzc6ln1
         JcEIY/+W9/oMH5hRBUtBet3DwQrOgYG4UVNQ6+o/t85xTHKik1Obz/NlpW7PmrP92RA/
         8qsuHZ9qaHpOmdFImfpjs6LcxvDiOWOFuGhT8bqweuP0GUjuYIyHP5hTMwNO0dpNu5AL
         7tlPCPn1n888m6Uu3J3TOyJTfY39NtxGfSkG+E0PzKSBMU+bXb8LGXbqgX+f0sUI8S83
         9Viw==
X-Gm-Message-State: APjAAAVvDDqhJMtQZHPJVWcBnmZqjTxRG+4cIyZFhKMlw707VrNXB26l
        ABFMMHYqh69r/vtNP9tGpFRPvsHm70A=
X-Google-Smtp-Source: APXvYqy1UVff1aZ5RFPZegwEqyTij6y3NZCbSDY/zf2WLMRfiNtWiKbMGDTy4jfMU7SUnRkyvxEYPw==
X-Received: by 2002:a0c:cdc4:: with SMTP id a4mr9500900qvn.21.1576786051943;
        Thu, 19 Dec 2019 12:07:31 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::91a1])
        by smtp.gmail.com with ESMTPSA id g21sm1995500qkl.116.2019.12.19.12.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:07:31 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 2/3] mm: memcontrol: clean up and document effective low/min calculations
Date:   Thu, 19 Dec 2019 15:07:17 -0500
Message-Id: <20191219200718.15696-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219200718.15696-1-hannes@cmpxchg.org>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The effective protection of any given cgroup is a somewhat complicated
construct that depends on the ancestor's configuration, siblings'
configurations, as well as current memory utilization in all these
groups. It's done this way to satisfy hierarchical delegation
requirements while also making the configuration semantics flexible
and expressive in complex real life scenarios.

Unfortunately, all the rules and requirements are sparsely documented,
and the code is a little too clever in merging different scenarios
into a single min() expression. This makes it hard to reason about the
implementation and avoid breaking semantics when making changes to it.

This patch documents each semantic rule individually and splits out
the handling of the overcommit case from the regular case.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 190 ++++++++++++++++++++++++++----------------------
 1 file changed, 104 insertions(+), 86 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 874a0b00f89b..9c771c4d6339 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6204,65 +6204,55 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.early_init = 0,
 };
 
-/**
- * mem_cgroup_protected - check if memory consumption is in the normal range
- * @root: the top ancestor of the sub-tree being checked
- * @memcg: the memory cgroup to check
- *
- * WARNING: This function is not stateless! It can only be used as part
- *          of a top-down tree iteration, not for isolated queries.
- *
- * Returns one of the following:
- *   MEMCG_PROT_NONE: cgroup memory is not protected
- *   MEMCG_PROT_LOW: cgroup memory is protected as long there is
- *     an unprotected supply of reclaimable memory from other cgroups.
- *   MEMCG_PROT_MIN: cgroup memory is protected
- *
- * @root is exclusive; it is never protected when looked at directly
+/*
+ * This function calculates an individual cgroup's effective
+ * protection which is derived from its own memory.min/low, its
+ * parent's and siblings' settings, as well as the actual memory
+ * distribution in the tree.
  *
- * To provide a proper hierarchical behavior, effective memory.min/low values
- * are used. Below is the description of how effective memory.low is calculated.
- * Effective memory.min values is calculated in the same way.
+ * The following rules apply to the effective protection values:
  *
- * Effective memory.low is always equal or less than the original memory.low.
- * If there is no memory.low overcommittment (which is always true for
- * top-level memory cgroups), these two values are equal.
- * Otherwise, it's a part of parent's effective memory.low,
- * calculated as a cgroup's memory.low usage divided by sum of sibling's
- * memory.low usages, where memory.low usage is the size of actually
- * protected memory.
+ * 1. At the first level of reclaim, effective protection is equal to
+ *    the declared protection in memory.min and memory.low.
  *
- *                                             low_usage
- * elow = min( memory.low, parent->elow * ------------------ ),
- *                                        siblings_low_usage
+ * 2. To enable safe delegation of the protection configuration, at
+ *    subsequent levels the effective protection is capped to the
+ *    parent's effective protection.
  *
- * low_usage = min(memory.low, memory.current)
+ * 3. To make complex and dynamic subtrees easier to configure, the
+ *    user is allowed to overcommit the declared protection at a given
+ *    level. If that is the case, the parent's effective protection is
+ *    distributed to the children in proportion to how much protection
+ *    they have declared and how much of it they are utilizing.
  *
+ *    This makes distribution proportional, but also work-conserving:
+ *    if one cgroup claims much more protection than it uses memory,
+ *    the unused remainder is available to its siblings.
  *
- * Such definition of the effective memory.low provides the expected
- * hierarchical behavior: parent's memory.low value is limiting
- * children, unprotected memory is reclaimed first and cgroups,
- * which are not using their guarantee do not affect actual memory
- * distribution.
+ *    Consider the following example tree:
  *
- * For example, if there are memcgs A, A/B, A/C, A/D and A/E:
+ *        A      A/memory.low = 2G, A/memory.current = 6G
+ *       //\\
+ *      BC  DE   B/memory.low = 3G  B/memory.current = 2G
+ *               C/memory.low = 1G  C/memory.current = 2G
+ *               D/memory.low = 0   D/memory.current = 2G
+ *               E/memory.low = 10G E/memory.current = 0
  *
- *     A      A/memory.low = 2G, A/memory.current = 6G
- *    //\\
- *   BC  DE   B/memory.low = 3G  B/memory.current = 2G
- *            C/memory.low = 1G  C/memory.current = 2G
- *            D/memory.low = 0   D/memory.current = 2G
- *            E/memory.low = 10G E/memory.current = 0
+ *    and memory pressure is applied, the following memory
+ *    distribution is expected (approximately*):
  *
- * and the memory pressure is applied, the following memory distribution
- * is expected (approximately):
+ *      A/memory.current = 2G
+ *      B/memory.current = 1.3G
+ *      C/memory.current = 0.6G
+ *      D/memory.current = 0
+ *      E/memory.current = 0
  *
- *     A/memory.current = 2G
+ *    *assuming equal allocation rate and reclaimability
  *
- *     B/memory.current = 1.3G
- *     C/memory.current = 0.6G
- *     D/memory.current = 0
- *     E/memory.current = 0
+ * 4. Conversely, when the declared protection is undercommitted at a
+ *    given level, the distribution of the larger parental protection
+ *    budget is NOT proportional. A cgroup's protection from a sibling
+ *    is capped to its own memory.min/low setting.
  *
  * These calculations require constant tracking of the actual low usages
  * (see propagate_protected_usage()), as well as recursive calculation of
@@ -6272,12 +6262,63 @@ struct cgroup_subsys memory_cgrp_subsys = {
  * for next usage. This part is intentionally racy, but it's ok,
  * as memory.low is a best-effort mechanism.
  */
+static unsigned long effective_protection(unsigned long usage,
+					  unsigned long setting,
+					  unsigned long parent_effective,
+					  unsigned long siblings_protected)
+{
+	unsigned long protected;
+
+	protected = min(usage, setting);
+	/*
+	 * If all cgroups at this level combined claim and use more
+	 * protection then what the parent affords them, distribute
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
+	return protected;
+}
+
+/**
+ * mem_cgroup_protected - check if memory consumption is in the normal range
+ * @root: the top ancestor of the sub-tree being checked
+ * @memcg: the memory cgroup to check
+ *
+ * WARNING: This function is not stateless! It can only be used as part
+ *          of a top-down tree iteration, not for isolated queries.
+ *
+ * Returns one of the following:
+ *   MEMCG_PROT_NONE: cgroup memory is not protected
+ *   MEMCG_PROT_LOW: cgroup memory is protected as long there is
+ *     an unprotected supply of reclaimable memory from other cgroups.
+ *   MEMCG_PROT_MIN: cgroup memory is protected
+ */
 enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 						struct mem_cgroup *memcg)
 {
 	struct mem_cgroup *parent;
-	unsigned long emin, parent_emin;
-	unsigned long elow, parent_elow;
 	unsigned long usage;
 
 	if (mem_cgroup_disabled())
@@ -6292,52 +6333,29 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	if (!usage)
 		return MEMCG_PROT_NONE;
 
-	emin = memcg->memory.min;
-	elow = memcg->memory.low;
-
 	parent = parent_mem_cgroup(memcg);
 	/* No parent means a non-hierarchical mode on v1 memcg */
 	if (!parent)
 		return MEMCG_PROT_NONE;
 
-	if (parent == root)
-		goto exit;
-
-	parent_emin = READ_ONCE(parent->memory.emin);
-	emin = min(emin, parent_emin);
-	if (emin && parent_emin) {
-		unsigned long min_usage, siblings_min_usage;
-
-		min_usage = min(usage, memcg->memory.min);
-		siblings_min_usage = atomic_long_read(
-			&parent->memory.children_min_usage);
-
-		if (min_usage && siblings_min_usage)
-			emin = min(emin, parent_emin * min_usage /
-				   siblings_min_usage);
+	if (parent == root) {
+		memcg->memory.emin = memcg->memory.min;
+		memcg->memory.elow = memcg->memory.low;
+		goto out;
 	}
 
-	parent_elow = READ_ONCE(parent->memory.elow);
-	elow = min(elow, parent_elow);
-	if (elow && parent_elow) {
-		unsigned long low_usage, siblings_low_usage;
-
-		low_usage = min(usage, memcg->memory.low);
-		siblings_low_usage = atomic_long_read(
-			&parent->memory.children_low_usage);
+	memcg->memory.emin = effective_protection(usage,
+			memcg->memory.min, READ_ONCE(parent->memory.emin),
+			atomic_long_read(&parent->memory.children_min_usage));
 
-		if (low_usage && siblings_low_usage)
-			elow = min(elow, parent_elow * low_usage /
-				   siblings_low_usage);
-	}
-
-exit:
-	memcg->memory.emin = emin;
-	memcg->memory.elow = elow;
+	memcg->memory.elow = effective_protection(usage,
+			memcg->memory.low, READ_ONCE(parent->memory.elow),
+			atomic_long_read(&parent->memory.children_low_usage));
 
-	if (usage <= emin)
+out:
+	if (usage <= memcg->memory.emin)
 		return MEMCG_PROT_MIN;
-	else if (usage <= elow)
+	else if (usage <= memcg->memory.elow)
 		return MEMCG_PROT_LOW;
 	else
 		return MEMCG_PROT_NONE;
-- 
2.24.1

