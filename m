Return-Path: <cgroups+bounces-7882-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC13DAA02C8
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 08:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECD95A4A94
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 06:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B342750FE;
	Tue, 29 Apr 2025 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qG3h9H65";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lB5Bod6I"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074182749FB
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.218.175.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907193; cv=fail; b=DthVQX6Nr4RbaLY3Et8qJEh5yOwVcEuUNPMgFEMD0r79qoHqm6qxJpEuROgtUk4gLKvvOo1rxwvpbuI7v+3OwzbsFg24QLcDjM31SKDuxTKjx9dbf0IlOUCbb+8RzHHbINBLz3k8RGDZbmIPtJDss0UqXXgxloVMkE6NDYytvhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907193; c=relaxed/simple;
	bh=u56fFkhyJbleXH6dcSPDSExfG+fvlrMHCco/0zoybpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSsr0NPGO8l1ChNw+qORSSoYQccKX9E738XH4erBgHvPVBQY3Pa0Ks0udrFEhDesqUIZLIGUR6D1ElUglnYd+1AQBgSHswLKQ2ldG0ytm2pBWgq0crPy0li1Arsgs5zHrZZZpRWF7WdmFKgEZavP3yFTckLqnFYwej5n0oSxgB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qG3h9H65; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lB5Bod6I reason="signature verification failed"; arc=fail smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745907189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaWYa/zSH76DRcqTSG3TzB6Bp5La07DRHjR3U/ldUeM=;
	b=qG3h9H65pzrGU8vBjryGKf2dpLXuMMwFLiHeWTLwn44LqJ5Tav7ehf38tQHTe1ck4Opj/O
	glpRh67wIHgLAdl6cMrORHLZWNiXB8pd+a4HyIxVxt0euamjqVJZrWiHthWAzthmvqCA3g
	uqoLGrkbehRQUsCJ1mWgL+LgJSteNTw=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	shakeel.butt@linux.dev
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	JP Kobryn <inwardvessel@gmail.com>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [OFFLIST PATCH 1/2] cgroup: use separate rstat trees for each subsystem
Date: Mon, 28 Apr 2025 23:12:10 -0700
Message-ID: <20250428174943.69803-1-inwardvessel@gmail.com>
In-Reply-To: <20250429061211.1295443-1-shakeel.butt@linux.dev>
References: <20250429061211.1295443-1-shakeel.butt@linux.dev>
Delivered-To: shakeel.butt@linux.dev
X-Envelope-To: shakeel.butt@linux.dev
Authentication-Results: aspmx1.migadu.com; dkim=pass header.d=gmail.com header.s=20230601 header.b=lB5Bod6I; spf=pass (aspmx1.migadu.com: domain of inwardvessel@gmail.com designates 2607:f8b0:4864:20::635 as permitted sender) smtp.mailfrom=inwardvessel@gmail.com; dmarc=pass (policy=none) header.from=gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1; t=1745862594; h=from:from:reply-to:subject:subject:date:date:message-id:message-id: to:to:cc:mime-version:mime-version: content-transfer-encoding:content-transfer-encoding:dkim-signature; bh=S92fGW8ej/8zk4mv6JSI80WWDykYnaLwkG733M8HR7g=; b=txgXtbTLRoR/zJcmXoX/P0kiuuWFahmNOTx2c5xNtJiC89ntm8EzEyp06AaW+1XlfpaBxD rQShXoUObu2hHA2FEjqFjrMb4JewKNVRBXuE6WrzxudM6zZaDrxuFl17FIczc5qzd5ZJHk Qy2dh4uddWN2eRWaHPGBJMvo7qY76Kc=
ARC-Authentication-Results: i=1; aspmx1.migadu.com; dkim=pass header.d=gmail.com header.s=20230601 header.b=lB5Bod6I; spf=pass (aspmx1.migadu.com: domain of inwardvessel@gmail.com designates 2607:f8b0:4864:20::635 as permitted sender) smtp.mailfrom=inwardvessel@gmail.com; dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=key1; d=linux.dev; t=1745862594; a=rsa-sha256; cv=none; b=f93mhP5L8o35xJWI0SCA+iIPAgtDyGM1yCdDQxFsh64OVeieSlyspxRJ+4YegO3q1Mj9vt mQ3SgXcGyd+fg55GEPqNbtND/hSusvL+S/4WUp2E87JRttyytWZG3YN37phCQuJ8OO0ItA leiyANzQjJa+h4BnZJsD137J4oK6tnE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20230601; t=1745862592; x=1746467392; darn=linux.dev; h=content-transfer-encoding:mime-version:message-id:date:subject:to :from:from:to:cc:subject:date:message-id:reply-to; bh=S92fGW8ej/8zk4mv6JSI80WWDykYnaLwkG733M8HR7g=; b=lB5Bod6Ir+UwFBGSCjEgF9P23mf09fBp9ftZVgZKYuX++wIZWkqLj/9Fp2kTMIZE9J +MOdrhMUjE4znWw+5MGhSAttFVVY0uVLuzYhM3g8WKGTRC6TE72abi2x0joqkvVtIw5s 2FEIvJaC2PTpv+QkvTJK9z5z5LsYNMaW58QNPbioFyKutLI1w1D45EabJ7kxaqnKD7Ke tQinOm6bbhAGFnmSxdDpZKk6tTA8YSeepyDOxtJufjcOhgZPg06Q9UmINaAH4ysZsmH5 vyNwEcTPv5WOw6nmrBU6njxyDCFWvjOPdcTfjMA6/sI57dhqn/5djw1fwI0xsgv4bmYk kEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net; s=20230601; t=1745862592; x=1746467392; h=content-transfer-encoding:mime-version:message-id:date:subject:to :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to; bh=S92fGW8ej/8zk4mv6JSI80WWDykYnaLwkG733M8HR7g=; b=H3n/IpygAtR5ltLc5IZH4PR0vfWcJK58GA7Ct8gI7Vnfkl5QrD/mTSbGe8G87b4x5B d765XhR6I2TE7Jw3CA8ZY/YGTBAZbA3q7lzVWrI6ku7WK5bjdKX/TWF3QXQK9OJAZjtb 2ACXUGAftBjOPJVq6XTBSrTmmYB230t+Rd2LDsC8ossBGQ6HriC06G8y5IPhJRXNyZ+g pv7/vrSebh6NP7glZPLpn74UAYDNEtoHEXO6OK6hLGHXgwI5pj67yaE0W6PGGQ8b7K2o ZbiVKGaueT53m2SWRNvHkjirMzuC8wz39oJMBBLx5ElkXSjGxrh50qE1PZTKRgPVSm2d Y9+g==
X-Gm-Message-State: AOJu0YzNTgkCNVGkginYBJ2WW5H+SnfdE5n579EErAwg1ZZKT+K92EAx AhsmBnBa22jb/F+cuhAgCJ0kzOpLb5fkhmMwFAH7ddBvN5E5W8H9bj00ew==
X-Gm-Gg: ASbGncs0nt3Imvr79Ih00g5ZR9aUnPjmv3CaVrKOL2DxUIkXdLZ6Bp5EJEOHBQ89j/f 5ezn/xylNP4h5xxViOtKIh5v/aohNcQmeGWQM7awQYQfhaLz+Dje1CbfEdwkVwRz18cob4gDu4h u3qcmdgfB6F6Kk5b1fhpUKRYtI+iD9WLV7lcPkbb4/wFb1DpdrdoPgxJlbj9i5MyOuYDx9cP1uA 66DG0wl5V4ZS+3zY6cakZWQwPGj6n7w6L6Anq8cju0suLvZcYmWJ979/eX/MDeLQAvbQEdHthtR Ms/V/H4dhjMEea45wcIpjot+uN2KaNWLPim5AmPXKEDB9v/EnnE4Qu2cL6bEvUpjWUDo
X-Google-Smtp-Source: AGHT+IH5L0RFd6qxBFFxeo8YKWlbkznHSoomHuQ42gB5J/gXpn/MoqHXIF2MH/qYDOOjLlV5FKjBHQ==
X-Received: by 2002:a17:903:40d0:b0:220:ea90:191e with SMTP id d9443c01a7336-22de6e8e335mr460325ad.4.1745862591889; Mon, 28 Apr 2025 10:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -5.78
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: JP Kobryn <inwardvessel@gmail.com>

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
 4 files changed, 150 insertions(+), 131 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index e58bfb880111..45a605c74ff8 100644
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
index a314138894e1..d9865299edf5 100644
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
@@ -5454,6 +5446,9 @@ static void css_free_rwork_fn(struct work_struct *work)
 		struct cgroup_subsys_state *parent = css->parent;
 		int id = css->id;
 
