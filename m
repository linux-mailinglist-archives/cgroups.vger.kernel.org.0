Return-Path: <cgroups+bounces-7344-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97A7A7B55D
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 03:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95023B8999
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 01:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FBF847B;
	Fri,  4 Apr 2025 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4BCZEI3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07A2E62DA
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743729070; cv=none; b=LaRLYxL3KJ2B2ayPlWVlx8lJdmDfY2IEUB2spV6NwUYPJOL37q98HvQuQEgEq0a8bnTsfBQAR10sMhANDpkfvj0JxsRfmGRfAeTtQmVm7rbruPN6E+wxATvZMidtrd/QHBPklOCJYq+oRE3QEfVIDOpUne+J31EnkknhshUWLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743729070; c=relaxed/simple;
	bh=6Rsbh88Ep6qtm7blCiodswj1vcaRnROHuioZ7Cv2xcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AA/XNE6/FjvJtwhob9Yhlm4KcOVBAC/5gUMIvAPuo6C3nmukMAUPE7nsAzolUwndXBuTr5YJmhx19cBBRlik3LOgmf2D1uHQKibhlIOKW1FyYsr/dpbD0GBIuCK8uGNJJNOZzk/u2uRWenv7HgczlSgAFRRHyH51tXCOFclI+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4BCZEI3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22548a28d0cso20062815ad.3
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743729068; x=1744333868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqaM5+KpYwfhg0VyKx0y/YenXOuU0c8WVIvc8Z5rkdk=;
        b=i4BCZEI393D+7spztVEYQuttK1dbJaSKYZkHjfRplK/phetsHEbf+bAxkqo489GDLS
         m3gV8QRqdt2vTzRd5zlDLIm7qOV/pA73ZfnuufY7cZ2jliJktG7scUdDK/wNcaBVqVW7
         3skFSwlFu/HEktK8TQI4TL1uJwQMK0IZTXZqb/hF4nXF5g7G9S6q28Z/kAU7aZY5O3FQ
         QRbjF9bPFDaKPrC28UbVbLflE5/Q4lM61vzF23O5wIQbM2Rfom3Zwi2bFvX4URGAylRK
         A3NyHVPU0L5OcD67uaDh5s8OuToAQQ4dBsqrqEl7ouUQKgqJmh5VzTc8RpFMmjlH7Fxm
         mk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743729068; x=1744333868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqaM5+KpYwfhg0VyKx0y/YenXOuU0c8WVIvc8Z5rkdk=;
        b=dvs98Ec0doB7YMTrzJvtnUYisOVNu8jBzzlqgUSxu0oIpn0GprGhMLSSzU787T2VhW
         AzUZ5UHShCdHKKwgaTO5ELKz9n2vPu9m9XlJrCv93eHW8FJ2ezuqfX/NC9V6f2ZDKexj
         Cf+upsuqlR7zp8Du8TvFkdBw/lp/GR1Sv8NjDgpfIbLe2VTBKDBPl+JvtmtXgMBWYict
         sn0d0Qu5eXxMrU19DAsVZn29tNYhxgu6fFM8fNoww3Rk+fjhQbZLZTM3Xtn0uXIFu8bY
         9sq6JKhpdTGMlTkLnpe2SkImacou8kRZTc0IW+2xi7SLuqzG6Ed6ZrCtiMhU+8Jktc1B
         0YBw==
X-Forwarded-Encrypted: i=1; AJvYcCVCH57kRnoUqKAGv6ijogYqNoExhIdL3HIgUwB9wFMap18vKU3zvJrgePBqx5w+n6KhpOKj1E0i@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2p0XtBQPSwsVfW8SsC/aB+3DyI9nkAgP1UPIxlDe0HNv2Ad6X
	AT0W/B/u79eSo5cbZeX2w5LLKXM8fIzy8qVIvnOL7icSE4Lc0ENp
X-Gm-Gg: ASbGnct/D3twZ/zHG6bKgHgKrDofkXmufnRuOYn1Cd8QBpVJfE8lAJJ+owzQVSiZKnl
	K5K1xZZxpNLm92mXK16AiCclzf/NRdtFhSgxDHhXB45wasnR+pMbFM8Pqw+AKODKHMMd3ZP38Zt
	c746nw9kkvSNBkJ9YUbqk3XY0nUc8RqlcmJpVYM0dzw7H6z7gaII3MBsUX4jzPtqJNxhm1nDbmv
	YOnxgqD8djPnEauaBuUc9h53/h1rmA+RVTxplZf3VzrVQqpc4PPSKK8oq0HdgxUMx2EjtaxXgFn
	+dubBT5atCiQDwuWxm5SCrVt5++KkmDMQXbKgQNwckUk4KXu5co2CIxepD83NDouh/JmqjTP
