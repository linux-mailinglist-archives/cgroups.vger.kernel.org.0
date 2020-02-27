Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC37172905
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2020 20:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgB0T4Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Feb 2020 14:56:16 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37862 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbgB0T4Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Feb 2020 14:56:16 -0500
Received: by mail-qk1-f194.google.com with SMTP id m9so655799qke.4
        for <cgroups@vger.kernel.org>; Thu, 27 Feb 2020 11:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDjWpH6grOtzg9jRElfS3afP9Xx2wYz4tow/cIPwfsc=;
        b=GtZ5uMsWMd0OMOb6SUGkO7O7QOsQlQ2mg1L95hluFzKdMMLVIVxeBRjFb8F4ekY6L7
         hVVHDzVeb+davTH5VCuhL/S5/vyR9rGlbZ2lxozVr2eibCvgyB0/8N0LBkp6p3njyCbZ
         TpwBdF0uJ7pwBd9bBqns/9B2UrTm3nWPDYxwX/urJ12eHqGk/TDNKwyauQpqzmZxzpkT
         9/aXGKfJBvTY18ut5BORUiVgRYls+okYGQRe5Xxtt2mBmwmMoeYzeLbduzMDUN78zJb2
         dxhteMd7aK8qHaMmCadWzEm8hvaDK8Z63EtOXJMI+RFbiYpU5EpN60n01BPGArtq0kll
         YbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDjWpH6grOtzg9jRElfS3afP9Xx2wYz4tow/cIPwfsc=;
        b=AJ7VBO/oSMVS6TZcbi9/FB57SYHVwE/3AVA2hqu7NSiW9XTHzguplLDCXa4hHoVMtv
         N7EtwVSu3I6wMij8DlV/DatBBOLo4AkHpz2vLN737pR3uVqd0hFrXl3AWai03WYFjPBp
         6mv+fCvvthnDbNWm+Kp9Vl8luQveBkhWZFM+mriVlfXQyNT0G/uxZkPRUbf1gBJyo+Nu
         L6WBlBRzpiN3gkflA63kRrReEnCYRlDgLgHjauHKjDlNT4N4DHVCpcr3ULh1LiwKgte5
         A+Qt0DzdMRCxkZmMq28W5PyCYqcGsa7tKhLCWWdPBBr8N3yK7KJGXUP2/EWw72bnZEBT
         RZ1g==
X-Gm-Message-State: APjAAAXIHxir4MU8+1l2JFyIpZQwpK0ZOqJuOTZ4pNua4f1yD93DOhSq
        TwXjDuJbe/evE152AZoJSJ26WFtvO1o=
X-Google-Smtp-Source: APXvYqx6zjvhh+3GLc16k1NmRrYkE58F4RCrqVSvjq4hkwz43RZngjuTejLCpp/ODPjN86zwbc+GeQ==
X-Received: by 2002:a05:620a:2093:: with SMTP id e19mr1054066qka.355.1582833374935;
        Thu, 27 Feb 2020 11:56:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:2450])
        by smtp.gmail.com with ESMTPSA id u23sm1542073qtk.16.2020.02.27.11.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:56:14 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] mm: memcontrol: clean up and document effective low/min calculations
Date:   Thu, 27 Feb 2020 14:56:05 -0500
Message-Id: <20200227195606.46212-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227195606.46212-1-hannes@cmpxchg.org>
References: <20200227195606.46212-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Michal Koutný also points out that the points of equilibrium as
described in the existing example scenarios aren't actually
accurate. Delete these examples for now to avoid confusion.

Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Chris Down <chris@chrisdown.name>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 175 +++++++++++++++++++++++-------------------------
 1 file changed, 83 insertions(+), 92 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 874a0b00f89b..836c521bd61f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6204,6 +6204,76 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.early_init = 0,
 };
 
+/*
+ * This function calculates an individual cgroup's effective
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
+ *    if one cgroup claims much more protection than it uses memory,
+ *    the unused remainder is available to its siblings.
+ *
+ * 4. Conversely, when the declared protection is undercommitted at a
+ *    given level, the distribution of the larger parental protection
+ *    budget is NOT proportional. A cgroup's protection from a sibling
+ *    is capped to its own memory.min/low setting.
+ *
+ */
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
 /**
  * mem_cgroup_protected - check if memory consumption is in the normal range
  * @root: the top ancestor of the sub-tree being checked
@@ -6217,67 +6287,11 @@ struct cgroup_subsys memory_cgrp_subsys = {
  *   MEMCG_PROT_LOW: cgroup memory is protected as long there is
  *     an unprotected supply of reclaimable memory from other cgroups.
  *   MEMCG_PROT_MIN: cgroup memory is protected
- *
- * @root is exclusive; it is never protected when looked at directly
- *
- * To provide a proper hierarchical behavior, effective memory.min/low values
- * are used. Below is the description of how effective memory.low is calculated.
- * Effective memory.min values is calculated in the same way.
- *
- * Effective memory.low is always equal or less than the original memory.low.
- * If there is no memory.low overcommittment (which is always true for
- * top-level memory cgroups), these two values are equal.
- * Otherwise, it's a part of parent's effective memory.low,
- * calculated as a cgroup's memory.low usage divided by sum of sibling's
- * memory.low usages, where memory.low usage is the size of actually
- * protected memory.
- *
- *                                             low_usage
- * elow = min( memory.low, parent->elow * ------------------ ),
- *                                        siblings_low_usage
- *
- * low_usage = min(memory.low, memory.current)
- *
- *
- * Such definition of the effective memory.low provides the expected
- * hierarchical behavior: parent's memory.low value is limiting
- * children, unprotected memory is reclaimed first and cgroups,
- * which are not using their guarantee do not affect actual memory
- * distribution.
- *
- * For example, if there are memcgs A, A/B, A/C, A/D and A/E:
- *
- *     A      A/memory.low = 2G, A/memory.current = 6G
- *    //\\
- *   BC  DE   B/memory.low = 3G  B/memory.current = 2G
- *            C/memory.low = 1G  C/memory.current = 2G
- *            D/memory.low = 0   D/memory.current = 2G
- *            E/memory.low = 10G E/memory.current = 0
- *
- * and the memory pressure is applied, the following memory distribution
- * is expected (approximately):
- *
- *     A/memory.current = 2G
- *
- *     B/memory.current = 1.3G
- *     C/memory.current = 0.6G
- *     D/memory.current = 0
- *     E/memory.current = 0
- *
- * These calculations require constant tracking of the actual low usages
- * (see propagate_protected_usage()), as well as recursive calculation of
- * effective memory.low values. But as we do call mem_cgroup_protected()
- * path for each memory cgroup top-down from the reclaim,
- * it's possible to optimize this part, and save calculated elow
- * for next usage. This part is intentionally racy, but it's ok,
- * as memory.low is a best-effort mechanism.
  */
 enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 						struct mem_cgroup *memcg)
 {
 	struct mem_cgroup *parent;
-	unsigned long emin, parent_emin;
-	unsigned long elow, parent_elow;
 	unsigned long usage;
 
 	if (mem_cgroup_disabled())
@@ -6292,52 +6306,29 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
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
+	memcg->memory.elow = effective_protection(usage,
+			memcg->memory.low, READ_ONCE(parent->memory.elow),
+			atomic_long_read(&parent->memory.children_low_usage));
 
-exit:
-	memcg->memory.emin = emin;
-	memcg->memory.elow = elow;
-
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

