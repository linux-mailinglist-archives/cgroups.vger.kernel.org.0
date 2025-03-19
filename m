Return-Path: <cgroups+bounces-7181-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883D9A69BE4
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 23:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96E648433E
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 22:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150A921C165;
	Wed, 19 Mar 2025 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EenY6oty"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EFD21ADD3
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422633; cv=none; b=LkvN42lbP41Yh2+FHCGN4tXMx5ZSaJVWDCYOsAAQSVKnGnaGA0gcVn0CUVqSpay++YXP1gUv3C2MhWJkxJ1S2GIeJJ1ZkPJ01FmCjnM5O4bXSPV3kXMmndvxNhALAbsv6CUG35D1PyZAZXEa4Jqfio6i5xsFMkgm/E7GX8jbQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422633; c=relaxed/simple;
	bh=IFV1AtlSCpV28d/m+2XDMULg2HmZHGyfxHmW1CcTKNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSr/MLTAsxmw6VT7kS6gr89cKGifEq09E0DdOZoURnUYFucG0jtLCFkDop+oKHPlb8sUpMUlq9Yzdldu6WGH3J5g48HrgVGLKTB29FRgmoV/ybNbS7qTYNdc1NxBE+bRV5ox9KWOTS6IoMQCLuPZNDF0SHbm4HPVX/VBscBgtsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EenY6oty; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223a7065ff8so1722585ad.0
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 15:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742422630; x=1743027430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddAcUsPMaGKNvVLTpfP1DRbRXL6vfAD6mKCpTB6XO+A=;
        b=EenY6otylG43zT0vA7yG/muecx5FOjSXs2QJ8IL/iInPe3AYUi7d9w9LQT+12s9Qct
         YFFlmnFQwqT6IcZdoJ8ZRGqQbEgN6eKWxBfxyM21cYYzNeO0NsBCujNHXDuoMJEK8jwF
         Wnqt8mL5RK7EUyolnyMVp0VnoTOtNotJsoJ6Q1O35leOiKkLK7NcTOpb7UidnKd9KDEY
         zZab49nPDrX8Uof6oy/PAhxYlHIXq9wsopNDqozZU2/sE17Pc7NSbYh0cy4NClur8nTu
         6WsiyBik3rIeDCjjQZaI6ZL3WYgUEnxE1iTIJOtA3BBEp9g4M9MfYB59zQtlVwAGzD2w
         lN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422630; x=1743027430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddAcUsPMaGKNvVLTpfP1DRbRXL6vfAD6mKCpTB6XO+A=;
        b=hTH3wx8Lwyhr/KrLgHLL36u281V1xFWwE8q2a5baTQ04yPOoXPFTnNAcL6d5ypsedl
         M/R9PwjiG8uuZeXU+20lJF6f1yC3ioJbK0iWH5Lw+MuW3UFRsjJ/NIXDfEEiIxJm9lQJ
         14aNskx25zAz6oojoDGq7+yUoWcjT+Qfg1iTCbC/BEbTOqp8lFcd0j0m9xKIUI7lvmh7
         /YI4LDKtPrqdTA9AGU8KLdOq1Vjv71nCDyccDWzLuowCHH8aOgiQkPQkx6xFrU26GQPd
         9O+3sQn/VoThYDGpqG/F5ejE1Gd+r3HidgxNvRKyWEu8byVj9g7Cmf77N+GHFyaNvK/L
         H0/A==
X-Forwarded-Encrypted: i=1; AJvYcCXyLjPX5Cl3EbivicLuIWuObPR9ULWTVDG4JYeMYvbi8mFoo9CfGy5m7wEtptomPoWFhStZMYwT@vger.kernel.org
X-Gm-Message-State: AOJu0YyV91wPT6Rc023gWN1c4Ob78hsnnqct9vwFwoJ/LfMHnIo6S7C9
	Vxaa2G6n8bWxf2E00UuLFlQm//6C6ClVtxqz22DLjx6W2XKDSpZi
