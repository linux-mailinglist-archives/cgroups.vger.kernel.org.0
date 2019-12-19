Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC0A126E66
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2019 21:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfLSUHf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Dec 2019 15:07:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45056 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfLSUHf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Dec 2019 15:07:35 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so5668195qkl.12
        for <cgroups@vger.kernel.org>; Thu, 19 Dec 2019 12:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=naDrDkzQetnvNjvL9C0fTIA+vJoKEu+DEBxfjm27VzU=;
        b=hrP75sKPSn7AnGNw4tHGUMMvbkb/xjE1utAHCrHPx1Is0h8Vu2oO0MGlONZxCYPXRb
         RJvYrFKtWacv4ltAP810jwGutftiWKjDsXbXTaG4Gziahu+8YMY6qpVjyYntQ7it2m82
         n3nKx7pKxTvyNpFJurHPlWB5wJkz/+uBnn/jV12AXkK/+eip37LVSmRNLe+VnMLUg4iv
         BpuPih6Dop9c67g6dSdQWhVOGtbdi9SLXJv+HeUY8madZr7a2CRNYp/ha87+/V1cZz2i
         HB0sJmRNMwmBvwdQ/u6uIQ00lHiJPg8kCWh3yrC8GU6FDGHVgJhCepOoKuYynRxaF+Yg
         GV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=naDrDkzQetnvNjvL9C0fTIA+vJoKEu+DEBxfjm27VzU=;
        b=ZqDv66Aloe8qzchpsX+CtV6uQ3Ml0EaNg7mtSqudANbtw+lRlkpPlBpdRWohatLrUt
         vtSAPTJiujQ8WFhrwodv/nkGG8InYG2E66nEwScM1TM9hToLBsa5JWS72KLxMwbg622N
         oE5kJiQPFz4y+If0MJVnTddmvdyia1N8dI4IdJcMim20Mt9qxJVpjPV9Exgb3tsPg8a6
         uo7PWr0SiukI/4bPWzfkSE0UQXz1h8ABEQR6O1230qx+WG4y8bx7SDLAXiyCsq8DFkU0
         fY19uIDQ/oj4B22uq3g9GwCRt0TnoRlmjrCvymw0HLa1WmCmi/V/fHD0iV/XBtK1JMV+
         cesw==
X-Gm-Message-State: APjAAAVtNgUjaB/mMGXyIktr7WCGUJdJpmneCCONZ6ogyQS/xw0QRykw
        qTBDIwPC86nb8XHxIr1fXDuzHvMVlmY=
X-Google-Smtp-Source: APXvYqzYxBMSf5B+bREKVb2h8MLJ8FbhI62KADZTUzPkF5WWEIWEfNpCjWMUWERoDt2uNO6jkLmP2Q==
X-Received: by 2002:ae9:ebc5:: with SMTP id b188mr10076870qkg.464.1576786053596;
        Thu, 19 Dec 2019 12:07:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::91a1])
        by smtp.gmail.com with ESMTPSA id n1sm1990647qkk.122.2019.12.19.12.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:07:32 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Date:   Thu, 19 Dec 2019 15:07:18 -0500
Message-Id: <20191219200718.15696-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219200718.15696-1-hannes@cmpxchg.org>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Right now, the effective protection of any given cgroup is capped by
its own explicit memory.low setting, regardless of what the parent
says. The reasons for this are mostly historical and ease of
implementation: to make delegation of memory.low safe, effective
protection is the min() of all memory.low up the tree.

Unfortunately, this limitation makes it impossible to protect an
entire subtree from another without forcing the user to make explicit
protection allocations all the way to the leaf cgroups - something
that is highly undesirable in real life scenarios.

Consider memory in a data center host. At the cgroup top level, we
have a distinction between system management software and the actual
workload the system is executing. Both branches are further subdivided
into individual services, job components etc.

We want to protect the workload as a whole from the system management
software, but that doesn't mean we want to protect and prioritize
individual workload wrt each other. Their memory demand can vary over
time, and we'd want the VM to simply cache the hottest data within the
workload subtree. Yet, the current memory.low limitations force us to
allocate a fixed amount of protection to each workload component in
order to get protection from system management software in
general. This results in very inefficient resource distribution.

To enable such use cases, this patch adds the concept of recursive
protection to the memory.low setting, while retaining the abilty to
assign fixed protection in leaf groups as well.

That means that if protection is explicitly allocated among siblings,
those configured weights are being followed during page reclaim just
like they are now.

