Return-Path: <cgroups+bounces-6730-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98112A48AE8
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 22:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C7416CC15
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 21:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9557C271823;
	Thu, 27 Feb 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxr1/mPC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D61271800
	for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693360; cv=none; b=iyiZ1HRE6pCGKYNqHnZyL3KKLpPMY5ctpKM72OxqHbRTCz5m3rDuuMCUv3+9o3WH9amYLcnR2dvg2Pv8W5zgkK1rE7dLPbpa/wn8PfLJi6zvAAbdIVq7pXS5a/cwjD1mzn2gdFL78IMo/XcjOpxZTUwpAa59+W1C5N76Idm8rj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693360; c=relaxed/simple;
	bh=Axm2VkCT6fJ/p5EcOr7VvpTJNYdMFPXds0anQ66YUq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fC8cEgNqPPssl7gjyQhTlr6HfnxyhrEeJgph0K0VKTfRbPsrAk3hatiM431PWKrqAFMH1oJodAHrbrgV2HiO0HOGcGdXrZGdi6B/rNGQa0StQcL4+ZdfcWmK7l+NcvijXeTgF+e7RQ+tt5K/6onhBfhH9uU0NNudrLLkg4ObEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wxr1/mPC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22359001f1aso27361615ad.3
        for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 13:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740693357; x=1741298157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=474JxkEOKjJVJigD4z+nvL8yXlpAD0OmCPjzkdywhJ0=;
        b=Wxr1/mPC9ACXOqf44tqvFtEHSts7Y3TZhKk/tqVikJ++xzjTNrVt/etMUFxGIKMofK
         F9pJSi0lflBBT8JTMMwXCzxQJ92PsHY3Y5laQferXd60Dgr/DVLSkKlWMVc0UGHA73ry
         su9UmzHjDZrZlJUtdXAI+3+OfYw0loFTwoMc6OX9ggjTuPRD5CF9Es60tvIJ0ToJNFcY
         Q7eo9QOur1kxrf3WTQSwHfqkHFvTJs6jVQAXsmGVr9iv0WzlnU1p8fhvWoNYsqvEi+ij
         oS1rb6H5W5xAdCfKmr3JojWqI3pWHCnZFTnJG9ox14EfLuDfyrqM4iVFgj+FPqYSPAVK
         3SnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740693357; x=1741298157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=474JxkEOKjJVJigD4z+nvL8yXlpAD0OmCPjzkdywhJ0=;
        b=AW3MZCloMSmtBvVbRsv9XipSS71iJ85uE8zPIFLp20iRHWn3Um6NhK5K5jAaOuq1a2
         HVkt76MRrG2zTtkG95/PG32A5sO1Cfyd0pr/IEbbj/ueK30J20WKNGMiYfttJXqAwq5+
         a6BwNZUJICsifaVW4V7sJA/WfRlcKZS0CIIF8y42uBMmhPsOYz246uG82wrcj8L8CR8t
         BUhI69BJcN8COw7tkOWLXFBpFsjOa7Ed1PsWkqdrVif7CFV02EXjkIn/aMjppgv7yuox
         OI+Ai6V1IFNi05JJN9KcfGOfka43Jv2FEEGeRjf1tigL7fiBcPUfz9YD19XwzU1xzpq3
         ZKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT+6rDWjYBMv0OKueFR7nzdMDDEeC9aSXscwQ4i80PFdvO5wHspapVCxpM22u+RP+Bt1VTnseK@vger.kernel.org
X-Gm-Message-State: AOJu0YzESO2rmIPUrhl+rz/pjgjqPDyG7xEUmVRdGgwXT0fjIYeHOjmO
	M4xAZZ4nkvIGuf9FvZnOdVHNctJoacR07i6Ha/9DeZPdM1IcojwG
