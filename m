Return-Path: <cgroups+bounces-8201-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CC4AB7A7A
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 02:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD8D3A3E53
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 00:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49B12E7F;
	Thu, 15 May 2025 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deerN5YH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A6F9D6
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268395; cv=none; b=PYD+8Ua6YodSA1nncGoUA+S8mzJA9BQh6s4tFTTrV+dSAi8EJ4n9P+AKOWTCdAr206jEWGJv7GOSSPDbm9NOhAkkWoxvEHfYUGD6DnC6Z90cr/xO1v3PCuS/X/b2g/EyQxGGrGPoKUVperNyBRW4WV+FIKcHGif1Fauhoma98U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268395; c=relaxed/simple;
	bh=G57RdCKJ29JPWwgU8kAepxeoornhOzH12qW1HwSUqL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZjZZVlp/YqHUNVtNmrFoErfcUnTDxRp4KduDMxnaUSTqBxjGXz0QxAO4+L1CW+cttsw62o1Ml+RtlpwGA5j2s+IaPybcuxdOjvM5RupZEgUIS2mcI9wuyJSZVvhwTYKbiSocefp28ixs3NvPvocBFFIEOvX4KPYjNICYG3MoeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deerN5YH; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso485192b3a.0
        for <cgroups@vger.kernel.org>; Wed, 14 May 2025 17:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747268392; x=1747873192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb6v/0TjI6FTNiWi7UnswXX67qCmltOHXC6YKnrwwxA=;
        b=deerN5YH1KUPbl/wsQckC31/4ZrNVA47rynwWlHnzHpF/BNnosn/zg4d5FEbfKRZ7Q
         4XxfCKanr7G4Stsw62ifjwN0Q6cOJYpk7r+R7DGX4O3Fkr5GW/is+o/LD5LTugb6tE8u
         XGN+7BDLWDczpYF40cu1IFsiq1TgXw2vIEqvOC/eeh2beqMgREmyRyHnkLy0y/JjU83C
         r9pwEzj+iX6uA05rF4hZ7adlWPS0PE5H/2w7rdotSS7rJvhxenXlXKVFW0k5vEYw5PDB
         uth9REg46So9bIZt+LqsjPqsg84UgWL/n4uv8b6OFskPBu93ijWoH7lUunGUK9Zdkm4l
         kQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747268392; x=1747873192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gb6v/0TjI6FTNiWi7UnswXX67qCmltOHXC6YKnrwwxA=;
        b=KW8xzPi7omsqzeHvABzYzFWOzQkA/X4x0lTOsg7ZowHzt4z6pottT5ZhpWoVvZeEgT
         LJUuRhKFB/4wt9xIkGPXZ1k8u6igKqaNJwWsa+E0lQYC3abR8uComdOwnr0Jdrd8YomT
         5X3JMNRXeil0+ldrS26RMynH8S2hhqkwyNbUgQPcf7qtwGVG/hiRCp23kSIIJ5mywK2a
         zYHdWj9/sGoJDAvHzHVRm0Mku8K1SSpZeHmLdlIii+6uJdJYQHe9brXDPEsRmv65c+Ls
         hRt0AhPANIDO6WjB7Chi6OtnpIBnxQNgBBgty/R4xEs1Kd3nAHwWzJ+3dy68H/3vhubr
         WuCw==
X-Forwarded-Encrypted: i=1; AJvYcCUNT64WWxHw1seh30/rm09nkQNqEvn0j6vyBVs+5wYDNNSbeEyJjtdZs7OzdGtISLV5jGB9owDk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0S25OeLSwR5OFDd8dHu8LracynIccIM4dfLWSh5aq+y4lQosl
	tuahxqULNhsl0pX5/TOW4FKh6YATUR9uWhF+yU3FqxiO8SzzkQoe