+		if (ss->css_rstat_flush)
+			css_rstat_exit(css);
+
 		ss->css_free(css);
 		cgroup_idr_remove(&ss->css_idr, id);
 		cgroup_put(cgrp);
@@ -5506,11 +5501,8 @@ static void css_release_work_fn(struct work_struct *work)
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
@@ -5536,7 +5528,7 @@ static void css_release_work_fn(struct work_struct *work)
 		/* cgroup release path */
 		TRACE_CGROUP_PATH(release, cgrp);
 
-		css_rstat_flush(css);
+		css_rstat_flush(&cgrp->self);
 
 		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
@@ -5584,7 +5576,6 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 	css->id = -1;
 	INIT_LIST_HEAD(&css->sibling);
 	INIT_LIST_HEAD(&css->children);
-	INIT_LIST_HEAD(&css->rstat_css_node);
 	css->serial_nr = css_serial_nr_next++;
 	atomic_set(&css->online_cnt, 0);
 
@@ -5593,9 +5584,6 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 		css_get(css->parent);
 	}
 
-	if (ss->css_rstat_flush)
-		list_add_rcu(&css->rstat_css_node, &cgrp->rstat_css_list);
-
 	BUG_ON(cgroup_css(cgrp, ss));
 }
 
@@ -5688,6 +5676,12 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
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
@@ -5701,7 +5695,6 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 err_list_del:
 	list_del_rcu(&css->sibling);
 err_free_css:
-	list_del_rcu(&css->rstat_css_node);
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
 	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
 	return ERR_PTR(err);
@@ -6139,11 +6132,17 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
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
@@ -6242,9 +6241,17 @@ int __init cgroup_init(void)
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
index 357c538d14da..ddc799ca6591 100644
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
@@ -125,40 +125,41 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 
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
  * Return: A new singly linked list of cgroups to be flushed
  *
- * Iteratively traverse down the cgroup_rstat_cpu updated tree level by
+ * Iteratively traverse down the css_rstat_cpu updated tree level by
  * level and push all the parents first before their next level children
  * into a singly linked list via the rstat_flush_next pointer built from the
  * tail backward like "pushing" cgroups into a stack. The root is pushed by
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
 
@@ -189,13 +190,13 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
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
@@ -217,31 +218,32 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
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
@@ -251,17 +253,17 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
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
@@ -276,9 +278,9 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
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
 
@@ -339,41 +341,36 @@ static inline void __css_rstat_unlock(struct cgroup_subsys_state *css,
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
@@ -386,29 +383,36 @@ int css_rstat_init(struct cgroup_subsys_state *css)
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
-		if (!cgrp->rstat_base_cpu) {
-			free_percpu(cgrp->rstat_cpu);
-			return -ENOMEM;
+	/* the root cgrp's self css has rstat_cpu preallocated */
+	if (!css->rstat_cpu) {
+		css->rstat_cpu = alloc_percpu(struct css_rstat_cpu);
+		if (!css->rstat_cpu) {
+			if (css_is_cgroup(css))
+				free_percpu(cgrp->rstat_base_cpu);
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
@@ -416,24 +420,28 @@ int css_rstat_init(struct cgroup_subsys_state *css)
 
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


