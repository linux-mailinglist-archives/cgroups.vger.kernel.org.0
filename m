Return-Path: <cgroups+bounces-6577-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC9DA3912C
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 04:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D773A5EF5
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 03:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB89155753;
	Tue, 18 Feb 2025 03:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxZnK7bw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94314F9D9
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 03:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848508; cv=none; b=BJpq9AFjefE7WYMS+xG4UxlyHhGelCVupmu+gg+R7MFaF0WCqmD1hgq2e0QcKkabk7oYcC0KM7VBJ3ppwcQT87B3BwSl+5S12mQSONNUy23oxlpK+c6vBjjP5omfc0MOiOfFeLyVRNSluM0DQzTXKNZgwPHexDDXeaF3Ig/mDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848508; c=relaxed/simple;
	bh=1H2A1eMhs+tR69XRqLkncY7NXOlka8mIsCpB7xXS+Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzjNtz54CQB+iRtaliRId9NcCug097iKkwKF37nySjFDo4NC1GbJyZempQ+HngrgyLcm1uwxV0WDH+TLkrgEIOQczjd/RbaDdZVqk1yb2+qoRXGghRxHCVLQxX69CcEBbAgOHFnp6j0f/Fga00eIxLdNsx0nDFgNKUhWx1ORKec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxZnK7bw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c8f38febso89553335ad.2
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 19:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739848505; x=1740453305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UwRbDpwwiM5OHo47KEwhQuET3ryRjJIsdR5W9Qkkts=;
        b=NxZnK7bwE1rrTJKktHN/nFKapE0qXtH1dvuEVwil2Vd8aOxqB1I/5cjCjaorJmotee
         66gyoRpMdb3U7hPFGQIx94A597+xvGHtXVv9LXsnYacvei4MIL3AUu36jDPBlTMB9Q+s
         xgdpxlmmNclVl+wgDJWET1of+uA5tEEbltLrAZHDyIUzFNyCPCo/xjIooiGI4n8GqAcM
         5g8py3nS83XOsNNGaWI4BhVaFK5vpvINQD1z2n7lnd0/zXMVDCKnj6r7w+Z5RVAzhE4F
         gk37a4ApB7YxrnK2oCOGy56XltDHp7lMpE9+3mZ0d3Cxp0B5awe3Rz3DiiYndLCtEXjO
         gpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739848505; x=1740453305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UwRbDpwwiM5OHo47KEwhQuET3ryRjJIsdR5W9Qkkts=;
        b=FaleboTImHnEYNf/pt8t3XxZi0GUuIOCUz5zXHIrWZa4rYSe+O4+MfvurOsv2UZ/I7
         Tw9k9s7g8AR/DtEmLTBJJ5i3oJtBjZ1mYJX48+KxpIkmcmSG4OZtWAooKRqBIsdKLK/n
         g647IDn4waCRR1gsAN3/jjO9hh7SFpZJif6dVtrHEA/7a5Z8VgoY4ctTchYZRDUkrb3N
         BLufFMIzlZFmqXBHMckNy7AxBPP+VH7eaxexGnaalICF5FT9LnUBeWr0zzYtRypSnkJu
         DZRcgTFsHL1jHnnBEnuHVz07PwbhSiIxSdSiVooqpsWNqPvjf2J/nHbG9nuFoKO6HAdf
         Zt4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUy6rr3vWDP1BUbbgafht41mYAh7g6tqVFT/HWou62Qx7ZSUFrp3aW602JXlUz9RtKmLTfNW3mN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+IyGzs1WWFsEQcxVLtx3U0wfWo1d+RPa3EOg1J2RSBvsWiVpR
	zOquQUAmeKuAeuLgf+l3zSddcpQpg00i9CirCm6BfpHfKEbT9FCU