X-Google-Smtp-Source: AGHT+IHfllF+d9854BVhBFVeYOZOTzY5DMYw/ONdxcDcij3TNvx8kEXvlT6ojHvje2Y2rAOW9PWwtg==
X-Received: by 2002:a17:902:ccd2:b0:220:e9ef:ec98 with SMTP id d9443c01a7336-22a8a85be34mr14854765ad.19.1743729067863;
        Thu, 03 Apr 2025 18:11:07 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::7:9b28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad9a0sm21268675ad.39.2025.04.03.18.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 18:11:07 -0700 (PDT)
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
Subject: [PATCH v4 4/5] cgroup: use separate rstat trees for each subsystem
Date: Thu,  3 Apr 2025 18:10:49 -0700
Message-ID: <20250404011050.121777-5-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404011050.121777-1-inwardvessel@gmail.com>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
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

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup-defs.h                   |  40 ++--
 kernel/cgroup/cgroup.c                        |  49 ++---
 kernel/cgroup/rstat.c                         | 174 +++++++++---------
 .../selftests/bpf/progs/btf_type_tag_percpu.c |  18 +-
 4 files changed, 151 insertions(+), 130 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index e4a9fb00b228..c58c21c2110a 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -169,6 +169,9 @@ struct cgroup_subsys_state {
 	/* reference count - access via css_[try]get() and css_put() */
 	struct percpu_ref refcnt;
 
+	/* per-cpu recursive resource statistics */
+	struct css_rstat_cpu __percpu *rstat_cpu;
+
 	/*
 	 * siblings list anchored at the parent's ->children
 	 *
@@ -177,9 +180,6 @@ struct cgroup_subsys_state {
 	struct list_head sibling;
 	struct list_head children;
 
-	/* flush target list anchored at cgrp->rstat_css_list */
-	struct list_head rstat_css_node;
-
 	/*
 	 * PI: Subsys-unique ID.  0 is unused and root is always 1.  The
 	 * matching css can be looked up using css_from_id().
@@ -219,6 +219,13 @@ struct cgroup_subsys_state {
 	 * Protected by cgroup_mutex.
 	 */
 	int nr_descendants;
+
+	/*
+	 * A singly-linked list of css structures to be rstat flushed.
+	 * This is a scratch field to be used exclusively by
+	 * css_rstat_flush_locked() and protected by cgroup_rstat_lock.
+	 */
+	struct cgroup_subsys_state *rstat_flush_next;
 };
 
 /*
@@ -329,10 +336,10 @@ struct cgroup_base_stat {
 
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
@@ -346,7 +353,7 @@ struct cgroup_base_stat {
  * This struct hosts both the fields which implement the above -
  * updated_children and updated_next.
  */