X-Gm-Gg: ASbGncu6cKfIEBWQKMX1dQvMfwTbGa7xJaSYjiGm2CqE3i7ah5wh3rPc2hV4krOO8Zt
	uy0yddpHfPIdFV+DnmLohsZEAwWZt60jE4KgNJ69wRShKJsNF83JnPScGe9H1OP5k1WBwT0FRql
	5D0AamFoujsVeEHANEk2D04BahVb3pfSMAtQFI9QqgIy4oN8sR9ubIQtYntXzjoksojSy9Pa9l2
	xIYN/imn2SuoqipPojFOG/uXo+qKqqgDKtLQl4sti8hWvrR/PO2kRofUIYaIOjGXgtyRyE9DfTI
	QpUbDFra+fxGPE7ctGwuRKOdZmGzf4cRgZCQBZ1bnCrQg9CClXGS3nYS2GkqkF1TmEWDTT2KbfQ
	mbfuSgziX941d/2vlVzjCstcCoUWsSMCfe8V5a3I=
X-Google-Smtp-Source: AGHT+IGwYe/V7hSj+zKVv/hPorj15C2n/rlhFWq+2ujKxiFkOFwxMERgb6ohTWiw8QwhVOarCM0I0g==
X-Received: by 2002:a17:903:3bce:b0:223:39ae:a98 with SMTP id d9443c01a7336-23198155253mr90560645ad.22.1747268391846;
        Wed, 14 May 2025 17:19:51 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc754785bsm105939545ad.20.2025.05.14.17.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 17:19:51 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v6 3/6] cgroup: use separate rstat trees for each subsystem
Date: Wed, 14 May 2025 17:19:34 -0700
Message-ID: <20250515001937.219505-4-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515001937.219505-1-inwardvessel@gmail.com>
References: <20250515001937.219505-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Different subsystems may call cgroup_rstat_updated() within the same
cgroup, resulting in a tree of pending updates from multiple subsystems.
When one of these subsystems is flushed via cgroup_rstat_flushed(), all
other subsystems with pending updates on the tree will also be flushed.

Change the paradigm of having a single rstat tree for all subsystems to
having separate trees for each subsystem. This separation allows for
subsystems to perform flushes without the side effects of other subsystems.
As an example, flushing the cpu stats will no longer cause the memory stats
to be flushed and vice versa.

In order to achieve subsystem-specific trees, change the tree node type
from cgroup to cgroup_subsys_state pointer. Then remove those pointers from
the cgroup and instead place them on the css. Finally, change update/flush
functions to make use of the different node type (css). These changes allow
a specific subsystem to be associated with an update or flush. Separate
rstat trees will now exist for each unique subsystem.

Since updating/flushing will now be done at the subsystem level, there is
no longer a need to keep track of updated css nodes at the cgroup level.
The list management of these nodes done within the cgroup (rstat_css_list
and related) has been removed accordingly.

Conditional guards for checking validity of a given css were placed within
css_rstat_updated/flush() to prevent undefined behavior occuring from kfunc
usage in bpf programs. Guards were also placed within css_rstat_init/exit()
in order to help consolidate calls to them. At call sites for all four
functions, the existing guards were removed.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup-defs.h                   |  46 ++--
 kernel/cgroup/cgroup.c                        |  34 +--
 kernel/cgroup/rstat.c                         | 206 ++++++++++--------
 .../selftests/bpf/progs/btf_type_tag_percpu.c |  18 +-
 4 files changed, 162 insertions(+), 142 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index e58bfb880111..17ecaae9c5f8 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -169,6 +169,8 @@ struct cgroup_subsys_state {
 	/* reference count - access via css_[try]get() and css_put() */
 	struct percpu_ref refcnt;
 
+	struct css_rstat_cpu __percpu *rstat_cpu;
+
 	/*
 	 * siblings list anchored at the parent's ->children
 	 *
@@ -177,9 +179,6 @@ struct cgroup_subsys_state {
 	struct list_head sibling;
 	struct list_head children;
 
-	/* flush target list anchored at cgrp->rstat_css_list */
-	struct list_head rstat_css_node;
-
 	/*
 	 * PI: Subsys-unique ID.  0 is unused and root is always 1.  The
 	 * matching css can be looked up using css_from_id().
@@ -219,6 +218,13 @@ struct cgroup_subsys_state {
 	 * Protected by cgroup_mutex.
 	 */
 	int nr_descendants;
+
+	/*
+	 * A singly-linked list of css structures to be rstat flushed.
+	 * This is a scratch field to be used exclusively by
+	 * css_rstat_flush() and protected by cgroup_rstat_lock.
+	 */
+	struct cgroup_subsys_state *rstat_flush_next;
 };
 
 /*
@@ -329,10 +335,10 @@ struct cgroup_base_stat {
 
 /*
  * rstat - cgroup scalable recursive statistics.  Accounting is done
- * per-cpu in cgroup_rstat_cpu which is then lazily propagated up the
+ * per-cpu in css_rstat_cpu which is then lazily propagated up the
  * hierarchy on reads.
  *
- * When a stat gets updated, the cgroup_rstat_cpu and its ancestors are
+ * When a stat gets updated, the css_rstat_cpu and its ancestors are
  * linked into the updated tree.  On the following read, propagation only
  * considers and consumes the updated tree.  This makes reading O(the
  * number of descendants which have been active since last read) instead of
@@ -346,20 +352,20 @@ struct cgroup_base_stat {
  * This struct hosts both the fields which implement the above -
  * updated_children and updated_next.
  */