X-Gm-Gg: ASbGnctSvAMvpiCJnJXN9OCYY5rtvLu+q2tUCurG9Ktcpv1J8Q5Z9O5E30+7jGnYlt6
	5Kyfund95sq1yEzjAUugSgw+LYxbQNIsKcac8xMD1YXT6JUIMQp0G/9hlU/oyCqwDTnmF31ECY0
	wctq6hAj3zbqh6miR1FxC9ouXx8rkSysqydgl9i/zTEKEJdTs1ZiqQLo84buqCktzvX28zM31Z3
	7Kk1PCHy1iM6dzpZLr4PvFTL774wA8uih9QPx+yuvI6GcneFswmfC2wUeQirvyzmJ3JtR7mzTz4
	M6+fJuq48A2sRuc0J0MqMFgAg1YoGxOuLkWLaYUHmbGYsXE87OYp9v+sKrYVcXRnqCr7dHvZqas
	rIiBwBBQ=
X-Google-Smtp-Source: AGHT+IHRXBu4Wu5kcthmwsBMt5ij407dsQBcBPf2w/7rF4yHXT8r2oRycBVvbhFWtBGjl1BDL9dEcg==
X-Received: by 2002:a05:6a20:2d09:b0:1f5:769a:a4c3 with SMTP id adf61e73a8af0-1fbecd48275mr7330927637.27.1742422630231;
        Wed, 19 Mar 2025 15:17:10 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::4:39d5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116af372sm12253977b3a.160.2025.03.19.15.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:17:09 -0700 (PDT)
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
Subject: [PATCH 2/4] cgroup: use separate rstat trees for each subsystem
Date: Wed, 19 Mar 2025 15:16:32 -0700
Message-ID: <20250319221634.71128-3-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319221634.71128-1-inwardvessel@gmail.com>
References: <20250319221634.71128-1-inwardvessel@gmail.com>
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
the cgroup and instead place them on the css. Finally, change the
updated/flush API's to accept a reference to a css instead of a cgroup.
This allows a specific subsystem to be associated with an update or flush.
Separate rstat trees will now exist for each unique subsystem.

Since updating/flushing will now be done at the subsystem level, there is
no longer a need to keep track of updated css nodes at the cgroup level.
The list management of these nodes done within the cgroup (rstat_css_list
and related) has been removed accordingly. There was also padding in the
cgroup to keep rstat_css_list on a cacheline different from
rstat_flush_next and the base stats. This padding has also been removed.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 block/blk-cgroup.c                            |   4 +-
 include/linux/cgroup-defs.h                   |  41 ++--
 include/linux/cgroup.h                        |  13 +-
 kernel/cgroup/cgroup-internal.h               |   4 +-
 kernel/cgroup/cgroup.c                        |  63 +++---
 kernel/cgroup/rstat.c                         | 212 +++++++++---------
 mm/memcontrol.c                               |   4 +-
 .../selftests/bpf/progs/btf_type_tag_percpu.c |   5 +-
 8 files changed, 177 insertions(+), 169 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9ed93d91d754..cd9521f4f607 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1201,7 +1201,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	if (!seq_css(sf)->parent)
 		blkcg_fill_root_iostats();
 	else
-		cgroup_rstat_flush(blkcg->css.cgroup);
+		css_rstat_flush(&blkcg->css);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
@@ -2186,7 +2186,7 @@ void blk_cgroup_bio_start(struct bio *bio)
 	}
 
 	u64_stats_update_end_irqrestore(&bis->sync, flags);