X-Gm-Gg: ASbGncu6NH5aUpSA3uaR+dEN87at57krQCXO9TcgbImycY7N1bJk1L2BtqJhibz6LfC
	aHvd1eapIQxvvh7pYHWKp9gC5X0WNpAKYALvMAoriX3U/aQxOrDFVFGtLiDMkssLS/Ft8OkZgfG
	Uz+19WYsuQuig+0uRFv5iKejcXLbXFniax3KY8SP308DSzVd8K4J3YJASQCt35JK8elnCrHZWaA
	xDogI535zZXwr8XvwIN3VgpbxpPDV9fDgU0fJBbE9fQDK2XGS1yoBlnDDXgw4X6L5D9/uFnOCvD
	OCqcxmaohamEG8S5T+JNbC1d/5GXprByaXS/0AMvOEOZJIEPGtpu
X-Google-Smtp-Source: AGHT+IFOvjlSJbep9cTBMal2GTTkcqYRhr58+YYHWmPTnoxu5Wh1hKr9YEqq6/k/u2c1lVSxE6Idrg==
X-Received: by 2002:a05:6a20:d49b:b0:1ee:c598:7a7d with SMTP id adf61e73a8af0-1eec5987c38mr2688332637.41.1739848505171;
        Mon, 17 Feb 2025 19:15:05 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425466besm8763451b3a.9.2025.02.17.19.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:15:04 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 03/11] cgroup: move cgroup_rstat from cgroup to cgroup_subsys_state
Date: Mon, 17 Feb 2025 19:14:40 -0800
Message-ID: <20250218031448.46951-4-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218031448.46951-1-inwardvessel@gmail.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each cgroup owns a single cgroup_rstat instance. This means that a tree
of pending rstat updates can contain changes from different subsystems.
Because of this arrangement, when one subsystem is flushed via the
public api cgroup_rstat_flushed(), all other subsystems with pending
updates will also be flushed. Remove the cgroup_rstat instance from the
cgroup and instead give one instance to each cgroup_subsys_state.
Separate rstat trees will now exist for each unique subsystem. This
separation allows for subsystems to make updates and flushes without the
side effects of other subsystems. i.e. flushing the cpu stats does not
cause the memory stats to be flushed and vice versa. The change in
cgroup_rstat ownership from cgroup to cgroup_subsys_state allows for
direct flushing of the css, so the rcu list management entities and
operations previously tied to the cgroup which were used for managing a
list of subsystem states with pending flushes are removed. In terms of
client code, public api calls were changed to now accept the
cgroup_subsystem_state so that when flushing or updating, a specific
subsystem is associated with the call.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 block/blk-cgroup.c                            |   4 +-
 include/linux/cgroup-defs.h                   |  10 +-
 include/linux/cgroup.h                        |   8 +-
 kernel/cgroup/cgroup-internal.h               |   4 +-
 kernel/cgroup/cgroup.c                        |  64 ++++++----
 kernel/cgroup/rstat.c                         | 117 ++++++++++--------
 mm/memcontrol.c                               |   4 +-
 .../selftests/bpf/progs/btf_type_tag_percpu.c |   5 +-
 .../bpf/progs/cgroup_hierarchical_stats.c     |   8 +-
 9 files changed, 123 insertions(+), 101 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9ed93d91d754..6a0680d8ce6a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1201,7 +1201,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	if (!seq_css(sf)->parent)
 		blkcg_fill_root_iostats();
 	else
-		cgroup_rstat_flush(blkcg->css.cgroup);
+		cgroup_rstat_flush(&blkcg->css);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
@@ -2186,7 +2186,7 @@ void blk_cgroup_bio_start(struct bio *bio)
 	}
 
 	u64_stats_update_end_irqrestore(&bis->sync, flags);