X-Gm-Gg: ASbGncuQ/2OTTOpxLKZArC0jtH1tkmJGzC5QO77KKIgjbNqyPORlotWjtenj9TKZd03
	o1XbkyvKAmjDRnWNXTzmBw1FAwnYi646zD9pqzRz1Vzu1jYcc+o+x2LwXm53/8/ifSbb7QEHFZw
	e0W5fhuGyL95qoJdPAecLokmuknoRGJmxDuHA4W1fv47xYTnVX+d9Teu2G/2HoaqtH4NlDRGhwm
	fTnFYzEcjbcAtXmw7kIcyjGiGVcR+xQcCdU0B+MY6qMoluX/m4mVSIkfm8NxzMUhH1DJeS2ShkD
	wglhHgRxUbo1yBpCbcOpiS+CApSuaGljciW+wwG6dTO3ufCqn8SpWQ==
X-Google-Smtp-Source: AGHT+IGBXd7LLAvRlJMDaFkbyZIUFiydBdHdhiZzy/D+lHoE5IVlW7RZYbQXedAOL6QGamfvnayp8g==
X-Received: by 2002:a17:903:708:b0:220:e896:54e1 with SMTP id d9443c01a7336-22368fc97abmr9341695ad.26.1740693357001;
        Thu, 27 Feb 2025 13:55:57 -0800 (PST)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::4:4d60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003eb65sm2301321b3a.149.2025.02.27.13.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:55:56 -0800 (PST)
From: inwardvessel <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 1/4 v2] cgroup: move cgroup_rstat from cgroup to cgroup_subsys_state
Date: Thu, 27 Feb 2025 13:55:40 -0800
Message-ID: <20250227215543.49928-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227215543.49928-1-inwardvessel@gmail.com>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JP Kobryn <inwardvessel@gmail.com>