However, if the memory.low set at a higher level is not fully claimed
by the children in that subtree, the "floating" remainder is applied
to each cgroup in the tree in proportion to its size. Since reclaim
pressure is applied in proportion to size as well, each child in that
tree gets the same boost, and the effect is neutral among siblings -
with respect to each other, they behave as if no memory control was
enabled at all, and the VM simply balances the memory demands
optimally within the subtree. But collectively those cgroups enjoy a
boost over the cgroups in neighboring trees.

This allows us to recursively protect one subtree (workload) from
another (system management), but let subgroups compete freely among
each other without having to assign fixed shares to each leaf.

The floating protection composes naturally with fixed
protection. Consider the following example tree:

		A            A: low = 2G
               / \          A1: low = 1G
              A1 A2         A2: low = 0G

As outside pressure is applied to this tree, A1 will enjoy a fixed
protection from A2 of 1G, but the remaining, unclaimed 1G from A is
split evenly among A1 and A2. Assuming equal memory demand in both,
memory usage will converge on A1 using 1.5G and A2 using 0.5G.

There is a slight risk of regressing theoretical setups where the
top-level cgroups don't know about the true budgeting and set bogusly
high "bypass" values that are meaningfully allocated down the
tree. Such setups would rely on unclaimed protection to be discarded,
and distributing it would change the intended behavior. Be safe and
hide the new behavior behind a mount option, 'memory_recursiveprot'.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/admin-guide/cgroup-v2.rst | 11 +++++
 include/linux/cgroup-defs.h             |  5 ++
 kernel/cgroup/cgroup.c                  | 17 ++++++-
 mm/memcontrol.c                         | 65 +++++++++++++++++++++++--
 4 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0636bcb60b5a..e569d83621da 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -186,6 +186,17 @@ cgroup v2 currently supports the following mount options.
         modified through remount from the init namespace. The mount
         option is ignored on non-init namespace mounts.
 
+  memory_recursiveprot
+
+        Recursively apply memory.min and memory.low protection to
+        entire subtrees, without requiring explicit downward
+        propagation into leaf cgroups.  This allows protecting entire
+        subtrees from one another, while retaining free competition
+        within those subtrees.  This should have been the default
+        behavior but is a mount-option to avoid regressing setups
+        relying on the original semantics (e.g. specifying bogusly
+        high 'bypass' protection values at higher tree levels).
+
 
 Organizing Processes and Threads
 --------------------------------
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 63097cb243cb..e1fafed22db1 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -94,6 +94,11 @@ enum {
 	 * Enable legacy local memory.events.
 	 */
 	CGRP_ROOT_MEMORY_LOCAL_EVENTS = (1 << 5),
+
+	/*
+	 * Enable recursive subtree protection
+	 */
+	CGRP_ROOT_MEMORY_RECURSIVE_PROT = (1 << 6),
 };
 
 /* cftype->flags */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 735af8f15f95..a2f8d2ab8dec 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1813,12 +1813,14 @@ int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 enum cgroup2_param {
 	Opt_nsdelegate,
 	Opt_memory_localevents,
+	Opt_memory_recursiveprot,
 	nr__cgroup2_params
 };
 
 static const struct fs_parameter_spec cgroup2_param_specs[] = {
 	fsparam_flag("nsdelegate",		Opt_nsdelegate),
 	fsparam_flag("memory_localevents",	Opt_memory_localevents),
+	fsparam_flag("memory_recursiveprot",	Opt_memory_recursiveprot),
 	{}
 };
 
@@ -1844,6 +1846,9 @@ static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param
 	case Opt_memory_localevents:
 		ctx->flags |= CGRP_ROOT_MEMORY_LOCAL_EVENTS;
 		return 0;
+	case Opt_memory_recursiveprot:
+		ctx->flags |= CGRP_ROOT_MEMORY_RECURSIVE_PROT;
+		return 0;
 	}
 	return -EINVAL;
 }
@@ -1860,6 +1865,11 @@ static void apply_cgroup_root_flags(unsigned int root_flags)
 			cgrp_dfl_root.flags |= CGRP_ROOT_MEMORY_LOCAL_EVENTS;
 		else
 			cgrp_dfl_root.flags &= ~CGRP_ROOT_MEMORY_LOCAL_EVENTS;