-	cgroup_rstat_updated(blkcg->css.cgroup, cpu);
+	css_rstat_updated(&blkcg->css, cpu);
 	put_cpu();
 }
 
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 17960a1e858d..031f55a9ac49 100644
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
+	 * cgroup_rstat_flush_locked() and protected by cgroup_rstat_lock.
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
@@ -347,7 +354,7 @@ struct cgroup_base_stat {
  * updated_children and updated_next - and the fields which track basic
  * resource statistics on top of it - bsync, bstat and last_bstat.
  */
-struct cgroup_rstat_cpu {
+struct css_rstat_cpu {
 	/*
 	 * ->bsync protects ->bstat.  These are the only fields which get
 	 * updated in the hot path.
@@ -386,8 +393,8 @@ struct cgroup_rstat_cpu {
 	 *
 	 * Protected by per-cpu cgroup_rstat_cpu_lock.
 	 */
-	struct cgroup *updated_children;	/* terminated by self cgroup */
-	struct cgroup *updated_next;		/* NULL iff not on the list */
+	struct cgroup_subsys_state *updated_children;	/* terminated by self */
+	struct cgroup_subsys_state *updated_next;	/* NULL if not on list */
 };
 
 struct cgroup_freezer_state {
@@ -516,24 +523,6 @@ struct cgroup {
 	struct cgroup *dom_cgrp;
 	struct cgroup *old_dom_cgrp;		/* used while enabling threaded */
 
-	/* per-cpu recursive resource statistics */
-	struct cgroup_rstat_cpu __percpu *rstat_cpu;
-	struct list_head rstat_css_list;
-
-	/*
-	 * Add padding to separate the read mostly rstat_cpu and
-	 * rstat_css_list into a different cacheline from the following
-	 * rstat_flush_next and *bstat fields which can have frequent updates.
-	 */
-	CACHELINE_PADDING(_pad_);
-
-	/*
-	 * A singly-linked list of cgroup structures to be rstat flushed.
-	 * This is a scratch field to be used exclusively by
-	 * cgroup_rstat_flush_locked() and protected by cgroup_rstat_lock.
-	 */
-	struct cgroup	*rstat_flush_next;
-
 	/* cgroup basic resource statistics */
 	struct cgroup_base_stat last_bstat;
 	struct cgroup_base_stat bstat;
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 13fd82a4336d..4e71ae9858d3 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -346,6 +346,11 @@ static inline bool css_is_dying(struct cgroup_subsys_state *css)
 	return !(css->flags & CSS_NO_REF) && percpu_ref_is_dying(&css->refcnt);
 }
 
+static inline bool css_is_cgroup(struct cgroup_subsys_state *css)
+{
+	return css->ss == NULL;
+}
+
 static inline void cgroup_get(struct cgroup *cgrp)
 {
 	css_get(&cgrp->self);
@@ -687,10 +692,10 @@ static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 /*
  * cgroup scalable recursive statistics.
  */
-void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
-void cgroup_rstat_flush(struct cgroup *cgrp);
-void cgroup_rstat_flush_hold(struct cgroup *cgrp);
-void cgroup_rstat_flush_release(struct cgroup *cgrp);
+void css_rstat_updated(struct cgroup_subsys_state *css, int cpu);
+void css_rstat_flush(struct cgroup_subsys_state *css);
+void css_rstat_flush_hold(struct cgroup_subsys_state *css);
+void css_rstat_flush_release(struct cgroup_subsys_state *css);
 
 void bpf_cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
 void bpf_cgroup_rstat_flush(struct cgroup *cgrp);
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c964dd7ff967..d4b75fba9a54 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -269,8 +269,8 @@ int cgroup_task_count(const struct cgroup *cgrp);
 /*
  * rstat.c
  */
-int cgroup_rstat_init(struct cgroup *cgrp);
-void cgroup_rstat_exit(struct cgroup *cgrp);
+int css_rstat_init(struct cgroup_subsys_state *css);
+void css_rstat_exit(struct cgroup_subsys_state *css);
 void cgroup_rstat_boot(void);
 void cgroup_base_stat_cputime_show(struct seq_file *seq);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index afc665b7b1fe..1e21065dec0e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -161,10 +161,12 @@ static struct static_key_true *cgroup_subsys_on_dfl_key[] = {
 };
 #undef SUBSYS
 
-static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);
+static DEFINE_PER_CPU(struct css_rstat_cpu, root_self_rstat_cpu);
 
 /* the default hierarchy */
-struct cgroup_root cgrp_dfl_root = { .cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
+struct cgroup_root cgrp_dfl_root = {
+	.cgrp.self.rstat_cpu = &root_self_rstat_cpu
+};
 EXPORT_SYMBOL_GPL(cgrp_dfl_root);
 
 /*
@@ -1358,7 +1360,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 
 	cgroup_unlock();
 
-	cgroup_rstat_exit(cgrp);
+	css_rstat_exit(&cgrp->self);
 	kernfs_destroy_root(root->kf_root);
 	cgroup_free_root(root);
 }
@@ -1863,13 +1865,6 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
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
@@ -2052,7 +2047,6 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 	cgrp->dom_cgrp = cgrp;
 	cgrp->max_descendants = INT_MAX;
 	cgrp->max_depth = INT_MAX;
-	INIT_LIST_HEAD(&cgrp->rstat_css_list);
 	prev_cputime_init(&cgrp->prev_cputime);
 
 	for_each_subsys(ss, ssid)
@@ -2132,7 +2126,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	if (ret)
 		goto destroy_root;
 
-	ret = cgroup_rstat_init(root_cgrp);
+	ret = css_rstat_init(&root_cgrp->self);
 	if (ret)
 		goto destroy_root;
 
@@ -2174,7 +2168,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	goto out;
 
 exit_stats:
-	cgroup_rstat_exit(root_cgrp);
+	css_rstat_exit(&root_cgrp->self);
 destroy_root:
 	kernfs_destroy_root(root->kf_root);
 	root->kf_root = NULL;
@@ -5407,6 +5401,9 @@ static void css_free_rwork_fn(struct work_struct *work)
 		struct cgroup_subsys_state *parent = css->parent;
 		int id = css->id;
 
+		if (ss->css_rstat_flush)
+			css_rstat_exit(css);
+
 		ss->css_free(css);
 		cgroup_idr_remove(&ss->css_idr, id);
 		cgroup_put(cgrp);
@@ -5431,7 +5428,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 			cgroup_put(cgroup_parent(cgrp));
 			kernfs_put(cgrp->kn);
 			psi_cgroup_free(cgrp);
-			cgroup_rstat_exit(cgrp);
+			css_rstat_exit(&cgrp->self);
 			kfree(cgrp);
 		} else {
 			/*
@@ -5459,11 +5456,8 @@ static void css_release_work_fn(struct work_struct *work)
 	if (ss) {
 		struct cgroup *parent_cgrp;
 
-		/* css release path */
-		if (!list_empty(&css->rstat_css_node)) {
-			cgroup_rstat_flush(cgrp);
-			list_del_rcu(&css->rstat_css_node);
-		}
+		if (ss->css_rstat_flush)
+			css_rstat_flush(css);
 
 		cgroup_idr_replace(&ss->css_idr, NULL, css->id);
 		if (ss->css_released)
@@ -5489,7 +5483,7 @@ static void css_release_work_fn(struct work_struct *work)
 		/* cgroup release path */
 		TRACE_CGROUP_PATH(release, cgrp);
 
-		cgroup_rstat_flush(cgrp);
+		css_rstat_flush(&cgrp->self);
 
 		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
@@ -5537,7 +5531,6 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 	css->id = -1;
 	INIT_LIST_HEAD(&css->sibling);
 	INIT_LIST_HEAD(&css->children);
-	INIT_LIST_HEAD(&css->rstat_css_node);
 	css->serial_nr = css_serial_nr_next++;
 	atomic_set(&css->online_cnt, 0);
 
@@ -5546,9 +5539,6 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 		css_get(css->parent);
 	}
 
-	if (ss->css_rstat_flush)
-		list_add_rcu(&css->rstat_css_node, &cgrp->rstat_css_list);
-
 	BUG_ON(cgroup_css(cgrp, ss));
 }
 
@@ -5641,6 +5631,12 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
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
@@ -5654,7 +5650,6 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 err_list_del:
 	list_del_rcu(&css->sibling);
 err_free_css:
-	list_del_rcu(&css->rstat_css_node);
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
 	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
 	return ERR_PTR(err);
@@ -5682,7 +5677,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	if (ret)
 		goto out_free_cgrp;
 
-	ret = cgroup_rstat_init(cgrp);
+	ret = css_rstat_init(&cgrp->self);
 	if (ret)
 		goto out_cancel_ref;
 
@@ -5775,7 +5770,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 out_kernfs_remove:
 	kernfs_remove(cgrp->kn);
 out_stat_exit:
-	cgroup_rstat_exit(cgrp);
+	css_rstat_exit(&cgrp->self);
 out_cancel_ref:
 	percpu_ref_exit(&cgrp->self.refcnt);
 out_free_cgrp:
@@ -6082,11 +6077,16 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 	css->flags |= CSS_NO_REF;
 
 	if (early) {
-		/* allocation can't be done safely during early init */
+		/* allocation can't be done safely during early init.
+		 * defer idr and rstat allocations until cgroup_init().
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
@@ -6185,9 +6185,16 @@ int __init cgroup_init(void)
 			struct cgroup_subsys_state *css =
 				init_css_set.subsys[ss->id];
 
+			/* it is now safe to perform allocations.
+			 * finish setting up subsystems that previously
+			 * deferred idr and rstat allocations.
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
index 0d66cfc53061..a28c00b11736 100644
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
 
 /*
@@ -74,16 +75,17 @@ void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
 }
 
 /**
- * cgroup_rstat_updated - keep track of updated rstat_cpu
- * @cgrp: target cgroup
+ * css_rstat_updated - keep track of updated rstat_cpu
+ * @css: target cgroup subsystem state
  * @cpu: cpu on which rstat_cpu was updated
  *
- * @cgrp's rstat_cpu on @cpu was updated.  Put it on the parent's matching
+ * @css's rstat_cpu on @cpu was updated. Put it on the parent's matching
  * rstat_cpu->updated_children list.  See the comment on top of
- * cgroup_rstat_cpu definition for details.
+ * css_rstat_cpu definition for details.
  */
-void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
+void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
+	struct cgroup *cgrp = css->cgroup;
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
 
@@ -92,19 +94,19 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
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
 
 	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
 
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
@@ -115,15 +117,15 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 
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
 
 	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, true);
@@ -131,7 +133,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 
 __bpf_kfunc void bpf_cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 {
-	cgroup_rstat_updated(cgrp, cpu);
+	css_rstat_updated(&cgrp->self, cpu);
 }
 
 /**
@@ -141,18 +143,19 @@ __bpf_kfunc void bpf_cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
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
+static struct cgroup_subsys_state *cgroup_rstat_push_children(
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
 
@@ -160,13 +163,13 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
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
@@ -188,31 +191,33 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
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
+	struct cgroup *cgrp = root->cgroup;
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
-	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(root, cpu);
-	struct cgroup *head = NULL, *parent, *child;
+	struct css_rstat_cpu *rstatc = css_rstat_cpu(root, cpu);
+	struct cgroup_subsys_state *head = NULL, *parent, *child;
 	unsigned long flags;
 
-	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, root, false);
+	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, false);
 
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
@@ -222,17 +227,17 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
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
@@ -249,14 +254,14 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
 	if (child != root)
 		head = cgroup_rstat_push_children(head, child, cpu);
 unlock_ret:
-	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, root, flags, false);
+	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, false);
 	return head;
 }
 
 /*
  * A hook for bpf stat collectors to attach to and flush their stats.
- * Together with providing bpf kfuncs for cgroup_rstat_updated() and
- * cgroup_rstat_flush(), this enables a complete workflow where bpf progs that
+ * Together with providing bpf kfuncs for css_rstat_updated() and
+ * css_rstat_flush(), this enables a complete workflow where bpf progs that
  * collect cgroup stats can integrate with rstat for efficient flushing.
  *
  * A static noinline declaration here could cause the compiler to optimize away
@@ -304,28 +309,26 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
-/* see cgroup_rstat_flush() */
-static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
+/* see css_rstat_flush() */
+static void css_rstat_flush_locked(struct cgroup_subsys_state *css)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
 {
+	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
+		struct cgroup_subsys_state *pos;
 
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
+			if (css_is_cgroup(pos)) {
+				cgroup_base_stat_flush(pos->cgroup, cpu);
+				bpf_rstat_flush(pos->cgroup,
+						cgroup_parent(pos->cgroup), cpu);
+			} else if (pos->ss->css_rstat_flush)
+				pos->ss->css_rstat_flush(pos, cpu);
 		}
 
 		/* play nice and yield if necessary */
@@ -339,98 +342,101 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 }
 
 /**
- * cgroup_rstat_flush - flush stats in @cgrp's subtree
- * @cgrp: target cgroup
+ * css_rstat_flush - flush stats in @css's rstat subtree
+ * @css: target cgroup subsystem state
  *
- * Collect all per-cpu stats in @cgrp's subtree into the global counters
- * and propagate them upwards.  After this function returns, all cgroups in
- * the subtree have up-to-date ->stat.
+ * Collect all per-cpu stats in @css's subtree into the global counters
+ * and propagate them upwards. After this function returns, all rstat
+ * nodes in the subtree have up-to-date ->stat.
  *
- * This also gets all cgroups in the subtree including @cgrp off the
+ * This also gets all rstat nodes in the subtree including @css off the
  * ->updated_children lists.
  *
  * This function may block.
  */
-void cgroup_rstat_flush(struct cgroup *cgrp)
+void css_rstat_flush(struct cgroup_subsys_state *css)
 {
+	struct cgroup *cgrp = css->cgroup;
+
 	might_sleep();
 
 	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
+	css_rstat_flush_locked(css);
 	__cgroup_rstat_unlock(cgrp, -1);
 }
 
 __bpf_kfunc void bpf_cgroup_rstat_flush(struct cgroup *cgrp)
 {
-	cgroup_rstat_flush(cgrp);
+	css_rstat_flush(&cgrp->self);
 }
 
 /**
- * cgroup_rstat_flush_hold - flush stats in @cgrp's subtree and hold
- * @cgrp: target cgroup
+ * css_rstat_flush_hold - flush stats in @css's rstat subtree and hold
+ * @css: target subsystem state
  *
- * Flush stats in @cgrp's subtree and prevent further flushes.  Must be
- * paired with cgroup_rstat_flush_release().
+ * Flush stats in @css's rstat subtree and prevent further flushes. Must be
+ * paired with css_rstat_flush_release().
  *
  * This function may block.
  */
-void cgroup_rstat_flush_hold(struct cgroup *cgrp)
-	__acquires(&cgroup_rstat_lock)
+void css_rstat_flush_hold(struct cgroup_subsys_state *css)
 {
+	struct cgroup *cgrp = css->cgroup;
+
 	might_sleep();
 	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
+	css_rstat_flush_locked(css);
 }
 
 /**
- * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
- * @cgrp: cgroup used by tracepoint
+ * css_rstat_flush_release - release css_rstat_flush_hold()
+ * @css: css that was previously used for the call to flush hold
  */
-void cgroup_rstat_flush_release(struct cgroup *cgrp)
-	__releases(&cgroup_rstat_lock)
+void css_rstat_flush_release(struct cgroup_subsys_state *css)
 {
+	struct cgroup *cgrp = css->cgroup;
 	__cgroup_rstat_unlock(cgrp, -1);
 }
 
-int cgroup_rstat_init(struct cgroup *cgrp)
+int css_rstat_init(struct cgroup_subsys_state *css)
 {
 	int cpu;
 
-	/* the root cgrp has rstat_cpu preallocated */
-	if (!cgrp->rstat_cpu) {
-		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
-		if (!cgrp->rstat_cpu)
+	/* the root cgrp's self css has rstat_cpu preallocated */
+	if (!css->rstat_cpu) {
+		css->rstat_cpu = alloc_percpu(struct css_rstat_cpu);
+		if (!css->rstat_cpu)
 			return -ENOMEM;
 	}
 
 	/* ->updated_children list is self terminated */
 	for_each_possible_cpu(cpu) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
 
-		rstatc->updated_children = cgrp;
+		rstatc->updated_children = css;
 		u64_stats_init(&rstatc->bsync);
 	}
 
 	return 0;
 }
 
-void cgroup_rstat_exit(struct cgroup *cgrp)
+void css_rstat_exit(struct cgroup_subsys_state *css)
 {
 	int cpu;
 
-	cgroup_rstat_flush(cgrp);
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
+	free_percpu(css->rstat_cpu);
+	css->rstat_cpu = NULL;
 }
 
 void __init cgroup_rstat_boot(void)
@@ -471,9 +477,9 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
-	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+	struct css_rstat_cpu *rstatc = css_rstat_cpu(&cgrp->self, cpu);
 	struct cgroup *parent = cgroup_parent(cgrp);
-	struct cgroup_rstat_cpu *prstatc;
+	struct css_rstat_cpu *prstatc;
 	struct cgroup_base_stat delta;
 	unsigned seq;
 
@@ -501,35 +507,35 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
 
 		delta = rstatc->subtree_bstat;
-		prstatc = cgroup_rstat_cpu(parent, cpu);
+		prstatc = css_rstat_cpu(&parent->self, cpu);
 		cgroup_base_stat_sub(&delta, &rstatc->last_subtree_bstat);
 		cgroup_base_stat_add(&prstatc->subtree_bstat, &delta);
 		cgroup_base_stat_add(&rstatc->last_subtree_bstat, &delta);
 	}
 }
 