-	cgroup_rstat_updated(blkcg->css.cgroup, cpu);
+	cgroup_rstat_updated(&blkcg->css, cpu);
 	put_cpu();
 }
 
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 6b6cc027fe70..81ec56860ee5 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -180,9 +180,6 @@ struct cgroup_subsys_state {
 	struct list_head sibling;
 	struct list_head children;
 
-	/* flush target list anchored at cgrp->rstat_css_list */
-	struct list_head rstat_css_node;
-
 	/*
 	 * PI: Subsys-unique ID.  0 is unused and root is always 1.  The
 	 * matching css can be looked up using css_from_id().
@@ -222,6 +219,9 @@ struct cgroup_subsys_state {
 	 * Protected by cgroup_mutex.
 	 */
 	int nr_descendants;
+
+	/* per-cpu recursive resource statistics */
+	struct cgroup_rstat rstat;
 };
 
 /*
@@ -444,10 +444,6 @@ struct cgroup {
 	struct cgroup *dom_cgrp;
 	struct cgroup *old_dom_cgrp;		/* used while enabling threaded */
 
-	/* per-cpu recursive resource statistics */
-	struct cgroup_rstat rstat;
-	struct list_head rstat_css_list;
-
 	/* cgroup basic resource statistics */
 	struct cgroup_base_stat last_bstat;
 	struct cgroup_base_stat bstat;
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f8ef47f8a634..eec970622419 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -687,10 +687,10 @@ static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 /*
  * cgroup scalable recursive statistics.
  */
-void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
-void cgroup_rstat_flush(struct cgroup *cgrp);
-void cgroup_rstat_flush_hold(struct cgroup *cgrp);
-void cgroup_rstat_flush_release(struct cgroup *cgrp);
+void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu);
+void cgroup_rstat_flush(struct cgroup_subsys_state *css);
+void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css);
+void cgroup_rstat_flush_release(struct cgroup_subsys_state *css);
 
 /*
  * Basic resource stats.
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 03139018da43..87d062baff90 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -269,8 +269,8 @@ int cgroup_task_count(const struct cgroup *cgrp);
 /*
  * rstat.c
  */
-int cgroup_rstat_init(struct cgroup_rstat *rstat);
-void cgroup_rstat_exit(struct cgroup_rstat *rstat);
+int cgroup_rstat_init(struct cgroup_subsys_state *css);
+void cgroup_rstat_exit(struct cgroup_subsys_state *css);
 void cgroup_rstat_boot(void);
 void cgroup_base_stat_cputime_show(struct seq_file *seq);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 02d6c11ccccb..916e9c5a1fd7 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -165,7 +165,9 @@ static struct static_key_true *cgroup_subsys_on_dfl_key[] = {
 static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);
 
 /* the default hierarchy */