+
+		if (root_flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT)
+			cgrp_dfl_root.flags |= CGRP_ROOT_MEMORY_RECURSIVE_PROT;
+		else
+			cgrp_dfl_root.flags &= ~CGRP_ROOT_MEMORY_RECURSIVE_PROT;
 	}
 }
 
@@ -1869,6 +1879,8 @@ static int cgroup_show_options(struct seq_file *seq, struct kernfs_root *kf_root
 		seq_puts(seq, ",nsdelegate");
 	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_LOCAL_EVENTS)
 		seq_puts(seq, ",memory_localevents");
+	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT)
+		seq_puts(seq, ",memory_recursiveprot");
 	return 0;
 }
 
@@ -6364,7 +6376,10 @@ static struct kobj_attribute cgroup_delegate_attr = __ATTR_RO(delegate);
 static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "nsdelegate\nmemory_localevents\n");
+	return snprintf(buf, PAGE_SIZE,
+			"nsdelegate\n"
+			"memory_localevents\n"
+			"memory_recursiveprot\n");
 }
 static struct kobj_attribute cgroup_features_attr = __ATTR_RO(features);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9c771c4d6339..cf02e3ef3ed9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6254,6 +6254,32 @@ struct cgroup_subsys memory_cgrp_subsys = {
  *    budget is NOT proportional. A cgroup's protection from a sibling
  *    is capped to its own memory.min/low setting.
  *
+ * 5. However, to allow protecting recursive subtrees from each other
+ *    without having to declare each individual cgroup's fixed share
+ *    of the ancestor's claim to protection, any unutilized -
+ *    "floating" - protection from up the tree is distributed in
+ *    proportion to each cgroup's *usage*. This makes the protection
+ *    neutral wrt sibling cgroups and lets them compete freely over
+ *    the shared parental protection budget, but it protects the
+ *    subtree as a whole from neighboring subtrees.
+ *
+ *    Consider the following example tree:
+ *
+ *        A            A: low = 2G
+ *       / \           B: low = 1G
+ *      B   C          C: low = 0G
+ *
+ *    As memory pressure is applied, the following memory distribution
+ *    is expected (approximately):
+ *
+ *      A/memory.current = 2G
+ *      B/memory.current = 1.5G
+ *      C/memory.current = 0.5G
+ *
+ * Note that 4. and 5. are not in conflict: 4. is about protecting
+ * against immediate siblings whereas 5. is about protecting against
+ * neighboring subtrees.
+ *
  * These calculations require constant tracking of the actual low usages
  * (see propagate_protected_usage()), as well as recursive calculation of
  * effective memory.low values. But as we do call mem_cgroup_protected()
@@ -6263,11 +6289,13 @@ struct cgroup_subsys memory_cgrp_subsys = {
  * as memory.low is a best-effort mechanism.
  */
 static unsigned long effective_protection(unsigned long usage,
+					  unsigned long parent_usage,
 					  unsigned long setting,
 					  unsigned long parent_effective,
 					  unsigned long siblings_protected)
 {
 	unsigned long protected;
+	unsigned long ep;
 
 	protected = min(usage, setting);
 	/*
@@ -6298,7 +6326,34 @@ static unsigned long effective_protection(unsigned long usage,
 	 * protection is always dependent on how memory is actually
 	 * consumed among the siblings anyway.
 	 */
-	return protected;
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
+	 */
+	if (!(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT))
+		return ep;
+
+	if (parent_effective > siblings_protected && usage > protected) {
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
 }
 
 /**
@@ -6318,8 +6373,8 @@ static unsigned long effective_protection(unsigned long usage,
 enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 						struct mem_cgroup *memcg)
 {
+	unsigned long usage, parent_usage;
 	struct mem_cgroup *parent;
-	unsigned long usage;
 
 	if (mem_cgroup_disabled())
 		return MEMCG_PROT_NONE;
@@ -6344,11 +6399,13 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 		goto out;
 	}
 
-	memcg->memory.emin = effective_protection(usage,
+	parent_usage = page_counter_read(&parent->memory);
+
+	memcg->memory.emin = effective_protection(usage, parent_usage,
 			memcg->memory.min, READ_ONCE(parent->memory.emin),
 			atomic_long_read(&parent->memory.children_min_usage));
 
-	memcg->memory.elow = effective_protection(usage,
+	memcg->memory.elow = effective_protection(usage, parent_usage,
 			memcg->memory.low, READ_ONCE(parent->memory.elow),
 			atomic_long_read(&parent->memory.children_low_usage));
 
-- 
2.24.1