Each cgroup owns rstat pointers. This means that a tree of pending rstat
updates can contain changes from different subsystems. Because of this
arrangement, when one subsystem is flushed via the public api
cgroup_rstat_flushed(), all other subsystems with pending updates will
also be flushed. Remove the rstat pointers from the cgroup and instead
give them to each cgroup_subsys_state. Separate rstat trees will now
exist for each unique subsystem. This separation allows for subsystems
to make updates and flushes without the side effects of other
subsystems. i.e. flushing the cpu stats does not cause the memory stats
to be flushed and vice versa. The change in pointer ownership from
cgroup to cgroup_subsys_state allows for direct flushing of the css, so
the rcu list management entities and operations previously tied to the
cgroup which were used for managing a list of subsystem states with
pending flushes are removed. In terms of client code, public api calls
were changed to now accept a reference to the cgroup_subsys_state so
that when flushing or updating, a specific subsystem is associated with
the call.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 block/blk-cgroup.c                            |   4 +-
 include/linux/cgroup-defs.h                   |  36 ++--
 include/linux/cgroup.h                        |   8 +-
 kernel/cgroup/cgroup-internal.h               |   4 +-
 kernel/cgroup/cgroup.c                        |  53 +++---
 kernel/cgroup/rstat.c                         | 159 +++++++++---------
 mm/memcontrol.c                               |   4 +-
 .../selftests/bpf/progs/btf_type_tag_percpu.c |   5 +-
 .../bpf/progs/cgroup_hierarchical_stats.c     |   8 +-
 9 files changed, 140 insertions(+), 141 deletions(-)

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
index 17960a1e858d..1598e1389615 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -169,6 +169,9 @@ struct cgroup_subsys_state {
 	/* reference count - access via css_[try]get() and css_put() */
 	struct percpu_ref refcnt;
 
+	/* per-cpu recursive resource statistics */
+	struct cgroup_rstat_cpu __percpu *rstat_cpu;
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
@@ -219,6 +219,14 @@ struct cgroup_subsys_state {
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
+
 };
 
 /*
@@ -386,8 +394,8 @@ struct cgroup_rstat_cpu {
 	 *
 	 * Protected by per-cpu cgroup_rstat_cpu_lock.
 	 */
-	struct cgroup *updated_children;	/* terminated by self cgroup */
-	struct cgroup *updated_next;		/* NULL iff not on the list */
+	struct cgroup_subsys_state *updated_children;	/* terminated by self */
+	struct cgroup_subsys_state *updated_next;		/* NULL if not on list */
 };
 
 struct cgroup_freezer_state {
@@ -516,24 +524,6 @@ struct cgroup {
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
index c964dd7ff967..87d062baff90 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -269,8 +269,8 @@ int cgroup_task_count(const struct cgroup *cgrp);
 /*
  * rstat.c
  */
-int cgroup_rstat_init(struct cgroup *cgrp);
-void cgroup_rstat_exit(struct cgroup *cgrp);
+int cgroup_rstat_init(struct cgroup_subsys_state *css);
+void cgroup_rstat_exit(struct cgroup_subsys_state *css);
 void cgroup_rstat_boot(void);
 void cgroup_base_stat_cputime_show(struct seq_file *seq);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index afc665b7b1fe..31b3bfebf7ba 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -164,7 +164,9 @@ static struct static_key_true *cgroup_subsys_on_dfl_key[] = {
 static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);
 
 /* the default hierarchy */
-struct cgroup_root cgrp_dfl_root = { .cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
+struct cgroup_root cgrp_dfl_root = {
+	.cgrp.self.rstat_cpu = &cgrp_dfl_root_rstat_cpu
+};
 EXPORT_SYMBOL_GPL(cgrp_dfl_root);
 
 /*
@@ -1358,7 +1360,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 
 	cgroup_unlock();
 
-	cgroup_rstat_exit(cgrp);
+	cgroup_rstat_exit(&cgrp->self);
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
+	ret = cgroup_rstat_init(&root_cgrp->self);
 	if (ret)
 		goto destroy_root;
 
@@ -2174,7 +2168,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	goto out;
 
 exit_stats:
-	cgroup_rstat_exit(root_cgrp);
+	cgroup_rstat_exit(&root_cgrp->self);
 destroy_root:
 	kernfs_destroy_root(root->kf_root);
 	root->kf_root = NULL;
@@ -5407,7 +5401,11 @@ static void css_free_rwork_fn(struct work_struct *work)
 		struct cgroup_subsys_state *parent = css->parent;
 		int id = css->id;
 
+		if (css->ss->css_rstat_flush)
+			cgroup_rstat_exit(css);
+
 		ss->css_free(css);
+
 		cgroup_idr_remove(&ss->css_idr, id);
 		cgroup_put(cgrp);
 
@@ -5431,7 +5429,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 			cgroup_put(cgroup_parent(cgrp));
 			kernfs_put(cgrp->kn);
 			psi_cgroup_free(cgrp);
-			cgroup_rstat_exit(cgrp);
+			cgroup_rstat_exit(&cgrp->self);
 			kfree(cgrp);
 		} else {
 			/*
@@ -5459,11 +5457,7 @@ static void css_release_work_fn(struct work_struct *work)
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
@@ -5489,7 +5483,7 @@ static void css_release_work_fn(struct work_struct *work)
 		/* cgroup release path */
 		TRACE_CGROUP_PATH(release, cgrp);
 
-		cgroup_rstat_flush(cgrp);
+		cgroup_rstat_flush(&cgrp->self);
 
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
 
+	if (css->ss->css_rstat_flush) {
+		err = cgroup_rstat_init(css);
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
+	ret = cgroup_rstat_init(&cgrp->self);
 	if (ret)
 		goto out_cancel_ref;
 
@@ -5775,7 +5770,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 out_kernfs_remove:
 	kernfs_remove(cgrp->kn);
 out_stat_exit:
-	cgroup_rstat_exit(cgrp);
+	cgroup_rstat_exit(&cgrp->self);
 out_cancel_ref:
 	percpu_ref_exit(&cgrp->self.refcnt);
 out_free_cgrp:
@@ -6087,6 +6082,9 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 	} else {
 		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
 		BUG_ON(css->id < 0);
+
+		if (css->ss && css->ss->css_rstat_flush)
+			BUG_ON(cgroup_rstat_init(css));
 	}
 
 	/* Update the init_css_set to contain a subsys
@@ -6188,6 +6186,9 @@ int __init cgroup_init(void)
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
index aac91466279f..9976f9acd62b 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -14,9 +14,10 @@ static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
-static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
+static struct cgroup_rstat_cpu *cgroup_rstat_cpu(
+		struct cgroup_subsys_state *css, int cpu)
 {
-	return per_cpu_ptr(cgrp->rstat_cpu, cpu);
+	return per_cpu_ptr(css->rstat_cpu, cpu);
 }
 
 /*
@@ -75,15 +76,17 @@ void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
 
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
+__bpf_kfunc void cgroup_rstat_updated(
+		struct cgroup_subsys_state *css, int cpu)
 {
+	struct cgroup *cgrp = css->cgroup;
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
 
@@ -92,18 +95,18 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 	 * temporary inaccuracies, which is fine.
 	 *
 	 * Because @parent's updated_children is terminated with @parent
-	 * instead of NULL, we can tell whether @cgrp is on the list by
+	 * instead of NULL, we can tell whether @css is on the list by
 	 * testing the next pointer for NULL.
 	 */
-	if (data_race(cgroup_rstat_cpu(cgrp, cpu)->updated_next))
+	if (data_race(cgroup_rstat_cpu(css, cpu)->updated_next))
 		return;
 
 	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
 
-	/* put @cgrp and all ancestors on the corresponding updated lists */
+	/* put @css and all ancestors on the corresponding updated lists */
 	while (true) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
-		struct cgroup *parent = cgroup_parent(cgrp);
+		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(css, cpu);
+		struct cgroup_subsys_state *parent = css->parent;
 		struct cgroup_rstat_cpu *prstatc;
 
 		/*
@@ -115,15 +118,15 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 
 		/* Root has no parent to link it to, but mark it busy */
 		if (!parent) {
-			rstatc->updated_next = cgrp;
+			rstatc->updated_next = css;
 			break;
 		}
 
 		prstatc = cgroup_rstat_cpu(parent, cpu);
 		rstatc->updated_next = prstatc->updated_children;
-		prstatc->updated_children = cgrp;
+		prstatc->updated_children = css;
 
-		cgrp = parent;
+		css = parent;
 	}
 
 	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, true);
@@ -141,12 +144,13 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
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
+	struct cgroup_subsys_state *chead = child;	/* Head of child css level */
+	struct cgroup_subsys_state *ghead = NULL;	/* Head of grandchild css level */
+	struct cgroup_subsys_state *parent, *grandchild;
 	struct cgroup_rstat_cpu *crstatc;
 
 	child->rstat_flush_next = NULL;
@@ -155,7 +159,7 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
 	while (chead) {
 		child = chead;
 		chead = child->rstat_flush_next;
-		parent = cgroup_parent(child);
+		parent = child->parent;
 
 		/* updated_next is parent cgroup terminated */
 		while (child != parent) {
@@ -184,30 +188,32 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
 
 /**
  * cgroup_rstat_updated_list - return a list of updated cgroups to be flushed
- * @root: root of the cgroup subtree to traverse
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
+static struct cgroup_subsys_state *cgroup_rstat_updated_list(
+		struct cgroup_subsys_state *root, int cpu)
 {
+	struct cgroup *cgrp = root->cgroup;
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(root, cpu);
-	struct cgroup *head = NULL, *parent, *child;
+	struct cgroup_subsys_state *head = NULL, *parent, *child;
 	unsigned long flags;
 
-	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, root, false);
+	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, false);
 
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
@@ -217,10 +223,10 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
 	 * Unlink @root from its parent. As the updated_children list is
 	 * singly linked, we have to walk it to find the removal point.
 	 */
-	parent = cgroup_parent(root);
+	parent = root->parent;
 	if (parent) {
 		struct cgroup_rstat_cpu *prstatc;
-		struct cgroup **nextp;
+		struct cgroup_subsys_state **nextp;
 
 		prstatc = cgroup_rstat_cpu(parent, cpu);
 		nextp = &prstatc->updated_children;
@@ -244,7 +250,7 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
 	if (child != root)
 		head = cgroup_rstat_push_children(head, child, cpu);
 unlock_ret:
-	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, root, flags, false);
+	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, false);
 	return head;
 }
 
@@ -300,27 +306,25 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 }
 
 /* see cgroup_rstat_flush() */
