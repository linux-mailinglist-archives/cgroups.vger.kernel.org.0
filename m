Return-Path: <cgroups+bounces-5997-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5F99FB82A
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 02:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CCD1646EE
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 01:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50DB10957;
	Tue, 24 Dec 2024 01:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4yjPjSi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6B946C
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 01:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735002861; cv=none; b=uo+kz2Ku0QdhsdwTd3dBoKBILu9nJqaIoqSoU1DjxsaBBDRxRgMBjaJxqFQlr3h30vhEOHtlMlLIv1vJOAb0r5oQlm53SWvlu3U/EOC2qQTecZRlDlQCk2kguqSz2iAaUmLgOg3sIo0XVdF3KBSyYXEloeNl1V9jiZj/hKPGRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735002861; c=relaxed/simple;
	bh=PJG9FXf8/hURXfhOv+UgDCvcRe0xMQ5LsFngi5Z5ADM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+sxHT4XueAp1r0uiVra1OXPWffWWnP98x9HIA7yqyi/orNcbszefyDsPbkwAtrzFsQpHeqlrzeMJX96ja5qOT2VhmqAA2P91IdlaB6WB1CM5LLawKcMJNUEwoq5iFPM3ivnAhMqfrtIaszrkIocGmO+ghIYeOz/u1pCTBKap6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4yjPjSi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21628b3fe7dso42531755ad.3
        for <cgroups@vger.kernel.org>; Mon, 23 Dec 2024 17:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735002859; x=1735607659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13LzpkMgO0b7mnyCmlNhqmibgyHhCXjzFtjSKM6aNYI=;
        b=X4yjPjSin7o1xyJBFOtD82YEHPXYoKG7G1yrQviZRc+XT84IozDOIXYDeL1pjebA0i
         rVwrGfZmMJhhHqiBSoXZJwG0puHGP7ZyUabJKBFHsy5rbfovqQhMLFlJraSy9w/S5J5q
         dRsi1d68F/k1i9waB/5Qb0uaVNx/JJ/pVYFKIN0uK9OoXUzQYj75+oBH/rCMF/lQUD3v
         UIx8PghyrwC9QeQZZO2e8Jh+ANZThDW1YK8kQ0ms49FP720HOG6uX3ozDXdPFNnrI3FG
         NL8OnYW0PQeRJztQY9An0ZzWA6MNjuvbNDvSKqzYjWCoK0/rBPMUDDVvXpdUFh7D/Xzq
         uNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735002859; x=1735607659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13LzpkMgO0b7mnyCmlNhqmibgyHhCXjzFtjSKM6aNYI=;
        b=AH3ZE9rjIOK+hTYDCzSCW8Dy6rb4GtUJhlQ/q6jlrsnGcTZguJ21wegcUV8vHxDDy4
         xysZpJ+0CtpvaCCfra305ak49j8Qmyp6u9cJvxrDEY2xSnntLOImhIM395oszHe11E88
         N5VBuLcBtq8VkPG0LpKczK+QX90Pq5gRQ43y3KSg2CpXSm3TsX5p3y33G/mHIq7lZ0Am
         XevajkKEQ1noHRzKP4rL8wMqDEJUivcuUV+sSBCETQx4hftxH+ypC5BOEzgjwSj1Mg0z
         bHJR1l8pkq1+Id8QKzb2Rxo8jEE14VZ8A9HnWe6+ZS3AAvPkdrNqDnvViwx2DeUyZsFI
         1VZg==
X-Forwarded-Encrypted: i=1; AJvYcCWPVe879DsvEQVM/FdwXkbZd3omYdt8w3u4b0wbERvSfCVX+lfEFYyLhoE/Dnk0MnTC3MtCLi8W@vger.kernel.org
X-Gm-Message-State: AOJu0YwOyHs8sA1vcM0LR/0D2w44ZhDcIr/OPJI45Unx+e244ka3wvt0
	u4Gz0kzPQI0IGPCtnqANMg4sWh0deGhqd3CCNeKiijRnMx7Mhv8f
X-Gm-Gg: ASbGncvuCcYc6pZxy3OiQRPOlthcsvJXB4dRiH0KSULVn8O0MkoRJYz+86j688TH0Je
	5z/aukIlcdeEStdgBFhffcpA/XdiJzH7l5pBE8dd1RbLTZdfcg2PUPLQh71xjeNh5V50WmXuukX
	Iy1CQFGrZ7V2hpNsEvefjkuS653Kig6Lsm8mx4FHf/2tJtRS6HK4WZNUc2t6f5lrkih8FmJNwTu
	1cIpfJiBplLTUDHUYK+36sMU/mE/HA9x/39Cfe07c3c8NtR/NfY4vn+ZgI57K7UaJIWpqNJzPZH
	5RoYQFIY2mShhuY5YQ==