-struct cgroup_root cgrp_dfl_root = { .cgrp.rstat.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
+struct cgroup_root cgrp_dfl_root = {
+	.cgrp.self.rstat.rstat_cpu = &cgrp_dfl_root_rstat_cpu
+};
 EXPORT_SYMBOL_GPL(cgrp_dfl_root);
 
 /*
@@ -1359,7 +1361,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 
 	cgroup_unlock();
 
-	cgroup_rstat_exit(&cgrp->rstat);
+	cgroup_rstat_exit(&cgrp->self);
 	kernfs_destroy_root(root->kf_root);
 	cgroup_free_root(root);
 }
@@ -1864,13 +1866,6 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
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
@@ -2053,7 +2048,6 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 	cgrp->dom_cgrp = cgrp;
 	cgrp->max_descendants = INT_MAX;
 	cgrp->max_depth = INT_MAX;
-	INIT_LIST_HEAD(&cgrp->rstat_css_list);
 	prev_cputime_init(&cgrp->prev_cputime);
 
 	for_each_subsys(ss, ssid)
@@ -2133,7 +2127,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	if (ret)
 		goto destroy_root;
 
-	ret = cgroup_rstat_init(&root_cgrp->rstat);
+	ret = cgroup_rstat_init(&root_cgrp->self);
 	if (ret)
 		goto destroy_root;
 
@@ -2175,7 +2169,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	goto out;
 
 exit_stats:
-	cgroup_rstat_exit(&root_cgrp->rstat);
+	cgroup_rstat_exit(&root_cgrp->self);
 destroy_root:
 	kernfs_destroy_root(root->kf_root);
 	root->kf_root = NULL;
@@ -3240,6 +3234,12 @@ static int cgroup_apply_control_enable(struct cgroup *cgrp)
 				css = css_create(dsct, ss);
 				if (IS_ERR(css))
 					return PTR_ERR(css);
+
+				if (css->ss && css->ss->css_rstat_flush) {
+					ret = cgroup_rstat_init(css);
+					if (ret)
+						goto err_out;
+				}
 			}
 
 			WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));
@@ -3253,6 +3253,21 @@ static int cgroup_apply_control_enable(struct cgroup *cgrp)
 	}
 
 	return 0;
+
+err_out:
+	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
+		for_each_subsys(ss, ssid) {
+			struct cgroup_subsys_state *css = cgroup_css(dsct, ss);
+
+			if (!(cgroup_ss_mask(dsct) & (1 << ss->id)))
+				continue;
+
+			if (css && css->ss && css->ss->css_rstat_flush)
+				cgroup_rstat_exit(css);
+		}
+	}
+
+	return ret;
 }
 
 /**
@@ -5436,7 +5451,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 			cgroup_put(cgroup_parent(cgrp));
 			kernfs_put(cgrp->kn);
 			psi_cgroup_free(cgrp);
-			cgroup_rstat_exit(&cgrp->rstat);
+			cgroup_rstat_exit(&cgrp->self);
 			kfree(cgrp);
 		} else {
 			/*
@@ -5464,11 +5479,7 @@ static void css_release_work_fn(struct work_struct *work)
 	if (ss) {
 		struct cgroup *parent_cgrp;
 
-		/* css release path */
-		if (!list_empty(&css->rstat_css_node)) {
-			cgroup_rstat_flush(cgrp);
-			list_del_rcu(&css->rstat_css_node);
-		}
+		cgroup_rstat_flush(css);
 
 		cgroup_idr_replace(&ss->css_idr, NULL, css->id);
 		if (ss->css_released)
@@ -5494,7 +5505,7 @@ static void css_release_work_fn(struct work_struct *work)
 		/* cgroup release path */
 		TRACE_CGROUP_PATH(release, cgrp);
 
-		cgroup_rstat_flush(cgrp);
+		cgroup_rstat_flush(&cgrp->self);
 
 		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
@@ -5542,7 +5553,6 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 	css->id = -1;
 	INIT_LIST_HEAD(&css->sibling);
 	INIT_LIST_HEAD(&css->children);
-	INIT_LIST_HEAD(&css->rstat_css_node);
 	css->serial_nr = css_serial_nr_next++;
 	atomic_set(&css->online_cnt, 0);
 
@@ -5551,9 +5561,6 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 		css_get(css->parent);
 	}
 
-	if (ss->css_rstat_flush)
-		list_add_rcu(&css->rstat_css_node, &cgrp->rstat_css_list);
-
 	BUG_ON(cgroup_css(cgrp, ss));
 }
 
@@ -5659,7 +5666,6 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 err_list_del:
 	list_del_rcu(&css->sibling);
 err_free_css:
-	list_del_rcu(&css->rstat_css_node);
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
 	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
 	return ERR_PTR(err);
@@ -5687,7 +5693,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	if (ret)
 		goto out_free_cgrp;
 
-	ret = cgroup_rstat_init(&cgrp->rstat);
+	ret = cgroup_rstat_init(&cgrp->self);
 	if (ret)
 		goto out_cancel_ref;
 
@@ -5780,7 +5786,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 out_kernfs_remove:
 	kernfs_remove(cgrp->kn);
 out_stat_exit:
-	cgroup_rstat_exit(&cgrp->rstat);
+	cgroup_rstat_exit(&cgrp->self);
 out_cancel_ref:
 	percpu_ref_exit(&cgrp->self.refcnt);
 out_free_cgrp:
@@ -6092,6 +6098,9 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 	} else {
 		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
 		BUG_ON(css->id < 0);
+
+		if (css->ss && css->ss->css_rstat_flush)
+			BUG_ON(cgroup_rstat_init(css));
 	}
 
 	/* Update the init_css_set to contain a subsys
@@ -6193,6 +6202,9 @@ int __init cgroup_init(void)
 			css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2,
 						   GFP_KERNEL);
 			BUG_ON(css->id < 0);
+
+			if (css->ss && css->ss->css_rstat_flush)
+				BUG_ON(cgroup_rstat_init(css));
 		} else {
 			cgroup_init_subsys(ss, false);
 		}
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 13090dda56aa..a32bcd7942a5 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -21,13 +21,13 @@ static struct cgroup_rstat_cpu *rstat_cpu(struct cgroup_rstat *rstat, int cpu)
 
 static struct cgroup_rstat *rstat_parent(struct cgroup_rstat *rstat)
 {
-	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
-	struct cgroup *parent = cgroup_parent(cgrp);
+	struct cgroup_subsys_state *css = container_of(
+			rstat, typeof(*css), rstat);
 
-	if (!parent)
+	if (!css->parent)
 		return NULL;
 
-	return &parent->rstat;
+	return &(css->parent->rstat);
 }
 
 /*
@@ -86,7 +86,9 @@ void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
 
 static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu)
 {
-	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
+	struct cgroup_subsys_state *css = container_of(
+			rstat, typeof(*css), rstat);
+	struct cgroup *cgrp = css->cgroup;
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
 
@@ -95,7 +97,7 @@ static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu)
 	 * temporary inaccuracies, which is fine.
 	 *
 	 * Because @parent's updated_children is terminated with @parent
-	 * instead of NULL, we can tell whether @cgrp is on the list by
+	 * instead of NULL, we can tell whether @rstat is on the list by
 	 * testing the next pointer for NULL.
 	 */
 	if (data_race(rstat_cpu(rstat, cpu)->updated_next))
@@ -103,7 +105,7 @@ static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu)
 
 	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
 
-	/* put @cgrp and all ancestors on the corresponding updated lists */
+	/* put @rstat and all ancestors on the corresponding updated lists */
 	while (true) {
 		struct cgroup_rstat_cpu *rstatc = rstat_cpu(rstat, cpu);
 		struct cgroup_rstat *parent = rstat_parent(rstat);
@@ -134,16 +136,16 @@ static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu)
 
 /**
  * cgroup_rstat_updated - keep track of updated rstat_cpu
- * @cgrp: target cgroup
+ * @css: target cgroup subsystem state
  * @cpu: cpu on which rstat_cpu was updated
  *
- * @cgrp's rstat_cpu on @cpu was updated.  Put it on the parent's matching
+ * @css's rstat_cpu on @cpu was updated. Put it on the parent's matching
  * rstat_cpu->updated_children list.  See the comment on top of
  * cgroup_rstat_cpu definition for details.
  */