-static struct cgroup_rstat_cpu *
+static struct css_rstat_cpu *
 cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp, unsigned long *flags)
 {
-	struct cgroup_rstat_cpu *rstatc;
+	struct css_rstat_cpu *rstatc;
 
-	rstatc = get_cpu_ptr(cgrp->rstat_cpu);
+	rstatc = get_cpu_ptr(cgrp->self.rstat_cpu);
 	*flags = u64_stats_update_begin_irqsave(&rstatc->bsync);
 	return rstatc;
 }
 
 static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
-						 struct cgroup_rstat_cpu *rstatc,
+						 struct css_rstat_cpu *rstatc,
 						 unsigned long flags)
 {
 	u64_stats_update_end_irqrestore(&rstatc->bsync, flags);
-	cgroup_rstat_updated(cgrp, smp_processor_id());
+	css_rstat_updated(&cgrp->self, smp_processor_id());
 	put_cpu_ptr(rstatc);
 }
 
 void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
 {
-	struct cgroup_rstat_cpu *rstatc;
+	struct css_rstat_cpu *rstatc;
 	unsigned long flags;
 
 	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
@@ -540,7 +546,7 @@ void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
 void __cgroup_account_cputime_field(struct cgroup *cgrp,
 				    enum cpu_usage_stat index, u64 delta_exec)
 {
-	struct cgroup_rstat_cpu *rstatc;
+	struct css_rstat_cpu *rstatc;
 	unsigned long flags;
 
 	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
@@ -625,12 +631,12 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	u64 usage, utime, stime, ntime;
 
 	if (cgroup_parent(cgrp)) {
-		cgroup_rstat_flush_hold(cgrp);
+		css_rstat_flush_hold(&cgrp->self);
 		usage = cgrp->bstat.cputime.sum_exec_runtime;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
 			       &utime, &stime);
 		ntime = cgrp->bstat.ntime;
-		cgroup_rstat_flush_release(cgrp);
+		css_rstat_flush_release(&cgrp->self);
 	} else {
 		/* cgrp->bstat of root is not actually used, reuse it */
 		root_cgroup_cputime(&cgrp->bstat);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4de6acb9b8ec..fe86d7efe372 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -579,7 +579,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	if (!val)
 		return;
 
-	cgroup_rstat_updated(memcg->css.cgroup, cpu);
+	css_rstat_updated(&memcg->css, cpu);
 	statc = this_cpu_ptr(memcg->vmstats_percpu);
 	for (; statc; statc = statc->parent) {
 		stats_updates = READ_ONCE(statc->stats_updates) + abs(val);
@@ -611,7 +611,7 @@ static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
 	if (mem_cgroup_is_root(memcg))
 		WRITE_ONCE(flush_last_time, jiffies_64);
 
-	cgroup_rstat_flush(memcg->css.cgroup);
+	css_rstat_flush(&memcg->css);
 }
 
 /*
diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
index 38f78d9345de..f362f7d41b9e 100644
--- a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
@@ -45,7 +45,7 @@ int BPF_PROG(test_percpu2, struct bpf_testmod_btf_type_tag_2 *arg)
 SEC("tp_btf/cgroup_mkdir")
 int BPF_PROG(test_percpu_load, struct cgroup *cgrp, const char *path)
 {
-	g = (__u64)cgrp->rstat_cpu->updated_children;
+	g = (__u64)cgrp->self.rstat_cpu->updated_children;
 	return 0;
 }
 
@@ -56,7 +56,8 @@ int BPF_PROG(test_percpu_helper, struct cgroup *cgrp, const char *path)
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