X-Google-Smtp-Source: AGHT+IFl073fBGBueSkF2HB8ys5fQrX8Kxhz0xZtvlhkHeBvY8ScXCz8OIzgSfe3o9z9R/mbLdv+tQ==
X-Received: by 2002:a17:903:41c8:b0:215:b058:289c with SMTP id d9443c01a7336-219e6e85beemr174581125ad.8.1735002858951;
        Mon, 23 Dec 2024 17:14:18 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970c84sm79541255ad.58.2024.12.23.17.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 17:14:18 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 4/9 RFC] cgroup: split rstat from cgroup into separate css
Date: Mon, 23 Dec 2024 17:13:57 -0800
Message-ID: <20241224011402.134009-5-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241224011402.134009-1-inwardvessel@gmail.com>
References: <20241224011402.134009-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the rstat entities off of the cgroup struct and onto the
cgroup_subsys_state struct. Adjust related code to reflect this new ownership.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup-defs.h | 40 ++++++++--------
 kernel/cgroup/cgroup.c      | 65 ++++++++++++++++++--------
 kernel/cgroup/rstat.c       | 92 ++++++++++++++++++-------------------
 3 files changed, 111 insertions(+), 86 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1b20d2d8ef7c..1932f8ae7995 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -180,6 +180,24 @@ struct cgroup_subsys_state {
 	struct list_head sibling;
 	struct list_head children;
 
+	/* per-cpu recursive resource statistics */
+	struct cgroup_rstat_cpu __percpu *rstat_cpu;
+	struct list_head rstat_css_list;
+
+	/*
+	 * Add padding to separate the read mostly rstat_cpu and
+	 * rstat_css_list into a different cacheline from the following
+	 * rstat_flush_next and *bstat fields which can have frequent updates.
+	 */
+	CACHELINE_PADDING(_pad_);
+
+	/*
+	 * A singly-linked list of cgroup structures to be rstat flushed.
+	 * This is a scratch field to be used exclusively by
+	 * cgroup_rstat_flush_locked() and protected by cgroup_rstat_lock.
+	 */
+	struct cgroup_subsys_state *rstat_flush_next;
+
 	/* flush target list anchored at cgrp->rstat_css_list */
 	struct list_head rstat_css_node;
 
@@ -389,8 +407,8 @@ struct cgroup_rstat_cpu {
 	 *
 	 * Protected by per-cpu cgroup_rstat_cpu_lock.
 	 */
-	struct cgroup *updated_children;	/* terminated by self cgroup */
-	struct cgroup *updated_next;		/* NULL iff not on the list */
+	struct cgroup_subsys_state *updated_children;	/* terminated by self cgroup */
+	struct cgroup_subsys_state *updated_next;		/* NULL iff not on the list */
 };
 
 struct cgroup_freezer_state {
@@ -516,24 +534,6 @@ struct cgroup {
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
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 848e09f433c0..96a2d15fe5e9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -164,7 +164,7 @@ static struct static_key_true *cgroup_subsys_on_dfl_key[] = {
 static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);
 
 /* the default hierarchy */
-struct cgroup_root cgrp_dfl_root = { .cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
+struct cgroup_root cgrp_dfl_root = { .cgrp.self.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
 EXPORT_SYMBOL_GPL(cgrp_dfl_root);
 
 /*
@@ -1826,6 +1826,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		struct cgroup_root *src_root = ss->root;
 		struct cgroup *scgrp = &src_root->cgrp;
 		struct cgroup_subsys_state *css = cgroup_css(scgrp, ss);
+		struct cgroup_subsys_state *dcss = cgroup_css(dcgrp, ss);
 		struct css_set *cset, *cset_pos;
 		struct css_task_iter *it;
 
@@ -1867,7 +1868,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 			list_del_rcu(&css->rstat_css_node);
 			synchronize_rcu();
 			list_add_rcu(&css->rstat_css_node,
-				     &dcgrp->rstat_css_list);
+				     &dcss->rstat_css_list);
 		}
 
 		/* default hierarchy doesn't enable controllers by default */
@@ -2052,7 +2053,6 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 	cgrp->dom_cgrp = cgrp;
 	cgrp->max_descendants = INT_MAX;
 	cgrp->max_depth = INT_MAX;
-	INIT_LIST_HEAD(&cgrp->rstat_css_list);
 	prev_cputime_init(&cgrp->prev_cputime);
 
 	for_each_subsys(ss, ssid)
@@ -2088,7 +2088,8 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	struct cgroup *root_cgrp = &root->cgrp;
 	struct kernfs_syscall_ops *kf_sops;
 	struct css_set *cset;
-	int i, ret;
+	struct cgroup_subsys *ss;
+	int i, ret, ssid;
 
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -2132,10 +2133,6 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	if (ret)
 		goto destroy_root;
 
-	ret = cgroup_rstat_init(&root_cgrp->self);
-	if (ret)
-		goto destroy_root;
-
 	ret = rebind_subsystems(root, ss_mask);
 	if (ret)
 		goto exit_stats;
@@ -2174,7 +2171,10 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	goto out;
 
 exit_stats:
-	cgroup_rstat_exit(&root_cgrp->self);
+	for_each_subsys(ss, ssid) {
+		struct cgroup_subsys_state *css = init_css_set.subsys[ssid];
+		cgroup_rstat_exit(css);
+	}
 destroy_root:
 	kernfs_destroy_root(root->kf_root);
 	root->kf_root = NULL;
@@ -3229,6 +3229,10 @@ static int cgroup_apply_control_enable(struct cgroup *cgrp)
 	int ssid, ret;
 
 	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
+		ret = cgroup_rstat_init(&dsct->self);
+		if (ret)
+			return ret;
+
 		for_each_subsys(ss, ssid) {
 			struct cgroup_subsys_state *css = cgroup_css(dsct, ss);
 
@@ -3239,6 +3243,10 @@ static int cgroup_apply_control_enable(struct cgroup *cgrp)
 				css = css_create(dsct, ss);
 				if (IS_ERR(css))
 					return PTR_ERR(css);
+
+				ret = cgroup_rstat_init(css);
+				if (ret)
+					goto err_free_css;
 			}
 
 			WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));
@@ -3252,6 +3260,20 @@ static int cgroup_apply_control_enable(struct cgroup *cgrp)
 	}
 
 	return 0;
+
+err_free_css:
+	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
+		cgroup_rstat_exit(&dsct->self);
+
+		for_each_subsys(ss, ssid) {
+			struct cgroup_subsys_state *css = cgroup_css(dsct, ss);
+
+			if (css != &dsct->self)
+				cgroup_rstat_exit(css);
+		}
+	}
+
+	return ret;
 }
 
 /**
@@ -5403,6 +5425,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 				struct cgroup_subsys_state, destroy_rwork);
 	struct cgroup_subsys *ss = css->ss;
 	struct cgroup *cgrp = css->cgroup;
+	int ssid;
 
 	percpu_ref_exit(&css->refcnt);
 
@@ -5435,7 +5458,12 @@ static void css_free_rwork_fn(struct work_struct *work)
 			cgroup_put(cgroup_parent(cgrp));
 			kernfs_put(cgrp->kn);
 			psi_cgroup_free(cgrp);
-			cgroup_rstat_exit(css);
+			for_each_subsys(ss, ssid) {
+				struct cgroup_subsys_state *css = cgrp->subsys[ssid];
+
+				if (css)
+					cgroup_rstat_exit(css);
+			}
 			kfree(cgrp);
 		} else {
 			/*
@@ -5541,6 +5569,7 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 	css->id = -1;
 	INIT_LIST_HEAD(&css->sibling);
 	INIT_LIST_HEAD(&css->children);
+	INIT_LIST_HEAD(&css->rstat_css_list);
 	INIT_LIST_HEAD(&css->rstat_css_node);
 	css->serial_nr = css_serial_nr_next++;
 	atomic_set(&css->online_cnt, 0);
@@ -5551,7 +5580,7 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 	}
 
 	if (ss->css_rstat_flush)
-		list_add_rcu(&css->rstat_css_node, &cgrp->rstat_css_list);
+		list_add_rcu(&css->rstat_css_node, &css->rstat_css_list);
 
 	BUG_ON(cgroup_css(cgrp, ss));
 }
@@ -5686,14 +5715,6 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	if (ret)
 		goto out_free_cgrp;
 
-	/* init self cgroup early so css->cgroup is valid within cgroup_rstat_init()
-	 * note that this will go away in a subsequent patch in this series
-	 */
-	cgrp->self.cgroup = cgrp;
-	ret = cgroup_rstat_init(&cgrp->self);
-	if (ret)
-		goto out_cancel_ref;
-
 	/* create the directory */
 	kn = kernfs_create_dir_ns(parent->kn, name, mode,
 				  current_fsuid(), current_fsgid(),
@@ -5784,7 +5805,6 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	kernfs_remove(cgrp->kn);
 out_stat_exit:
 	cgroup_rstat_exit(&cgrp->self);
-out_cancel_ref:
 	percpu_ref_exit(&cgrp->self.refcnt);
 out_free_cgrp:
 	kfree(cgrp);
@@ -6189,6 +6209,8 @@ int __init cgroup_init(void)
 	cgroup_unlock();
 
 	for_each_subsys(ss, ssid) {
+		struct cgroup_subsys_state *css;
+
 		if (ss->early_init) {
 			struct cgroup_subsys_state *css =
 				init_css_set.subsys[ss->id];
@@ -6200,6 +6222,9 @@ int __init cgroup_init(void)
 			cgroup_init_subsys(ss, false);
 		}
 
+		css = init_css_set.subsys[ss->id];
+		BUG_ON(cgroup_rstat_init(css));
+
 		list_add_tail(&init_css_set.e_cset_node[ssid],
 			      &cgrp_dfl_root.cgrp.e_csets[ssid]);
 
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 01a5c185b02a..4381eb9ac426 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -14,9 +14,10 @@ static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
-static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
+static struct cgroup_rstat_cpu *css_rstat_cpu(
+				struct cgroup_subsys_state *css, int cpu)
 {
-	return per_cpu_ptr(cgrp->rstat_cpu, cpu);
+	return per_cpu_ptr(css->rstat_cpu, cpu);
 }
 
 /*
@@ -96,15 +97,16 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	 * instead of NULL, we can tell whether @cgrp is on the list by
 	 * testing the next pointer for NULL.
 	 */
-	if (data_race(cgroup_rstat_cpu(cgrp, cpu)->updated_next))
+	if (data_race(css_rstat_cpu(css, cpu)->updated_next))
 		return;
 
 	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
 
 	/* put @cgrp and all ancestors on the corresponding updated lists */
 	while (true) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
-		struct cgroup *parent = cgroup_parent(cgrp);
+		struct cgroup_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
+		struct cgroup_subsys_state *parent = css->parent
+;
 		struct cgroup_rstat_cpu *prstatc;
 
 		/*
@@ -116,15 +118,15 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 
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
@@ -142,12 +144,13 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu)
  * into a singly linked list built from the tail backward like "pushing"
  * cgroups into a stack. The root is pushed by the caller.
  */
-static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
-						 struct cgroup *child, int cpu)
+static struct cgroup_subsys_state *cgroup_rstat_push_children(
+				struct cgroup_subsys_state *head,
+				struct cgroup_subsys_state *child, int cpu)
 {
-	struct cgroup *chead = child;	/* Head of child cgroup level */
-	struct cgroup *ghead = NULL;	/* Head of grandchild cgroup level */
-	struct cgroup *parent, *grandchild;
+	struct cgroup_subsys_state *chead = child;	/* Head of child cgroup level */
+	struct cgroup_subsys_state *ghead = NULL;	/* Head of grandchild cgroup level */
+	struct cgroup_subsys_state *parent, *grandchild;
 	struct cgroup_rstat_cpu *crstatc;
 
 	child->rstat_flush_next = NULL;
@@ -156,13 +159,13 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
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
@@ -201,16 +204,15 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
  * within the children list and terminated by the parent cgroup. An exception
  * here is the cgroup root whose updated_next can be self terminated.
  */
-static struct cgroup *cgroup_rstat_updated_list(struct cgroup_subsys_state *root_css,
-				int cpu)
+static struct cgroup_subsys_state *cgroup_rstat_updated_list(
+				struct cgroup_subsys_state *root, int cpu)
 {
-	struct cgroup *root = root_css->cgroup;
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
-	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(root, cpu);
-	struct cgroup *head = NULL, *parent, *child;
+	struct cgroup_rstat_cpu *rstatc = css_rstat_cpu(root, cpu);
+	struct cgroup_subsys_state *head = NULL, *parent, *child;
 	unsigned long flags;
 
-	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, root, false);
+	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, root->cgroup, false);
 
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
@@ -220,17 +222,17 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup_subsys_state *root
 	 * Unlink @root from its parent. As the updated_children list is
 	 * singly linked, we have to walk it to find the removal point.
 	 */
-	parent = cgroup_parent(root);
+	parent = root->parent;
 	if (parent) {
 		struct cgroup_rstat_cpu *prstatc;
-		struct cgroup **nextp;
+		struct cgroup_subsys_state **nextp;
 
-		prstatc = cgroup_rstat_cpu(parent, cpu);
+		prstatc = css_rstat_cpu(parent, cpu);
 		nextp = &prstatc->updated_children;
 		while (*nextp != root) {
 			struct cgroup_rstat_cpu *nrstatc;
 
-			nrstatc = cgroup_rstat_cpu(*nextp, cpu);
+			nrstatc = css_rstat_cpu(*nextp, cpu);
 			WARN_ON_ONCE(*nextp == parent);
 			nextp = &nrstatc->updated_next;
 		}
@@ -247,7 +249,7 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup_subsys_state *root
 	if (child != root)
 		head = cgroup_rstat_push_children(head, child, cpu);
 unlock_ret:
-	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, root, flags, false);
+	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, root->cgroup, flags, false);
 	return head;
 }
 