-__bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
+__bpf_kfunc void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
-	__cgroup_rstat_updated(&cgrp->rstat, cpu);
+	__cgroup_rstat_updated(&css->rstat, cpu);
 }
 
 /**
@@ -220,7 +222,9 @@ static struct cgroup_rstat *cgroup_rstat_push_children(
 static struct cgroup_rstat *cgroup_rstat_updated_list(
 		struct cgroup_rstat *root, int cpu)
 {
-	struct cgroup *cgrp = container_of(root, typeof(*cgrp), rstat);
+	struct cgroup_subsys_state *css = container_of(
+			root, typeof(*css), rstat);
+	struct cgroup *cgrp = css->cgroup;
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	struct cgroup_rstat_cpu *rstatc = rstat_cpu(root, cpu);
 	struct cgroup_rstat *head = NULL, *parent, *child;
@@ -322,7 +326,9 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 static void cgroup_rstat_flush_locked(struct cgroup_rstat *rstat)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
 {
-	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
+	struct cgroup_subsys_state *css = container_of(
+			rstat, typeof(*css), rstat);
+	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
 	lockdep_assert_held(&cgroup_rstat_lock);
@@ -331,17 +337,16 @@ static void cgroup_rstat_flush_locked(struct cgroup_rstat *rstat)
 		struct cgroup_rstat *pos = cgroup_rstat_updated_list(rstat, cpu);
 
 		for (; pos; pos = pos->rstat_flush_next) {
-			struct cgroup *pos_cgroup = container_of(pos, struct cgroup, rstat);
-			struct cgroup_subsys_state *css;
+			struct cgroup_subsys_state *pos_css = container_of(
+					pos, typeof(*pos_css), rstat);
+			struct cgroup *pos_cgroup = pos_css->cgroup;
 
-			cgroup_base_stat_flush(pos_cgroup, cpu);
-			bpf_rstat_flush(pos_cgroup, cgroup_parent(pos_cgroup), cpu);
+			if (!pos_css->ss)
+				cgroup_base_stat_flush(pos_cgroup, cpu);
+			else
+				pos_css->ss->css_rstat_flush(pos_css, cpu);
 
-			rcu_read_lock();
-			list_for_each_entry_rcu(css, &pos_cgroup->rstat_css_list,
-						rstat_css_node)
-				css->ss->css_rstat_flush(css, cpu);
-			rcu_read_unlock();
+			bpf_rstat_flush(pos_cgroup, cgroup_parent(pos_cgroup), cpu);
 		}
 
 		/* play nice and yield if necessary */
@@ -356,7 +361,9 @@ static void cgroup_rstat_flush_locked(struct cgroup_rstat *rstat)
 
 static void __cgroup_rstat_flush(struct cgroup_rstat *rstat)
 {
-	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
+	struct cgroup_subsys_state *css = container_of(
+			rstat, typeof(*css), rstat);
+	struct cgroup *cgrp = css->cgroup;
 
 	might_sleep();
 
@@ -366,27 +373,29 @@ static void __cgroup_rstat_flush(struct cgroup_rstat *rstat)
 }
 
 /**
- * cgroup_rstat_flush - flush stats in @cgrp's subtree
- * @cgrp: target cgroup
+ * cgroup_rstat_flush - flush stats in @css's rstat subtree
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
-__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
+__bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 {
-	__cgroup_rstat_flush(&cgrp->rstat);
+	__cgroup_rstat_flush(&css->rstat);
 }
 
 static void __cgroup_rstat_flush_hold(struct cgroup_rstat *rstat)
 	__acquires(&cgroup_rstat_lock)
 {
-	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
+	struct cgroup_subsys_state *css = container_of(
+			rstat, typeof(*css), rstat);
+	struct cgroup *cgrp = css->cgroup;
 
 	might_sleep();
 	__cgroup_rstat_lock(cgrp, -1);
@@ -394,38 +403,40 @@ static void __cgroup_rstat_flush_hold(struct cgroup_rstat *rstat)
 }
 
 /**
- * cgroup_rstat_flush_hold - flush stats in @cgrp's subtree and hold
- * @cgrp: target cgroup
+ * cgroup_rstat_flush_hold - flush stats in @css's rstat subtree and hold
+ * @css: target subsystem state
  *
- * Flush stats in @cgrp's subtree and prevent further flushes.  Must be
+ * Flush stats in @css's rstat subtree and prevent further flushes. Must be
  * paired with cgroup_rstat_flush_release().
  *
  * This function may block.
  */