-static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
+static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
 {
+	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
+		struct cgroup_subsys_state *pos;
 
+		pos = cgroup_rstat_updated_list(css, cpu);
 		for (; pos; pos = pos->rstat_flush_next) {
-			struct cgroup_subsys_state *css;
+			if (!pos->ss)
+				cgroup_base_stat_flush(pos->cgroup, cpu);
+			else
+				pos->ss->css_rstat_flush(pos, cpu);
 
-			cgroup_base_stat_flush(pos, cpu);
-			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
-
-			rcu_read_lock();
-			list_for_each_entry_rcu(css, &pos->rstat_css_list,
-						rstat_css_node)
-				css->ss->css_rstat_flush(css, cpu);
-			rcu_read_unlock();
+			bpf_rstat_flush(pos->cgroup, cgroup_parent(pos->cgroup), cpu);
 		}
 
 		/* play nice and yield if necessary */
@@ -334,93 +338,96 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
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
+	struct cgroup *cgrp = css->cgroup;
+
 	might_sleep();
 
 	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
+	cgroup_rstat_flush_locked(css);
 	__cgroup_rstat_unlock(cgrp, -1);
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
-	__acquires(&cgroup_rstat_lock)
+void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
 {
+	struct cgroup *cgrp = css->cgroup;
+
 	might_sleep();
 	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
+	cgroup_rstat_flush_locked(css);
 }
 
 /**
  * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
- * @cgrp: cgroup used by tracepoint
+ * @css: css that was previously used for the call to flush hold
  */
-void cgroup_rstat_flush_release(struct cgroup *cgrp)
-	__releases(&cgroup_rstat_lock)
+void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
 {
+	struct cgroup *cgrp = css->cgroup;
 	__cgroup_rstat_unlock(cgrp, -1);
 }
 
-int cgroup_rstat_init(struct cgroup *cgrp)
+int cgroup_rstat_init(struct cgroup_subsys_state *css)
 {
 	int cpu;
 
-	/* the root cgrp has rstat_cpu preallocated */
-	if (!cgrp->rstat_cpu) {
-		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
-		if (!cgrp->rstat_cpu)
+	/* the root cgrp's self css has rstat_cpu preallocated */
+	if (!css->rstat_cpu) {
+		css->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
+		if (!css->rstat_cpu)
 			return -ENOMEM;
 	}
 
 	/* ->updated_children list is self terminated */
 	for_each_possible_cpu(cpu) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(css, cpu);
 
-		rstatc->updated_children = cgrp;
+		rstatc->updated_children = css;
 		u64_stats_init(&rstatc->bsync);
 	}
 
 	return 0;
 }
 
-void cgroup_rstat_exit(struct cgroup *cgrp)
+void cgroup_rstat_exit(struct cgroup_subsys_state *css)
 {
 	int cpu;
 
-	cgroup_rstat_flush(cgrp);
+	cgroup_rstat_flush(css);
 
 	/* sanity check */
 	for_each_possible_cpu(cpu) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(css, cpu);
 
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
@@ -461,7 +468,7 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
-	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(&cgrp->self, cpu);
 	struct cgroup *parent = cgroup_parent(cgrp);
 	struct cgroup_rstat_cpu *prstatc;
 	struct cgroup_base_stat delta;
@@ -491,7 +498,7 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
 
 		delta = rstatc->subtree_bstat;
-		prstatc = cgroup_rstat_cpu(parent, cpu);
+		prstatc = cgroup_rstat_cpu(&parent->self, cpu);
 		cgroup_base_stat_sub(&delta, &rstatc->last_subtree_bstat);
 		cgroup_base_stat_add(&prstatc->subtree_bstat, &delta);
 		cgroup_base_stat_add(&rstatc->last_subtree_bstat, &delta);
@@ -503,7 +510,7 @@ cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp, unsigned long *flags
 {
 	struct cgroup_rstat_cpu *rstatc;
 
-	rstatc = get_cpu_ptr(cgrp->rstat_cpu);
+	rstatc = get_cpu_ptr(cgrp->self.rstat_cpu);
 	*flags = u64_stats_update_begin_irqsave(&rstatc->bsync);
 	return rstatc;
 }
@@ -513,7 +520,7 @@ static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
 						 unsigned long flags)
 {
 	u64_stats_update_end_irqrestore(&rstatc->bsync, flags);
-	cgroup_rstat_updated(cgrp, smp_processor_id());
+	cgroup_rstat_updated(&cgrp->self, smp_processor_id());
 	put_cpu_ptr(rstatc);
 }
 
@@ -615,12 +622,12 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
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
2.43.5