@@ -316,13 +318,13 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-		struct cgroup *pos = cgroup_rstat_updated_list(css, cpu);
+		struct cgroup_subsys_state *pos = cgroup_rstat_updated_list(css, cpu);
 
 		for (; pos; pos = pos->rstat_flush_next) {
 			struct cgroup_subsys_state *css_iter;
 
-			cgroup_base_stat_flush(pos, cpu);
-			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
+			cgroup_base_stat_flush(pos->cgroup, cpu);
+			bpf_rstat_flush(pos->cgroup, cgroup_parent(pos->cgroup), cpu);
 
 			rcu_read_lock();
 			list_for_each_entry_rcu(css_iter, &pos->rstat_css_list,
@@ -392,21 +394,20 @@ void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
 
 int cgroup_rstat_init(struct cgroup_subsys_state *css)
 {
-	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
-	/* the root cgrp has rstat_cpu preallocated */
-	if (!cgrp->rstat_cpu) {
-		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
-		if (!cgrp->rstat_cpu)
+	/* the root cgrp css has rstat_cpu preallocated */
+	if (!css->rstat_cpu) {
+		css->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
+		if (!css->rstat_cpu)
 			return -ENOMEM;
 	}
 
 	/* ->updated_children list is self terminated */
 	for_each_possible_cpu(cpu) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+		struct cgroup_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
 
-		rstatc->updated_children = cgrp;
+		rstatc->updated_children = css;
 		u64_stats_init(&rstatc->bsync);
 	}
 
@@ -415,22 +416,21 @@ int cgroup_rstat_init(struct cgroup_subsys_state *css)
 
 void cgroup_rstat_exit(struct cgroup_subsys_state *css)
 {
-	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
-	cgroup_rstat_flush(&cgrp->self);
+	cgroup_rstat_flush(css);
 
 	/* sanity check */
 	for_each_possible_cpu(cpu) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+		struct cgroup_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
 
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
@@ -471,7 +471,7 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
-	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+	struct cgroup_rstat_cpu *rstatc = css_rstat_cpu(&cgrp->self, cpu);
 	struct cgroup *parent = cgroup_parent(cgrp);
 	struct cgroup_rstat_cpu *prstatc;
 	struct cgroup_base_stat delta;
@@ -501,7 +501,7 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
 
 		delta = rstatc->subtree_bstat;
-		prstatc = cgroup_rstat_cpu(parent, cpu);
+		prstatc = css_rstat_cpu(&parent->self, cpu);
 		cgroup_base_stat_sub(&delta, &rstatc->last_subtree_bstat);
 		cgroup_base_stat_add(&prstatc->subtree_bstat, &delta);
 		cgroup_base_stat_add(&rstatc->last_subtree_bstat, &delta);
@@ -513,7 +513,7 @@ cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp, unsigned long *flags
 {
 	struct cgroup_rstat_cpu *rstatc;
 
-	rstatc = get_cpu_ptr(cgrp->rstat_cpu);
+	rstatc = get_cpu_ptr(cgrp->self.rstat_cpu);
 	*flags = u64_stats_update_begin_irqsave(&rstatc->bsync);
 	return rstatc;
 }
-- 
2.47.1