-void cgroup_rstat_flush_hold(struct cgroup *cgrp)
+void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
 {
-	__cgroup_rstat_flush_hold(&cgrp->rstat);
+	__cgroup_rstat_flush_hold(&css->rstat);
 }
 
 /**
  * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
- * @cgrp: cgroup used by tracepoint
+ * @rstat: rstat node used to find associated cgroup used by tracepoint
  */
 static void __cgroup_rstat_flush_release(struct cgroup_rstat *rstat)
 	__releases(&cgroup_rstat_lock)
 {
-	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
+	struct cgroup_subsys_state *css = container_of(
+			rstat, typeof(*css), rstat);
+	struct cgroup *cgrp = css->cgroup;
 
 	__cgroup_rstat_unlock(cgrp, -1);
 }
 
 /**
  * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
- * @cgrp: cgroup used by tracepoint
+ * @css: css that was previously used for the call to flush hold
  */
-void cgroup_rstat_flush_release(struct cgroup *cgrp)
+void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
 {
-	__cgroup_rstat_flush_release(&cgrp->rstat);
+	__cgroup_rstat_flush_release(&css->rstat);
 }
 
 static void __cgroup_rstat_init(struct cgroup_rstat *rstat)
@@ -441,8 +452,10 @@ static void __cgroup_rstat_init(struct cgroup_rstat *rstat)
 	}
 }
 
-int cgroup_rstat_init(struct cgroup_rstat *rstat)
+int cgroup_rstat_init(struct cgroup_subsys_state *css)
 {
+	struct cgroup_rstat *rstat = &css->rstat;
+
 	/* the root cgrp has rstat_cpu preallocated */
 	if (!rstat->rstat_cpu) {
 		rstat->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
@@ -472,11 +485,11 @@ static void __cgroup_rstat_exit(struct cgroup_rstat *rstat)
 	rstat->rstat_cpu = NULL;
 }
 
-void cgroup_rstat_exit(struct cgroup_rstat *rstat)
+void cgroup_rstat_exit(struct cgroup_subsys_state *css)
 {
-	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
+	struct cgroup_rstat *rstat = &css->rstat;
 
-	cgroup_rstat_flush(cgrp);
+	cgroup_rstat_flush(css);
 	__cgroup_rstat_exit(rstat);
 }
 
@@ -518,7 +531,7 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
-	struct cgroup_rstat_cpu *rstatc = rstat_cpu(&cgrp->rstat, cpu);
+	struct cgroup_rstat_cpu *rstatc = rstat_cpu(&(cgrp->self.rstat), cpu);
 	struct cgroup *parent = cgroup_parent(cgrp);
 	struct cgroup_rstat_cpu *prstatc;
 	struct cgroup_base_stat delta;
@@ -548,7 +561,7 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
 
 		delta = rstatc->subtree_bstat;
-		prstatc = rstat_cpu(&parent->rstat, cpu);
+		prstatc = rstat_cpu(&(parent->self.rstat), cpu);
 		cgroup_base_stat_sub(&delta, &rstatc->last_subtree_bstat);
 		cgroup_base_stat_add(&prstatc->subtree_bstat, &delta);
 		cgroup_base_stat_add(&rstatc->last_subtree_bstat, &delta);
@@ -560,7 +573,7 @@ cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp, unsigned long *flags
 {
 	struct cgroup_rstat_cpu *rstatc;
 
-	rstatc = get_cpu_ptr(cgrp->rstat.rstat_cpu);
+	rstatc = get_cpu_ptr(cgrp->self.rstat.rstat_cpu);
 	*flags = u64_stats_update_begin_irqsave(&rstatc->bsync);
 	return rstatc;
 }
@@ -570,7 +583,7 @@ static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
 						 unsigned long flags)
 {
 	u64_stats_update_end_irqrestore(&rstatc->bsync, flags);
-	cgroup_rstat_updated(cgrp, smp_processor_id());
+	cgroup_rstat_updated(&cgrp->self, smp_processor_id());
 	put_cpu_ptr(rstatc);
 }
 
