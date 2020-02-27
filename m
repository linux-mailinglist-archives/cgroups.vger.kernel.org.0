Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64E7B172907
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2020 20:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbgB0T4S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Feb 2020 14:56:18 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33879 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730716AbgB0T4R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Feb 2020 14:56:17 -0500
Received: by mail-qk1-f194.google.com with SMTP id 11so673987qkd.1
        for <cgroups@vger.kernel.org>; Thu, 27 Feb 2020 11:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3S75USrJcvg7+14y2qoSr0W2vyLWm3IhoTMN6tsWJzg=;
        b=a0Uh+0/NzVTWut0foQw1rsKmUUAr2GBVpYMifrpAh0mLWUF4UcX39JJTxul+5VTETA
         2H5mtw8r8rQOH0i9OXw3fmFtr+tO1Di/FGo1CEl4bdmnHYOifhR8MsV9t/Pp9ydvSZWZ
         awIFXmOHjuGDKvpCAeAmuNvRTqEx/Hk5nwAFJ0NzzURtbg7pOXfVbLi02ycND+vrsQyQ
         2D+a+vrVzEjEM2Ly0Ro4WKWgGcVOeFks5Rb+BBrxz5eZR/D5HAZp09i5stguskXK9QZH
         tOcoJcCk+VJce1WPPpw+mIe3sCwr4OOZbN1V0apfNv71cUaa+NFONrk+BZbp6u8z9Kbj
         /Pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3S75USrJcvg7+14y2qoSr0W2vyLWm3IhoTMN6tsWJzg=;
        b=aQ2B92avasBN+YtTzrHgzUey42ptRdMqDY2Wk+Z41Lbvldy9LlqU2DJWpGxN4m+07s
         YbYdW826clKXjmWb5RCUbjQ/pzuZ5GNEjMAcw1h1vOq/5IcNvotp6Drq2iGmQDEVL+Pz
         fbX0lDfTS4vtHrKUtdGmj78vXtve+aNktlUVxMkbT6AkmgGtgG/7nigmReH1ECHFK0I0
         mhudZtQe7rAwLSA61KMIIuiDyGuUyJQwH39UIsCPjs1YbdcyLG4njwcv3TLHEZ8qbirh
         2XR9KJdYYgDpNel3iFgQlfSOSJgHbsaYbPBBRuFiS8JKE28gReM5QbO72NURBi1FVFTh
         Briw==
X-Gm-Message-State: APjAAAVqFN4eXzdiJFv2ZKpuvg8UChkUlWT+k/VfpgyLjjomrPwZfHwA
        +yp859/F/6aielG5shriYonVOA==
X-Google-Smtp-Source: APXvYqw295YqlVSaCQGL02EkVC+azawsBSQLP/GA2Wfpln+atCptwejVsTETixabVk/2qhm1/CRvqg==
X-Received: by 2002:a37:7a05:: with SMTP id v5mr1107870qkc.329.1582833376542;
        Thu, 27 Feb 2020 11:56:16 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:2450])
        by smtp.gmail.com with ESMTPSA id o55sm3843680qtf.46.2020.02.27.11.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:56:15 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] mm: memcontrol: recursive memory.low protection
Date:   Thu, 27 Feb 2020 14:56:06 -0500
Message-Id: <20200227195606.46212-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227195606.46212-1-hannes@cmpxchg.org>
References: <20200227195606.46212-1-hannes@cmpxchg.org>
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

Another concern with mandating downward allocation is that, as the
complexity of the cgroup tree grows, it gets harder for the lower
levels to be informed about decisions made at the host-level. Consider
a container inside a namespace that in turn creates its own nested
tree of cgroups to run multiple workloads. It'd be extremely difficult
to configure memory.low parameters in those leaf cgroups that on one
hand balance pressure among siblings as the container desires, while
also reflecting the host-level protection from e.g. rpm upgrades, that
lie beyond one or more delegation and namespacing points in the tree.

It's highly unusual from a cgroup interface POV that nested levels
have to be aware of and reflect decisions made at higher levels for
them to be effective.

To enable such use cases and scale configurability for complex trees,
this patch implements a resource inheritance model for memory that is
similar to how the CPU and the IO controller implement work-conserving
resource allocations: a share of a resource allocated to a subree
always applies to the entire subtree recursively, while allowing, but
not mandating, children to further specify distribution rules.

That means that if protection is explicitly allocated among siblings,
those configured shares are being followed during page reclaim just
like they are now. However, if the memory.low set at a higher level is
not fully claimed by the children in that subtree, the "floating"
remainder is applied to each cgroup in the tree in proportion to its
size. Since reclaim pressure is applied in proportion to size as well,
each child in that tree gets the same boost, and the effect is neutral
among siblings - with respect to each other, they behave as if no
memory control was enabled at all, and the VM simply balances the
memory demands optimally within the subtree. But collectively those
cgroups enjoy a boost over the cgroups in neighboring trees.

E.g. a leaf cgroup with a memory.low setting of 0 no longer means that
it's not getting a share of the hierarchically assigned resource, just
that it doesn't claim a fixed amount of it to protect from its siblings.

This allows us to recursively protect one subtree (workload) from
another (system management), while letting subgroups compete freely
among each other - without having to assign fixed shares to each leaf,
and without nested groups having to echo higher-level settings.

The floating protection composes naturally with fixed
protection. Consider the following example tree:

		A            A: low = 2G
               / \          A1: low = 1G
              A1 A2         A2: low = 0G

As outside pressure is applied to this tree, A1 will enjoy a fixed
protection from A2 of 1G, but the remaining, unclaimed 1G from A is
split evenly among A1 and A2, coming out to 1.5G and 0.5G.

There is a slight risk of regressing theoretical setups where the
top-level cgroups don't know about the true budgeting and set bogusly
high "bypass" values that are meaningfully allocated down the
tree. Such setups would rely on unclaimed protection to be discarded,
and distributing it would change the intended behavior. Be safe and
hide the new behavior behind a mount option, 'memory_recursiveprot'.

Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/admin-guide/cgroup-v2.rst | 11 ++++++
 include/linux/cgroup-defs.h             |  5 +++
 kernel/cgroup/cgroup.c                  | 17 ++++++++-
 mm/memcontrol.c                         | 51 +++++++++++++++++++++++--
 4 files changed, 79 insertions(+), 5 deletions(-)

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
index 836c521bd61f..0dd5d5f70593 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6234,13 +6234,27 @@ struct cgroup_subsys memory_cgrp_subsys = {
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
+ * Note that 4. and 5. are not in conflict: 4. is about protecting
+ * against immediate siblings whereas 5. is about protecting against
+ * neighboring subtrees.
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
@@ -6271,7 +6285,34 @@ static unsigned long effective_protection(unsigned long usage,
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
@@ -6291,8 +6332,8 @@ static unsigned long effective_protection(unsigned long usage,
 enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 						struct mem_cgroup *memcg)
 {
+	unsigned long usage, parent_usage;
 	struct mem_cgroup *parent;
-	unsigned long usage;
 
 	if (mem_cgroup_disabled())
 		return MEMCG_PROT_NONE;
@@ -6317,11 +6358,13 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
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