-struct cgroup_rstat_cpu {
+struct css_rstat_cpu {
 	/*
 	 * Child cgroups with stat updates on this cpu since the last read
 	 * are linked on the parent's ->updated_children through
-	 * ->updated_next.
+	 * ->updated_next. updated_children is terminated by its container css.
 	 *
-	 * In addition to being more compact, singly-linked list pointing
-	 * to the cgroup makes it unnecessary for each per-cpu struct to
-	 * point back to the associated cgroup.
+	 * In addition to being more compact, singly-linked list pointing to
+	 * the css makes it unnecessary for each per-cpu struct to point back
+	 * to the associated css.
 	 *
 	 * Protected by per-cpu cgroup_rstat_cpu_lock.
 	 */
-	struct cgroup *updated_children;	/* terminated by self cgroup */
-	struct cgroup *updated_next;		/* NULL iff not on the list */
+	struct cgroup_subsys_state *updated_children;
+	struct cgroup_subsys_state *updated_next;	/* NULL if not on the list */
 };
 
 /*
@@ -521,25 +527,15 @@ struct cgroup {
 	struct cgroup *dom_cgrp;
 	struct cgroup *old_dom_cgrp;		/* used while enabling threaded */
 
-	/* per-cpu recursive resource statistics */
-	struct cgroup_rstat_cpu __percpu *rstat_cpu;
 	struct cgroup_rstat_base_cpu __percpu *rstat_base_cpu;
-	struct list_head rstat_css_list;
 
 	/*
-	 * Add padding to separate the read mostly rstat_cpu and
-	 * rstat_css_list into a different cacheline from the following
-	 * rstat_flush_next and *bstat fields which can have frequent updates.
+	 * Add padding to keep the read mostly rstat per-cpu pointer on a
+	 * different cacheline than the following *bstat fields which can have
+	 * frequent updates.
 	 */
 	CACHELINE_PADDING(_pad_);
 
-	/*
-	 * A singly-linked list of cgroup structures to be rstat flushed.
-	 * This is a scratch field to be used exclusively by
-	 * css_rstat_flush_locked() and protected by cgroup_rstat_lock.
-	 */
-	struct cgroup	*rstat_flush_next;
-
 	/* cgroup basic resource statistics */
 	struct cgroup_base_stat last_bstat;
 	struct cgroup_base_stat bstat;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ce6a60b9b585..45097dc9e099 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -161,12 +161,12 @@ static struct static_key_true *cgroup_subsys_on_dfl_key[] = {
 };
 #undef SUBSYS
 
-static DEFINE_PER_CPU(struct cgroup_rstat_cpu, root_rstat_cpu);
+static DEFINE_PER_CPU(struct css_rstat_cpu, root_rstat_cpu);
 static DEFINE_PER_CPU(struct cgroup_rstat_base_cpu, root_rstat_base_cpu);
 
 /* the default hierarchy */
 struct cgroup_root cgrp_dfl_root = {
-	.cgrp.rstat_cpu = &root_rstat_cpu,
+	.cgrp.self.rstat_cpu = &root_rstat_cpu,
 	.cgrp.rstat_base_cpu = &root_rstat_base_cpu,
 };
 EXPORT_SYMBOL_GPL(cgrp_dfl_root);
@@ -1362,7 +1362,6 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 
 	cgroup_unlock();
 
-	css_rstat_exit(&cgrp->self);
 	kernfs_destroy_root(root->kf_root);
 	cgroup_free_root(root);
 }