-struct cgroup_rstat_cpu {
+struct css_rstat_cpu {
 	/*
 	 * Child cgroups with stat updates on this cpu since the last read
 	 * are linked on the parent's ->updated_children through
@@ -358,8 +365,8 @@ struct cgroup_rstat_cpu {
 	 *
 	 * Protected by per-cpu cgroup_rstat_cpu_lock.
 	 */
-	struct cgroup *updated_children;	/* terminated by self cgroup */
-	struct cgroup *updated_next;		/* NULL iff not on the list */
+	struct cgroup_subsys_state *updated_children;	/* terminated by self cgroup */
+	struct cgroup_subsys_state *updated_next;	/* NULL iff not on the list */
 };
 
 /*
@@ -521,25 +528,16 @@ struct cgroup {
 	struct cgroup *dom_cgrp;
 	struct cgroup *old_dom_cgrp;		/* used while enabling threaded */
 
-	/* per-cpu recursive resource statistics */
-	struct cgroup_rstat_cpu __percpu *rstat_cpu;
+	/* per-cpu recursive basic resource statistics */
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
index f8cee7819642..c351b98ebd06 100644
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
@@ -1880,13 +1880,6 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
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
@@ -2069,7 +2062,6 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 	cgrp->dom_cgrp = cgrp;
 	cgrp->max_descendants = INT_MAX;
 	cgrp->max_depth = INT_MAX;
-	INIT_LIST_HEAD(&cgrp->rstat_css_list);
 	prev_cputime_init(&cgrp->prev_cputime);
 
 	for_each_subsys(ss, ssid)
@@ -5425,6 +5417,9 @@ static void css_free_rwork_fn(struct work_struct *work)
 		struct cgroup_subsys_state *parent = css->parent;
 		int id = css->id;
 
+		if (ss->css_rstat_flush)
+			css_rstat_exit(css);
+
 		ss->css_free(css);
 		cgroup_idr_remove(&ss->css_idr, id);
 		cgroup_put(cgrp);
@@ -5477,11 +5472,8 @@ static void css_release_work_fn(struct work_struct *work)
 	if (ss) {
 		struct cgroup *parent_cgrp;
 
-		/* css release path */
-		if (!list_empty(&css->rstat_css_node)) {
+		if (ss->css_rstat_flush)
 			css_rstat_flush(css);
-			list_del_rcu(&css->rstat_css_node);
-		}
 
 		cgroup_idr_replace(&ss->css_idr, NULL, css->id);
 		if (ss->css_released)
@@ -5507,7 +5499,7 @@ static void css_release_work_fn(struct work_struct *work)
 		/* cgroup release path */
 		TRACE_CGROUP_PATH(release, cgrp);
 
-		css_rstat_flush(css);
+		css_rstat_flush(&cgrp->self);
 
 		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
@@ -5555,7 +5547,6 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 	css->id = -1;
 	INIT_LIST_HEAD(&css->sibling);
 	INIT_LIST_HEAD(&css->children);
-	INIT_LIST_HEAD(&css->rstat_css_node);
 	css->serial_nr = css_serial_nr_next++;
 	atomic_set(&css->online_cnt, 0);
 
@@ -5564,9 +5555,6 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 		css_get(css->parent);
 	}
 
-	if (ss->css_rstat_flush)
-		list_add_rcu(&css->rstat_css_node, &cgrp->rstat_css_list);
-
 	BUG_ON(cgroup_css(cgrp, ss));
 }
 
@@ -5659,6 +5647,12 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 		goto err_free_css;
 	css->id = err;
 
+	if (ss->css_rstat_flush) {
+		err = css_rstat_init(css);
+		if (err)
+			goto err_free_css;
+	}
+
 	/* @css is ready to be brought online now, make it visible */
 	list_add_tail_rcu(&css->sibling, &parent_css->children);
 	cgroup_idr_replace(&ss->css_idr, css, css->id);
@@ -5672,7 +5666,6 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 err_list_del:
 	list_del_rcu(&css->sibling);
 err_free_css:
-	list_del_rcu(&css->rstat_css_node);
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
 	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
 	return ERR_PTR(err);
@@ -6104,11 +6097,17 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 	css->flags |= CSS_NO_REF;
 
 	if (early) {
-		/* allocation can't be done safely during early init */
+		/*
+		 * Allocation can't be done safely during early init.
+		 * Defer IDR and rstat allocations until cgroup_init().
+		 */
 		css->id = 1;
 	} else {
 		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
 		BUG_ON(css->id < 0);
+
+		if (ss->css_rstat_flush)
+			BUG_ON(css_rstat_init(css));
 	}
 
 	/* Update the init_css_set to contain a subsys
@@ -6207,9 +6206,17 @@ int __init cgroup_init(void)
 			struct cgroup_subsys_state *css =
 				init_css_set.subsys[ss->id];
 
+			/*
+			 * It is now safe to perform allocations.
+			 * Finish setting up subsystems that previously
+			 * deferred IDR and rstat allocations.
+			 */
 			css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2,
 						   GFP_KERNEL);
 			BUG_ON(css->id < 0);
+
+			if (ss->css_rstat_flush)
+				BUG_ON(css_rstat_init(css));
 		} else {
 			cgroup_init_subsys(ss, false);
 		}
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 5bca55b4ec15..37d9e5012b2d 100644
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
@@ -87,13 +88,12 @@ void _css_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
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
 
@@ -102,19 +102,19 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
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
@@ -125,39 +125,40 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 
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
  * Return: A new singly linked list of cgroups to be flush
  *
- * Iteratively traverse down the cgroup_rstat_cpu updated tree level by
+ * Iteratively traverse down the css_rstat_cpu updated tree level by
  * level and push all the parents first before their next level children
  * into a singly linked list built from the tail backward like "pushing"
  * cgroups into a stack. The root is pushed by the caller.
  */