@@ -673,12 +686,12 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	u64 usage, utime, stime, ntime;
 
 	if (cgroup_parent(cgrp)) {
-		cgroup_rstat_flush_hold(cgrp);
+		cgroup_rstat_flush_hold(&cgrp->self);
 		usage = cgrp->bstat.cputime.sum_exec_runtime;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
 			       &utime, &stime);
 		ntime = cgrp->bstat.ntime;
-		cgroup_rstat_flush_release(cgrp);
+		cgroup_rstat_flush_release(&cgrp->self);
 	} else {
 		/* cgrp->bstat of root is not actually used, reuse it */
 		root_cgroup_cputime(&cgrp->bstat);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46f8b372d212..88c2c8e610b1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -579,7 +579,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	if (!val)
 		return;
 
-	cgroup_rstat_updated(memcg->css.cgroup, cpu);
+	cgroup_rstat_updated(&memcg->css, cpu);
 	statc = this_cpu_ptr(memcg->vmstats_percpu);
 	for (; statc; statc = statc->parent) {
 		stats_updates = READ_ONCE(statc->stats_updates) + abs(val);
@@ -611,7 +611,7 @@ static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
 	if (mem_cgroup_is_root(memcg))
 		WRITE_ONCE(flush_last_time, jiffies_64);
 
-	cgroup_rstat_flush(memcg->css.cgroup);
+	cgroup_rstat_flush(&memcg->css);
 }
 
 /*
diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
index 035412265c3c..310cd51e12e8 100644
--- a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
@@ -45,7 +45,7 @@ int BPF_PROG(test_percpu2, struct bpf_testmod_btf_type_tag_2 *arg)
 SEC("tp_btf/cgroup_mkdir")
 int BPF_PROG(test_percpu_load, struct cgroup *cgrp, const char *path)
 {
-	g = (__u64)cgrp->rstat.rstat_cpu->updated_children;
+	g = (__u64)cgrp->self.rstat.rstat_cpu->updated_children;
 	return 0;
 }
 
@@ -56,7 +56,8 @@ int BPF_PROG(test_percpu_helper, struct cgroup *cgrp, const char *path)
 	__u32 cpu;
 
 	cpu = bpf_get_smp_processor_id();
-	rstat = (struct cgroup_rstat_cpu *)bpf_per_cpu_ptr(cgrp->rstat.rstat_cpu, cpu);
+	rstat = (struct cgroup_rstat_cpu *)bpf_per_cpu_ptr(
+			cgrp->self.rstat.rstat_cpu, cpu);
 	if (rstat) {
 		/* READ_ONCE */
 		*(volatile int *)rstat;
diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
index c74362854948..10c803c8dc70 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
@@ -37,8 +37,8 @@ struct {
 	__type(value, struct attach_counter);
 } attach_counters SEC(".maps");
 
-extern void cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __ksym;
-extern void cgroup_rstat_flush(struct cgroup *cgrp) __ksym;
+extern void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu) __ksym;
+extern void cgroup_rstat_flush(struct cgroup_subsys_state *css) __ksym;
 
 static uint64_t cgroup_id(struct cgroup *cgrp)
 {
@@ -75,7 +75,7 @@ int BPF_PROG(counter, struct cgroup *dst_cgrp, struct task_struct *leader,
 	else if (create_percpu_attach_counter(cg_id, 1))
 		return 0;
 
-	cgroup_rstat_updated(dst_cgrp, bpf_get_smp_processor_id());
+	cgroup_rstat_updated(&dst_cgrp->self, bpf_get_smp_processor_id());
 	return 0;
 }
 
@@ -141,7 +141,7 @@ int BPF_PROG(dumper, struct bpf_iter_meta *meta, struct cgroup *cgrp)
 		return 1;
 
 	/* Flush the stats to make sure we get the most updated numbers */
-	cgroup_rstat_flush(cgrp);
+	cgroup_rstat_flush(&cgrp->self);
 
 	total_counter = bpf_map_lookup_elem(&attach_counters, &cg_id);
 	if (!total_counter) {
-- 
2.48.1