@@ -1867,13 +1866,6 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		}
 		spin_unlock_irq(&css_set_lock);
 
-		if (ss->css_rstat_flush) {
-			list_del_rcu(&css->rstat_css_node);
-			synchronize_rcu();
-			list_add_rcu(&css->rstat_css_node,
-				     &dcgrp->rstat_css_list);
-		}
-
 		/* default hierarchy doesn't enable controllers by default */
 		dst_root->subsys_mask |= 1 << ssid;
 		if (dst_root == &cgrp_dfl_root) {
@@ -2056,7 +2048,6 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 	cgrp->dom_cgrp = cgrp;
 	cgrp->max_descendants = INT_MAX;
 	cgrp->max_depth = INT_MAX;
-	INIT_LIST_HEAD(&cgrp->rstat_css_list);
 	prev_cputime_init(&cgrp->prev_cputime);
 
 	for_each_subsys(ss, ssid)
@@ -5405,6 +5396,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 	struct cgroup *cgrp = css->cgroup;
 
 	percpu_ref_exit(&css->refcnt);
+	css_rstat_exit(css);
 
 	if (!css_is_self(css)) {
 		/* css free path */
@@ -5435,7 +5427,6 @@ static void css_free_rwork_fn(struct work_struct *work)
 			cgroup_put(cgroup_parent(cgrp));
 			kernfs_put(cgrp->kn);
 			psi_cgroup_free(cgrp);
-			css_rstat_exit(css);
 			kfree(cgrp);
 		} else {
 			/*
@@ -5463,11 +5454,7 @@ static void css_release_work_fn(struct work_struct *work)
 	if (!css_is_self(css)) {
 		struct cgroup *parent_cgrp;
 
-		/* css release path */
-		if (!list_empty(&css->rstat_css_node)) {
-			css_rstat_flush(css);
-			list_del_rcu(&css->rstat_css_node);
-		}
+		css_rstat_flush(css);
 
 		cgroup_idr_replace(&ss->css_idr, NULL, css->id);
 		if (ss->css_released)
@@ -5493,7 +5480,7 @@ static void css_release_work_fn(struct work_struct *work)
 		/* cgroup release path */
 		TRACE_CGROUP_PATH(release, cgrp);
 
-		css_rstat_flush(css);
+		css_rstat_flush(&cgrp->self);
 
 		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
@@ -5541,7 +5528,6 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 	css->id = -1;
 	INIT_LIST_HEAD(&css->sibling);
 	INIT_LIST_HEAD(&css->children);
-	INIT_LIST_HEAD(&css->rstat_css_node);
 	css->serial_nr = css_serial_nr_next++;
 	atomic_set(&css->online_cnt, 0);
 
@@ -5550,9 +5536,6 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 		css_get(css->parent);
 	}
 
-	if (ss->css_rstat_flush)
-		list_add_rcu(&css->rstat_css_node, &cgrp->rstat_css_list);
-
 	BUG_ON(cgroup_css(cgrp, ss));
 }
 
@@ -5645,6 +5628,10 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 		goto err_free_css;
 	css->id = err;
 
+	err = css_rstat_init(css);
+	if (err)
+		goto err_free_css;
+
 	/* @css is ready to be brought online now, make it visible */
 	list_add_tail_rcu(&css->sibling, &parent_css->children);
 	cgroup_idr_replace(&ss->css_idr, css, css->id);
@@ -5658,7 +5645,6 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 err_list_del:
 	list_del_rcu(&css->sibling);
 err_free_css:
-	list_del_rcu(&css->rstat_css_node);
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
 	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
 	return ERR_PTR(err);