-static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
-						 struct cgroup *child, int cpu)
+static struct cgroup_subsys_state *css_rstat_push_children(
+		struct cgroup_subsys_state *head,
+		struct cgroup_subsys_state *child, int cpu)
 {
-	struct cgroup *chead = child;	/* Head of child cgroup level */
-	struct cgroup *ghead = NULL;	/* Head of grandchild cgroup level */
-	struct cgroup *parent, *grandchild;
-	struct cgroup_rstat_cpu *crstatc;
+	struct cgroup_subsys_state *chead = child;	/* Head of child css level */
+	struct cgroup_subsys_state *ghead = NULL;	/* Head of grandchild css level */
+	struct cgroup_subsys_state *parent, *grandchild;
+	struct css_rstat_cpu *crstatc;
 
 	child->rstat_flush_next = NULL;
 
@@ -165,13 +166,13 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
 	while (chead) {
 		child = chead;
 		chead = child->rstat_flush_next;
-		parent = cgroup_parent(child);
+		parent = child->parent;
 
 		/* updated_next is parent cgroup terminated */
 		while (child != parent) {
 			child->rstat_flush_next = head;
 			head = child;
-			crstatc = cgroup_rstat_cpu(child, cpu);
+			crstatc = css_rstat_cpu(child, cpu);
 			grandchild = crstatc->updated_children;
 			if (grandchild != child) {
 				/* Push the grand child to the next level */
@@ -193,31 +194,32 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
 }
 
 /**
- * cgroup_rstat_updated_list - return a list of updated cgroups to be flushed
- * @root: root of the cgroup subtree to traverse
+ * css_rstat_updated_list - return a list of updated cgroups to be flushed
+ * @root: root of the css subtree to traverse
  * @cpu: target cpu
  * Return: A singly linked list of cgroups to be flushed
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
+ * child css's if not empty. Whereas updated_next is like a sibling link
+ * within the children list and terminated by the parent css. An exception
  * here is the cgroup root whose updated_next can be self terminated.
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
@@ -227,17 +229,17 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
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
@@ -252,9 +254,9 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
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
 
@@ -315,41 +317,36 @@ static inline void __css_rstat_unlock(struct cgroup_subsys_state *css,
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
+			if (css_is_cgroup(pos)) {
+				cgroup_base_stat_flush(pos->cgroup, cpu);
+				bpf_rstat_flush(pos->cgroup,
+						cgroup_parent(pos->cgroup), cpu);
+			} else if (pos->ss->css_rstat_flush)
 				css->ss->css_rstat_flush(css, cpu);
-			rcu_read_unlock();
 		}
 		__css_rstat_unlock(css, cpu);
 		if (!cond_resched())
@@ -362,29 +359,38 @@ int css_rstat_init(struct cgroup_subsys_state *css)
 	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
-	/* the root cgrp has rstat_cpu preallocated */
-	if (!cgrp->rstat_cpu) {
-		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
-		if (!cgrp->rstat_cpu)
-			return -ENOMEM;
+	/* the root cgrp has rstat_base_cpu preallocated */
+	if (css_is_cgroup(css)) {
+		if (!cgrp->rstat_base_cpu) {
+			cgrp->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
+			if (!cgrp->rstat_base_cpu)
+				return -ENOMEM;
+		}
 	}
 
-	if (!cgrp->rstat_base_cpu) {
-		cgrp->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
-		if (!cgrp->rstat_cpu) {
-			free_percpu(cgrp->rstat_cpu);
+	/* the root cgrp's self css has rstat_cpu preallocated */
+	if (!css->rstat_cpu) {
+		css->rstat_cpu = alloc_percpu(struct css_rstat_cpu);
+		if (!css->rstat_cpu) {
+			if (css_is_cgroup(css))
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
+		if (css_is_cgroup(css)) {
+			struct cgroup_rstat_base_cpu *rstatbc;
+
+			rstatbc = cgroup_rstat_base_cpu(cgrp, cpu);
+			u64_stats_init(&rstatbc->bsync);
+		}
 	}
 
 	return 0;
@@ -392,24 +398,28 @@ int css_rstat_init(struct cgroup_subsys_state *css)
 
 void css_rstat_exit(struct cgroup_subsys_state *css)
 {
-	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
-	css_rstat_flush(&cgrp->self);
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
+	if (css_is_cgroup(css)) {
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