@@ -6101,6 +6087,8 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 	} else {
 		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
 		BUG_ON(css->id < 0);
+
+		BUG_ON(css_rstat_init(css));
 	}
 
 	/* Update the init_css_set to contain a subsys
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 357c538d14da..6ce134a7294d 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -14,9 +14,10 @@ static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
-static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
+static struct css_rstat_cpu *css_rstat_cpu(
+		struct cgroup_subsys_state *css, int cpu)
 {
-	return per_cpu_ptr(cgrp->rstat_cpu, cpu);
+	return per_cpu_ptr(css->rstat_cpu, cpu);
 }
 
 static struct cgroup_rstat_base_cpu *cgroup_rstat_base_cpu(
@@ -87,34 +88,40 @@ void _css_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
  * @css: target cgroup subsystem state
  * @cpu: cpu on which rstat_cpu was updated
  *
- * @css->cgroup's rstat_cpu on @cpu was updated. Put it on the parent's
- * matching rstat_cpu->updated_children list. See the comment on top of
- * cgroup_rstat_cpu definition for details.
+ * @css's rstat_cpu on @cpu was updated. Put it on the parent's matching
+ * rstat_cpu->updated_children list. See the comment on top of
+ * css_rstat_cpu definition for details.
  */
 __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
-	struct cgroup *cgrp = css->cgroup;
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
 
+	/*
+	 * Since bpf programs can call this function, prevent access to
+	 * uninitialized rstat pointers.
+	 */
+	if (!css_is_self(css) && css->ss->css_rstat_flush == NULL)
+		return;
+
 	/*
 	 * Speculative already-on-list test. This may race leading to
 	 * temporary inaccuracies, which is fine.
 	 *
 	 * Because @parent's updated_children is terminated with @parent
-	 * instead of NULL, we can tell whether @cgrp is on the list by
+	 * instead of NULL, we can tell whether @css is on the list by
 	 * testing the next pointer for NULL.
 	 */
-	if (data_race(cgroup_rstat_cpu(cgrp, cpu)->updated_next))
+	if (data_race(css_rstat_cpu(css, cpu)->updated_next))
 		return;
 
 	flags = _css_rstat_cpu_lock(cpu_lock, cpu, css, true);
 
-	/* put @cgrp and all ancestors on the corresponding updated lists */
+	/* put @css and all ancestors on the corresponding updated lists */
 	while (true) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
-		struct cgroup *parent = cgroup_parent(cgrp);
-		struct cgroup_rstat_cpu *prstatc;
+		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
+		struct cgroup_subsys_state *parent = css->parent;
+		struct css_rstat_cpu *prstatc;
 
 		/*
 		 * Both additions and removals are bottom-up.  If a cgroup
@@ -125,40 +132,41 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 
 		/* Root has no parent to link it to, but mark it busy */
 		if (!parent) {
-			rstatc->updated_next = cgrp;
+			rstatc->updated_next = css;
 			break;
 		}
 
-		prstatc = cgroup_rstat_cpu(parent, cpu);
+		prstatc = css_rstat_cpu(parent, cpu);
 		rstatc->updated_next = prstatc->updated_children;
-		prstatc->updated_children = cgrp;
+		prstatc->updated_children = css;
 
-		cgrp = parent;
+		css = parent;
 	}
 
 	_css_rstat_cpu_unlock(cpu_lock, cpu, css, flags, true);
 }
 
 /**
- * cgroup_rstat_push_children - push children cgroups into the given list
+ * css_rstat_push_children - push children css's into the given list
  * @head: current head of the list (= subtree root)
  * @child: first child of the root
  * @cpu: target cpu
- * Return: A new singly linked list of cgroups to be flushed
+ * Return: A new singly linked list of css's to be flushed
  *
- * Iteratively traverse down the cgroup_rstat_cpu updated tree level by
+ * Iteratively traverse down the css_rstat_cpu updated tree level by
  * level and push all the parents first before their next level children
  * into a singly linked list via the rstat_flush_next pointer built from the
- * tail backward like "pushing" cgroups into a stack. The root is pushed by
+ * tail backward like "pushing" css's into a stack. The root is pushed by
  * the caller.
  */
-static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
-						 struct cgroup *child, int cpu)
+static struct cgroup_subsys_state *css_rstat_push_children(
+		struct cgroup_subsys_state *head,
+		struct cgroup_subsys_state *child, int cpu)
 {
-	struct cgroup *cnext = child;	/* Next head of child cgroup level */
-	struct cgroup *ghead = NULL;	/* Head of grandchild cgroup level */
-	struct cgroup *parent, *grandchild;
-	struct cgroup_rstat_cpu *crstatc;
+	struct cgroup_subsys_state *cnext = child;	/* Next head of child css level */
+	struct cgroup_subsys_state *ghead = NULL;	/* Head of grandchild css level */
+	struct cgroup_subsys_state *parent, *grandchild;
+	struct css_rstat_cpu *crstatc;
 
 	child->rstat_flush_next = NULL;
 
@@ -189,13 +197,13 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
 	while (cnext) {
 		child = cnext;
 		cnext = child->rstat_flush_next;
-		parent = cgroup_parent(child);
+		parent = child->parent;
 
 		/* updated_next is parent cgroup terminated if !NULL */
 		while (child != parent) {
 			child->rstat_flush_next = head;
 			head = child;
-			crstatc = cgroup_rstat_cpu(child, cpu);
+			crstatc = css_rstat_cpu(child, cpu);
 			grandchild = crstatc->updated_children;
 			if (grandchild != child) {
 				/* Push the grand child to the next level */
@@ -217,31 +225,32 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
 }
 
 /**
- * cgroup_rstat_updated_list - return a list of updated cgroups to be flushed
- * @root: root of the cgroup subtree to traverse
+ * css_rstat_updated_list - build a list of updated css's to be flushed
+ * @root: root of the css subtree to traverse
  * @cpu: target cpu
- * Return: A singly linked list of cgroups to be flushed
+ * Return: A singly linked list of css's to be flushed
  *
  * Walks the updated rstat_cpu tree on @cpu from @root.  During traversal,
- * each returned cgroup is unlinked from the updated tree.
+ * each returned css is unlinked from the updated tree.
  *
  * The only ordering guarantee is that, for a parent and a child pair
  * covered by a given traversal, the child is before its parent in
  * the list.
  *
  * Note that updated_children is self terminated and points to a list of
- * child cgroups if not empty. Whereas updated_next is like a sibling link
- * within the children list and terminated by the parent cgroup. An exception
- * here is the cgroup root whose updated_next can be self terminated.
+ * child css's if not empty. Whereas updated_next is like a sibling link
+ * within the children list and terminated by the parent css. An exception
+ * here is the css root whose updated_next can be self terminated.
  */
-static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
+static struct cgroup_subsys_state *css_rstat_updated_list(
+		struct cgroup_subsys_state *root, int cpu)
 {
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
-	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(root, cpu);
-	struct cgroup *head = NULL, *parent, *child;
+	struct css_rstat_cpu *rstatc = css_rstat_cpu(root, cpu);
+	struct cgroup_subsys_state *head = NULL, *parent, *child;
 	unsigned long flags;
 
-	flags = _css_rstat_cpu_lock(cpu_lock, cpu, &root->self, false);
+	flags = _css_rstat_cpu_lock(cpu_lock, cpu, root, false);
 
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
@@ -251,17 +260,17 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
 	 * Unlink @root from its parent. As the updated_children list is
 	 * singly linked, we have to walk it to find the removal point.
 	 */
-	parent = cgroup_parent(root);
+	parent = root->parent;
 	if (parent) {
-		struct cgroup_rstat_cpu *prstatc;
-		struct cgroup **nextp;
+		struct css_rstat_cpu *prstatc;
+		struct cgroup_subsys_state **nextp;
 
-		prstatc = cgroup_rstat_cpu(parent, cpu);
+		prstatc = css_rstat_cpu(parent, cpu);
 		nextp = &prstatc->updated_children;
 		while (*nextp != root) {
-			struct cgroup_rstat_cpu *nrstatc;
+			struct css_rstat_cpu *nrstatc;
 
-			nrstatc = cgroup_rstat_cpu(*nextp, cpu);
+			nrstatc = css_rstat_cpu(*nextp, cpu);
 			WARN_ON_ONCE(*nextp == parent);
 			nextp = &nrstatc->updated_next;
 		}
@@ -276,9 +285,9 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
 	child = rstatc->updated_children;
 	rstatc->updated_children = root;
 	if (child != root)
-		head = cgroup_rstat_push_children(head, child, cpu);
+		head = css_rstat_push_children(head, child, cpu);
 unlock_ret:
-	_css_rstat_cpu_unlock(cpu_lock, cpu, &root->self, flags, false);
+	_css_rstat_cpu_unlock(cpu_lock, cpu, root, flags, false);
 	return head;
 }
 
@@ -339,41 +348,44 @@ static inline void __css_rstat_unlock(struct cgroup_subsys_state *css,
 }
 
 /**
- * css_rstat_flush - flush stats in @css->cgroup's subtree
+ * css_rstat_flush - flush stats in @css's rstat subtree
  * @css: target cgroup subsystem state
  *
- * Collect all per-cpu stats in @css->cgroup's subtree into the global counters
- * and propagate them upwards.  After this function returns, all cgroups in
- * the subtree have up-to-date ->stat.
+ * Collect all per-cpu stats in @css's subtree into the global counters
+ * and propagate them upwards. After this function returns, all rstat
+ * nodes in the subtree have up-to-date ->stat.
  *
- * This also gets all cgroups in the subtree including @css->cgroup off the
+ * This also gets all rstat nodes in the subtree including @css off the
  * ->updated_children lists.
  *
  * This function may block.
  */
 __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
 {
-	struct cgroup *cgrp = css->cgroup;
 	int cpu;
+	bool is_self = css_is_self(css);
+
+	/*
+	 * Since bpf programs can call this function, prevent access to
+	 * uninitialized rstat pointers.
+	 */
+	if (!is_self && css->ss->css_rstat_flush == NULL)
+		return;
 
 	might_sleep();
 	for_each_possible_cpu(cpu) {
-		struct cgroup *pos;
+		struct cgroup_subsys_state *pos;
 
 		/* Reacquire for each CPU to avoid disabling IRQs too long */
 		__css_rstat_lock(css, cpu);
-		pos = cgroup_rstat_updated_list(cgrp, cpu);
+		pos = css_rstat_updated_list(css, cpu);
 		for (; pos; pos = pos->rstat_flush_next) {
-			struct cgroup_subsys_state *css;
-
-			cgroup_base_stat_flush(pos, cpu);
-			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
-
-			rcu_read_lock();
-			list_for_each_entry_rcu(css, &pos->rstat_css_list,
-						rstat_css_node)
-				css->ss->css_rstat_flush(css, cpu);
-			rcu_read_unlock();
+			if (is_self) {
+				cgroup_base_stat_flush(pos->cgroup, cpu);
+				bpf_rstat_flush(pos->cgroup,
+						cgroup_parent(pos->cgroup), cpu);
+			} else
+				pos->ss->css_rstat_flush(pos, cpu);
 		}
 		__css_rstat_unlock(css, cpu);
 		if (!cond_resched())
@@ -385,30 +397,41 @@ int css_rstat_init(struct cgroup_subsys_state *css)
 {
 	struct cgroup *cgrp = css->cgroup;
 	int cpu;
+	bool is_self = css_is_self(css);
 
-	/* the root cgrp has rstat_cpu preallocated */
-	if (!cgrp->rstat_cpu) {
-		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
-		if (!cgrp->rstat_cpu)
-			return -ENOMEM;
-	}
-
-	if (!cgrp->rstat_base_cpu) {
-		cgrp->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
+	if (is_self) {
+		/* the root cgrp has rstat_base_cpu preallocated */
 		if (!cgrp->rstat_base_cpu) {
-			free_percpu(cgrp->rstat_cpu);
+			cgrp->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
+			if (!cgrp->rstat_base_cpu)
+				return -ENOMEM;
+		}
+	} else if (css->ss->css_rstat_flush == NULL)
+		return 0;
+
+	/* the root cgrp's self css has rstat_cpu preallocated */
+	if (!css->rstat_cpu) {
+		css->rstat_cpu = alloc_percpu(struct css_rstat_cpu);
+		if (!css->rstat_cpu) {
+			if (is_self)
+				free_percpu(cgrp->rstat_base_cpu);
+
 			return -ENOMEM;
 		}
 	}
 
 	/* ->updated_children list is self terminated */
 	for_each_possible_cpu(cpu) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
-		struct cgroup_rstat_base_cpu *rstatbc =
-			cgroup_rstat_base_cpu(cgrp, cpu);
+		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
 
-		rstatc->updated_children = cgrp;
-		u64_stats_init(&rstatbc->bsync);
+		rstatc->updated_children = css;
+
+		if (is_self) {
+			struct cgroup_rstat_base_cpu *rstatbc;
+
+			rstatbc = cgroup_rstat_base_cpu(cgrp, cpu);
+			u64_stats_init(&rstatbc->bsync);
+		}
 	}
 
 	return 0;
@@ -416,24 +439,31 @@ int css_rstat_init(struct cgroup_subsys_state *css)
 
 void css_rstat_exit(struct cgroup_subsys_state *css)
 {
-	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
-	css_rstat_flush(&cgrp->self);
+	if (!css_is_self(css) && css->ss->css_rstat_flush == NULL)
+		return;
+
+	css_rstat_flush(css);
 
 	/* sanity check */
 	for_each_possible_cpu(cpu) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
 
-		if (WARN_ON_ONCE(rstatc->updated_children != cgrp) ||
+		if (WARN_ON_ONCE(rstatc->updated_children != css) ||
 		    WARN_ON_ONCE(rstatc->updated_next))
 			return;
 	}
 
-	free_percpu(cgrp->rstat_cpu);
-	cgrp->rstat_cpu = NULL;
-	free_percpu(cgrp->rstat_base_cpu);
-	cgrp->rstat_base_cpu = NULL;
+	if (css_is_self(css)) {
+		struct cgroup *cgrp = css->cgroup;
+
+		free_percpu(cgrp->rstat_base_cpu);
+		cgrp->rstat_base_cpu = NULL;
+	}
+
+	free_percpu(css->rstat_cpu);
+	css->rstat_cpu = NULL;
 }
 
 void __init cgroup_rstat_boot(void)
diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
index 38f78d9345de..69f81cb555ca 100644
--- a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
@@ -30,22 +30,27 @@ int BPF_PROG(test_percpu2, struct bpf_testmod_btf_type_tag_2 *arg)
 
 /* trace_cgroup_mkdir(struct cgroup *cgrp, const char *path)
  *
- * struct cgroup_rstat_cpu {
+ * struct css_rstat_cpu {
  *   ...
- *   struct cgroup *updated_children;
+ *   struct cgroup_subsys_state *updated_children;
  *   ...
  * };
  *
- * struct cgroup {
+ * struct cgroup_subsys_state {
+ *   ...
+ *   struct css_rstat_cpu __percpu *rstat_cpu;
  *   ...
- *   struct cgroup_rstat_cpu __percpu *rstat_cpu;
+ * };
+ *
+ * struct cgroup {
+ *   struct cgroup_subsys_state self;
  *   ...
  * };
  */
 SEC("tp_btf/cgroup_mkdir")
 int BPF_PROG(test_percpu_load, struct cgroup *cgrp, const char *path)
 {
-	g = (__u64)cgrp->rstat_cpu->updated_children;
+	g = (__u64)cgrp->self.rstat_cpu->updated_children;
 	return 0;
 }
 
@@ -56,7 +61,8 @@ int BPF_PROG(test_percpu_helper, struct cgroup *cgrp, const char *path)
 	__u32 cpu;
 
 	cpu = bpf_get_smp_processor_id();
-	rstat = (struct cgroup_rstat_cpu *)bpf_per_cpu_ptr(cgrp->rstat_cpu, cpu);
+	rstat = (struct cgroup_rstat_cpu *)bpf_per_cpu_ptr(
+			cgrp->self.rstat_cpu, cpu);
 	if (rstat) {
 		/* READ_ONCE */
 		*(volatile int *)rstat;
-- 
2.47.1


