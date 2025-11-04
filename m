Return-Path: <cgroups+bounces-11572-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FACC32CEF
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 20:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E082F3A3B7F
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 19:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E472E7653;
	Tue,  4 Nov 2025 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXlNYcYf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63B2E7F27;
	Tue,  4 Nov 2025 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284751; cv=none; b=qOqcICx79EPkw1yw/JHObBhH2JG3/a+PVcc1LfU7H2OqAMAZfozJZAan6XH1Ml2lV8ZlnYbifdoMX3aUs7g8tR+jKzI0cL1P3JOwNgSP2Z1sgjfH2o0zhB/qcCmJPi3aw3WFLtEPWLHXF0+TbLsYE8v85wtjrL22zXIt1Wl8KsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284751; c=relaxed/simple;
	bh=0uyvjpn8TovRxwTLQxF83Ia53K0bTQ/D/wg6Nmm8OJo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=IBR+cEEY88/ClGg1XQmMptdsywLbE9bl0JF+v2AAnhggf/BPftgdJPOKdgGAcI3OkR7awgiLOHDQokY/cWaRTdfNGq+Y+cauxXLf8zulSJWHiGK6ROD8gWEv3zvRqjM+cZG3k8z9obFpF4GEGZtZvwc1DUBWpNJ9Ydxf7UVMcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXlNYcYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB58C4CEF7;
	Tue,  4 Nov 2025 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762284751;
	bh=0uyvjpn8TovRxwTLQxF83Ia53K0bTQ/D/wg6Nmm8OJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sXlNYcYfwbhYrMzM2kjyxCZruRWVHkA4AJjwxMObxR1DMjXkld/NfCO9/f3MRM8SR
	 NOgFHZljoJLj8YR2F9WUIj+zFecwbGu6+EIos/DDFLDOLqI29OyeBn4+kpoWh/QQ3F
	 pvMBjbm3FEGtpXq5laOe16jNhV244q63RFRryS7zatccFJrlQLa1ylBpUVpPBTAljv
	 vPI9clFXEXQbMbdS8vo4ZNy3Xqa6ec2zwkCI9HCitTodVkIJDk2+uyTTG5tz9iUdLq
	 kX5tUASCaaLsi9vNkHhKuuqvAJ+EQRO/S/MiVEUPFPzpuVsQ6NCSMXDhqXfAe5RB2e
	 wZB/8z1h/YXag==
Date: Tue, 04 Nov 2025 09:32:30 -1000
Message-ID: <0f56e00692656d09e4b88e2f502ee50f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Dan Schatzberg <dschatzberg@meta.com>, Peter Zijlstra <peterz@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutný <mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: [PATCH cgroup/for-6.19 2/2] cgroup: Convert css_set_lock locking to use cleanup guards
In-Reply-To: <20251104181114.489391-1-calvin@wbinvd.org>
References: <20251104181114.489391-1-calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Convert most css_set_lock critical sections to use cleanup guards (guard(),
scoped_guard()) for automatic lock management. This reduces the amount of
manual lock/unlock pairing and eliminates several 'unsigned long flags'
variables.

cgroup_css_links_read() in debug.c is left unconverted as it would require
excessive indentation.

Signed-off-by: Tejun Heo <tj@kernel.org>
 kernel/cgroup/freezer.c         |   38 +-
 kernel/cgroup/namespace.c       |    8 
 6 files changed, 302 insertions(+), 346 deletions(-)

--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -198,8 +198,6 @@ void put_css_set_locked(struct css_set *
 
 static inline void put_css_set(struct css_set *cset)
 {
-	unsigned long flags;
-
 	/*
 	 * Ensure that the refcount doesn't hit zero while any readers
 	 * can see it. Similar to atomic_dec_and_lock(), but for an
@@ -208,9 +206,9 @@ static inline void put_css_set(struct cs
 	if (refcount_dec_not_one(&cset->refcount))
 		return;
 
-	raw_spin_lock_irqsave(&css_set_lock, flags);
+	guard(raw_spinlock_irqsave)(&css_set_lock);
+
 	put_css_set_locked(cset);
-	raw_spin_unlock_irqrestore(&css_set_lock, flags);
 }
 
 /*
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -73,9 +73,8 @@ int cgroup_attach_task_all(struct task_s
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
 
-		raw_spin_lock_irq(&css_set_lock);
-		from_cgrp = task_cgroup_from_root(from, root);
-		raw_spin_unlock_irq(&css_set_lock);
+		scoped_guard (raw_spinlock_irq, &css_set_lock)
+			from_cgrp = task_cgroup_from_root(from, root);
 
 		retval = cgroup_attach_task(from_cgrp, tsk, false);
 		if (retval)
@@ -121,10 +120,10 @@ int cgroup_transfer_tasks(struct cgroup
 	cgroup_attach_lock(CGRP_ATTACH_LOCK_GLOBAL, NULL);
 
 	/* all tasks in @from are being moved, all csets are source */
-	raw_spin_lock_irq(&css_set_lock);
-	list_for_each_entry(link, &from->cset_links, cset_link)
-		cgroup_migrate_add_src(link->cset, to, &mgctx);
-	raw_spin_unlock_irq(&css_set_lock);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		list_for_each_entry(link, &from->cset_links, cset_link)
+			cgroup_migrate_add_src(link->cset, to, &mgctx);
+	}
 
 	ret = cgroup_migrate_prepare_dst(&mgctx);
 	if (ret)
@@ -1299,7 +1298,6 @@ struct cgroup *task_get_cgroup1(struct t
 {
 	struct cgroup *cgrp = ERR_PTR(-ENOENT);
 	struct cgroup_root *root;
-	unsigned long flags;
 
 	rcu_read_lock();
 	for_each_root(root) {
@@ -1308,11 +1306,11 @@ struct cgroup *task_get_cgroup1(struct t
 			continue;
 		if (root->hierarchy_id != hierarchy_id)
 			continue;
-		raw_spin_lock_irqsave(&css_set_lock, flags);
-		cgrp = task_cgroup_from_root(tsk, root);
-		if (!cgrp || !cgroup_tryget(cgrp))
-			cgrp = ERR_PTR(-ENOENT);
-		raw_spin_unlock_irqrestore(&css_set_lock, flags);
+		scoped_guard (raw_spinlock_irqsave, &css_set_lock) {
+			cgrp = task_cgroup_from_root(tsk, root);
+			if (!cgrp || !cgroup_tryget(cgrp))
+				cgrp = ERR_PTR(-ENOENT);
+		}
 		break;
 	}
 	rcu_read_unlock();
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -666,13 +666,9 @@ int __cgroup_task_count(const struct cgr
  */
 int cgroup_task_count(const struct cgroup *cgrp)
 {
-	int count;
+	guard(raw_spinlock_irq)(&css_set_lock);
 
-	raw_spin_lock_irq(&css_set_lock);
-	count = __cgroup_task_count(cgrp);
-	raw_spin_unlock_irq(&css_set_lock);
-
-	return count;
+	return __cgroup_task_count(cgrp);
 }
 
 static struct cgroup *kn_priv(struct kernfs_node *kn)
@@ -1238,11 +1234,11 @@ static struct css_set *find_css_set(stru
 
 	/* First see if we already have a cgroup group that matches
 	 * the desired set */
-	raw_spin_lock_irq(&css_set_lock);
-	cset = find_existing_css_set(old_cset, cgrp, template);
-	if (cset)
-		get_css_set(cset);
-	raw_spin_unlock_irq(&css_set_lock);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		cset = find_existing_css_set(old_cset, cgrp, template);
+		if (cset)
+			get_css_set(cset);
+	}
 
 	if (cset)
 		return cset;
@@ -1274,34 +1270,33 @@ static struct css_set *find_css_set(stru
 	 * find_existing_css_set() */
 	memcpy(cset->subsys, template, sizeof(cset->subsys));
 
-	raw_spin_lock_irq(&css_set_lock);
-	/* Add reference counts and links from the new css_set. */
-	list_for_each_entry(link, &old_cset->cgrp_links, cgrp_link) {
-		struct cgroup *c = link->cgrp;
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		/* Add reference counts and links from the new css_set. */
+		list_for_each_entry(link, &old_cset->cgrp_links, cgrp_link) {
+			struct cgroup *c = link->cgrp;
 
-		if (c->root == cgrp->root)
-			c = cgrp;
-		link_css_set(&tmp_links, cset, c);
-	}
+			if (c->root == cgrp->root)
+				c = cgrp;
+			link_css_set(&tmp_links, cset, c);
+		}
 
-	BUG_ON(!list_empty(&tmp_links));
+		BUG_ON(!list_empty(&tmp_links));
 
-	css_set_count++;
+		css_set_count++;
 
-	/* Add @cset to the hash table */
-	key = css_set_hash(cset->subsys);
-	hash_add(css_set_table, &cset->hlist, key);
+		/* Add @cset to the hash table */
+		key = css_set_hash(cset->subsys);
+		hash_add(css_set_table, &cset->hlist, key);
 
-	for_each_subsys(ss, ssid) {
-		struct cgroup_subsys_state *css = cset->subsys[ssid];
+		for_each_subsys(ss, ssid) {
+			struct cgroup_subsys_state *css = cset->subsys[ssid];
 
-		list_add_tail(&cset->e_cset_node[ssid],
-			      &css->cgroup->e_csets[ssid]);
-		css_get(css);
+			list_add_tail(&cset->e_cset_node[ssid],
+				      &css->cgroup->e_csets[ssid]);
+			css_get(css);
+		}
 	}
 
-	raw_spin_unlock_irq(&css_set_lock);
-
 	/*
 	 * If @cset should be threaded, look up the matching dom_cset and
 	 * link them up.  We first fully initialize @cset then look for the
@@ -1317,11 +1312,11 @@ static struct css_set *find_css_set(stru
 			return NULL;
 		}
 
-		raw_spin_lock_irq(&css_set_lock);
-		cset->dom_cset = dcset;
-		list_add_tail(&cset->threaded_csets_node,
-			      &dcset->threaded_csets);
-		raw_spin_unlock_irq(&css_set_lock);
+		scoped_guard (raw_spinlock_irq, &css_set_lock) {
+			cset->dom_cset = dcset;
+			list_add_tail(&cset->threaded_csets_node,
+				      &dcset->threaded_csets);
+		}
 	}
 
 	return cset;
@@ -1414,16 +1409,14 @@ static void cgroup_destroy_root(struct c
 	 * Release all the links from cset_links to this hierarchy's
 	 * root cgroup
 	 */
-	raw_spin_lock_irq(&css_set_lock);
-
-	list_for_each_entry_safe(link, tmp_link, &cgrp->cset_links, cset_link) {
-		list_del(&link->cset_link);
-		list_del(&link->cgrp_link);
-		kfree(link);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		list_for_each_entry_safe(link, tmp_link, &cgrp->cset_links, cset_link) {
+			list_del(&link->cset_link);
+			list_del(&link->cgrp_link);
+			kfree(link);
+		}
 	}
 
-	raw_spin_unlock_irq(&css_set_lock);
-
 	WARN_ON_ONCE(list_empty(&root->root_list));
 	list_del_rcu(&root->root_list);
 	cgroup_root_count--;
@@ -1919,25 +1912,27 @@ int rebind_subsystems(struct cgroup_root
 		rcu_assign_pointer(dcgrp->subsys[ssid], css);
 		ss->root = dst_root;
 
-		raw_spin_lock_irq(&css_set_lock);
-		css->cgroup = dcgrp;
-		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
-		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
-					 e_cset_node[ss->id]) {
-			list_move_tail(&cset->e_cset_node[ss->id],
-				       &dcgrp->e_csets[ss->id]);
-			/*
-			 * all css_sets of scgrp together in same order to dcgrp,
-			 * patch in-flight iterators to preserve correct iteration.
-			 * since the iterator is always advanced right away and
-			 * finished when it->cset_pos meets it->cset_head, so only
-			 * update it->cset_head is enough here.
-			 */
-			list_for_each_entry(it, &cset->task_iters, iters_node)
-				if (it->cset_head == &scgrp->e_csets[ss->id])
-					it->cset_head = &dcgrp->e_csets[ss->id];
+		scoped_guard (raw_spinlock_irq, &css_set_lock) {
+			css->cgroup = dcgrp;
+			WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
+			list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
+						 e_cset_node[ss->id]) {
+				list_move_tail(&cset->e_cset_node[ss->id],
+					       &dcgrp->e_csets[ss->id]);
+				/*
+				 * all css_sets of scgrp together in same order
+				 * to dcgrp, patch in-flight iterators to
+				 * preserve correct iteration. since the
+				 * iterator is always advanced right away and
+				 * finished when it->cset_pos meets
+				 * it->cset_head, so only update it->cset_head
+				 * is enough here.
+				 */
+				list_for_each_entry(it, &cset->task_iters, iters_node)
+					if (it->cset_head == &scgrp->e_csets[ss->id])
+						it->cset_head = &dcgrp->e_csets[ss->id];
+			}
 		}
-		raw_spin_unlock_irq(&css_set_lock);
 
 		/* default hierarchy doesn't enable controllers by default */
 		dst_root->subsys_mask |= 1 << ssid;
@@ -1973,10 +1968,10 @@ int cgroup_show_path(struct seq_file *sf
 	if (!buf)
 		return -ENOMEM;
 
-	raw_spin_lock_irq(&css_set_lock);
-	ns_cgroup = current_cgns_cgroup_from_root(kf_cgroot);
-	len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
-	raw_spin_unlock_irq(&css_set_lock);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		ns_cgroup = current_cgns_cgroup_from_root(kf_cgroot);
+		len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
+	}
 
 	if (len == -E2BIG)
 		len = -ERANGE;
@@ -2232,13 +2227,13 @@ int cgroup_setup_root(struct cgroup_root
 	 * Link the root cgroup in this hierarchy into all the css_set
 	 * objects.
 	 */
-	raw_spin_lock_irq(&css_set_lock);
-	hash_for_each(css_set_table, i, cset, hlist) {
-		link_css_set(&tmp_links, cset, root_cgrp);
-		if (css_set_populated(cset))
-			cgroup_update_populated(root_cgrp, true);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		hash_for_each(css_set_table, i, cset, hlist) {
+			link_css_set(&tmp_links, cset, root_cgrp);
+			if (css_set_populated(cset))
+				cgroup_update_populated(root_cgrp, true);
+		}
 	}
-	raw_spin_unlock_irq(&css_set_lock);
 
 	BUG_ON(!list_empty(&root_cgrp->self.children));
 	BUG_ON(atomic_read(&root->nr_cgrps) != 1);
@@ -2282,11 +2277,8 @@ int cgroup_do_get_tree(struct fs_context
 		struct cgroup *cgrp;
 
 		cgroup_lock();
-		raw_spin_lock_irq(&css_set_lock);
-
-		cgrp = cset_cgroup_from_root(ctx->ns->root_cset, ctx->root);
-
-		raw_spin_unlock_irq(&css_set_lock);
+		scoped_guard (raw_spinlock_irq, &css_set_lock)
+			cgrp = cset_cgroup_from_root(ctx->ns->root_cset, ctx->root);
 		cgroup_unlock();
 
 		nsdentry = kernfs_node_dentry(cgrp->kn, sb);
@@ -2498,11 +2490,8 @@ int cgroup_path_ns(struct cgroup *cgrp,
 	int ret;
 
 	cgroup_lock();
-	raw_spin_lock_irq(&css_set_lock);
-
-	ret = cgroup_path_ns_locked(cgrp, buf, buflen, ns);
-
-	raw_spin_unlock_irq(&css_set_lock);
+	scoped_guard (raw_spinlock_irq, &css_set_lock)
+		ret = cgroup_path_ns_locked(cgrp, buf, buflen, ns);
 	cgroup_unlock();
 
 	return ret;
@@ -2721,27 +2710,27 @@ static int cgroup_migrate_execute(struct
 	 * the new cgroup.  There are no failure cases after here, so this
 	 * is the commit point.
 	 */
-	raw_spin_lock_irq(&css_set_lock);
-	list_for_each_entry(cset, &tset->src_csets, mg_node) {
-		list_for_each_entry_safe(task, tmp_task, &cset->mg_tasks, cg_list) {
-			struct css_set *from_cset = task_css_set(task);
-			struct css_set *to_cset = cset->mg_dst_cset;
-
-			get_css_set(to_cset);
-			to_cset->nr_tasks++;
-			css_set_move_task(task, from_cset, to_cset, true);
-			from_cset->nr_tasks--;
-			/*
-			 * If the source or destination cgroup is frozen,
-			 * the task might require to change its state.
-			 */
-			cgroup_freezer_migrate_task(task, from_cset->dfl_cgrp,
-						    to_cset->dfl_cgrp);
-			put_css_set_locked(from_cset);
-
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		list_for_each_entry(cset, &tset->src_csets, mg_node) {
+			list_for_each_entry_safe(task, tmp_task, &cset->mg_tasks, cg_list) {
+				struct css_set *from_cset = task_css_set(task);
+				struct css_set *to_cset = cset->mg_dst_cset;
+
+				get_css_set(to_cset);
+				to_cset->nr_tasks++;
+				css_set_move_task(task, from_cset, to_cset, true);
+				from_cset->nr_tasks--;
+				/*
+				 * If the source or destination cgroup is
+				 * frozen, the task might require to change its
+				 * state.
+				 */
+				cgroup_freezer_migrate_task(task, from_cset->dfl_cgrp,
+							    to_cset->dfl_cgrp);
+				put_css_set_locked(from_cset);
+			}
 		}
 	}
-	raw_spin_unlock_irq(&css_set_lock);
 
 	/*
 	 * Migration is committed, all target tasks are now on dst_csets.
@@ -2774,13 +2763,13 @@ out_cancel_attach:
 		} while_each_subsys_mask();
 	}
 out_release_tset:
-	raw_spin_lock_irq(&css_set_lock);
-	list_splice_init(&tset->dst_csets, &tset->src_csets);
-	list_for_each_entry_safe(cset, tmp_cset, &tset->src_csets, mg_node) {
-		list_splice_tail_init(&cset->mg_tasks, &cset->tasks);
-		list_del_init(&cset->mg_node);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		list_splice_init(&tset->dst_csets, &tset->src_csets);
+		list_for_each_entry_safe(cset, tmp_cset, &tset->src_csets, mg_node) {
+			list_splice_tail_init(&cset->mg_tasks, &cset->tasks);
+			list_del_init(&cset->mg_node);
+		}
 	}
-	raw_spin_unlock_irq(&css_set_lock);
 
 	/*
 	 * Re-initialize the cgroup_taskset structure in case it is reused
@@ -2838,7 +2827,7 @@ void cgroup_migrate_finish(struct cgroup
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	raw_spin_lock_irq(&css_set_lock);
+	guard(raw_spinlock_irq)(&css_set_lock);
 
 	list_for_each_entry_safe(cset, tmp_cset, &mgctx->preloaded_src_csets,
 				 mg_src_preload_node) {
@@ -2857,8 +2846,6 @@ void cgroup_migrate_finish(struct cgroup
 		list_del_init(&cset->mg_dst_preload_node);
 		put_css_set_locked(cset);
 	}
-
-	raw_spin_unlock_irq(&css_set_lock);
 }
 
 /**
@@ -2994,21 +2981,19 @@ int cgroup_migrate_prepare_dst(struct cg
 int cgroup_migrate(struct task_struct *leader, bool threadgroup,
 		   struct cgroup_mgctx *mgctx)
 {
-	struct task_struct *task;
-
 	/*
 	 * The following thread iteration should be inside an RCU critical
 	 * section to prevent tasks from being freed while taking the snapshot.
 	 * spin_lock_irq() implies RCU critical section here.
 	 */
-	raw_spin_lock_irq(&css_set_lock);
-	task = leader;
-	do {
-		cgroup_migrate_add_task(task, mgctx);
-		if (!threadgroup)
-			break;
-	} while_each_thread(leader, task);
-	raw_spin_unlock_irq(&css_set_lock);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		struct task_struct *task = leader;
+		do {
+			cgroup_migrate_add_task(task, mgctx);
+			if (!threadgroup)
+				break;
+		} while_each_thread(leader, task);
+	}
 
 	return cgroup_migrate_execute(mgctx);
 }
@@ -3025,18 +3010,17 @@ int cgroup_attach_task(struct cgroup *ds
 		       bool threadgroup)
 {
 	DEFINE_CGROUP_MGCTX(mgctx);
-	struct task_struct *task;
 	int ret = 0;
 
 	/* look up all src csets */
-	raw_spin_lock_irq(&css_set_lock);
-	task = leader;
-	do {
-		cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
-		if (!threadgroup)
-			break;
-	} while_each_thread(leader, task);
-	raw_spin_unlock_irq(&css_set_lock);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		struct task_struct *task = leader;
+		do {
+			cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
+			if (!threadgroup)
+				break;
+		} while_each_thread(leader, task);
+	}
 
 	/* prepare dst csets and commit */
 	ret = cgroup_migrate_prepare_dst(&mgctx);
@@ -3193,23 +3177,23 @@ static int cgroup_update_dfl_csses(struc
 	lockdep_assert_held(&cgroup_mutex);
 
 	/* look up all csses currently attached to @cgrp's subtree */
-	raw_spin_lock_irq(&css_set_lock);
-	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
-		struct cgrp_cset_link *link;
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
+			struct cgrp_cset_link *link;
 
-		/*
-		 * As cgroup_update_dfl_csses() is only called by
-		 * cgroup_apply_control(). The csses associated with the
-		 * given cgrp will not be affected by changes made to
-		 * its subtree_control file. We can skip them.
-		 */
-		if (dsct == cgrp)
-			continue;
+			/*
+			 * As cgroup_update_dfl_csses() is only called by
+			 * cgroup_apply_control(). The csses associated with the
+			 * given cgrp will not be affected by changes made to
+			 * its subtree_control file. We can skip them.
+			 */
+			if (dsct == cgrp)
+				continue;
 
-		list_for_each_entry(link, &dsct->cset_links, cset_link)
-			cgroup_migrate_add_src(link->cset, dsct, &mgctx);
+			list_for_each_entry(link, &dsct->cset_links, cset_link)
+				cgroup_migrate_add_src(link->cset, dsct, &mgctx);
+		}
 	}
-	raw_spin_unlock_irq(&css_set_lock);
 
 	/*
 	 * We need to write-lock threadgroup_rwsem while migrating tasks.
@@ -3231,16 +3215,16 @@ static int cgroup_update_dfl_csses(struc
 	if (ret)
 		goto out_finish;
 
-	raw_spin_lock_irq(&css_set_lock);
-	list_for_each_entry(src_cset, &mgctx.preloaded_src_csets,
-			    mg_src_preload_node) {
-		struct task_struct *task, *ntask;
-
-		/* all tasks in src_csets need to be migrated */
-		list_for_each_entry_safe(task, ntask, &src_cset->tasks, cg_list)
-			cgroup_migrate_add_task(task, &mgctx);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		list_for_each_entry(src_cset, &mgctx.preloaded_src_csets,
+				    mg_src_preload_node) {
+			struct task_struct *task, *ntask;
+
+			/* all tasks in src_csets need to be migrated */
+			list_for_each_entry_safe(task, ntask, &src_cset->tasks, cg_list)
+				cgroup_migrate_add_task(task, &mgctx);
+		}
 	}
-	raw_spin_unlock_irq(&css_set_lock);
 
 	ret = cgroup_migrate_execute(&mgctx);
 out_finish:
@@ -4188,9 +4172,8 @@ static void __cgroup_kill(struct cgroup
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	raw_spin_lock_irq(&css_set_lock);
-	cgrp->kill_seq++;
-	raw_spin_unlock_irq(&css_set_lock);
+	scoped_guard (raw_spinlock_irq, &css_set_lock)
+		cgrp->kill_seq++;
 
 	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
 	while ((task = css_task_iter_next(&it))) {
@@ -5144,11 +5127,9 @@ repeat:
 void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 			 struct css_task_iter *it)
 {
-	unsigned long irqflags;
-
 	memset(it, 0, sizeof(*it));
 
-	raw_spin_lock_irqsave(&css_set_lock, irqflags);
+	guard(raw_spinlock_irqsave)(&css_set_lock);
 
 	it->ss = css->ss;
 	it->flags = flags;
@@ -5161,8 +5142,6 @@ void css_task_iter_start(struct cgroup_s
 	it->cset_head = it->cset_pos;
 
 	css_task_iter_advance(it);
-
-	raw_spin_unlock_irqrestore(&css_set_lock, irqflags);
 }
 
 /**
@@ -5175,14 +5154,12 @@ void css_task_iter_start(struct cgroup_s
  */
 struct task_struct *css_task_iter_next(struct css_task_iter *it)
 {
-	unsigned long irqflags;
-
 	if (it->cur_task) {
 		put_task_struct(it->cur_task);
 		it->cur_task = NULL;
 	}
 
-	raw_spin_lock_irqsave(&css_set_lock, irqflags);
+	guard(raw_spinlock_irqsave)(&css_set_lock);
 
 	/* @it may be half-advanced by skips, finish advancing */
 	if (it->flags & CSS_TASK_ITER_SKIPPED)
@@ -5195,8 +5172,6 @@ struct task_struct *css_task_iter_next(s
 		css_task_iter_advance(it);
 	}
 
-	raw_spin_unlock_irqrestore(&css_set_lock, irqflags);
-
 	return it->cur_task;
 }
 
@@ -5208,13 +5183,11 @@ struct task_struct *css_task_iter_next(s
  */
 void css_task_iter_end(struct css_task_iter *it)
 {
-	unsigned long irqflags;
-
 	if (it->cur_cset) {
-		raw_spin_lock_irqsave(&css_set_lock, irqflags);
-		list_del(&it->iters_node);
-		put_css_set_locked(it->cur_cset);
-		raw_spin_unlock_irqrestore(&css_set_lock, irqflags);
+		scoped_guard (raw_spinlock_irqsave, &css_set_lock) {
+			list_del(&it->iters_node);
+			put_css_set_locked(it->cur_cset);
+		}
 	}
 
 	if (it->cur_dcset)
@@ -5380,9 +5353,8 @@ static ssize_t __cgroup_procs_write(stru
 		goto out_unlock;
 
 	/* find the source cgroup */
-	raw_spin_lock_irq(&css_set_lock);
-	src_cgrp = task_cgroup_from_root(task, &cgrp_dfl_root);
-	raw_spin_unlock_irq(&css_set_lock);
+	scoped_guard (raw_spinlock_irq, &css_set_lock)
+		src_cgrp = task_cgroup_from_root(task, &cgrp_dfl_root);
 
 	/*
 	 * Process and thread migrations follow same delegation rule. Check
@@ -5669,11 +5641,11 @@ static void css_release_work_fn(struct w
 
 		css_rstat_flush(&cgrp->self);
 
-		raw_spin_lock_irq(&css_set_lock);
-		for (tcgrp = cgroup_parent(cgrp); tcgrp;
-		     tcgrp = cgroup_parent(tcgrp))
-			tcgrp->nr_dying_descendants--;
-		raw_spin_unlock_irq(&css_set_lock);
+		scoped_guard (raw_spinlock_irq, &css_set_lock) {
+			for (tcgrp = cgroup_parent(cgrp); tcgrp;
+			     tcgrp = cgroup_parent(tcgrp))
+				tcgrp->nr_dying_descendants--;
+		}
 
 		/*
 		 * There are two control paths which try to determine
@@ -5924,20 +5896,20 @@ static struct cgroup *cgroup_create(stru
 		goto out_psi_free;
 
 	/* allocation complete, commit to creation */
-	raw_spin_lock_irq(&css_set_lock);
-	for (i = 0; i < level; i++) {
-		tcgrp = cgrp->ancestors[i];
-		tcgrp->nr_descendants++;
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		for (i = 0; i < level; i++) {
+			tcgrp = cgrp->ancestors[i];
+			tcgrp->nr_descendants++;
 
-		/*
-		 * If the new cgroup is frozen, all ancestor cgroups get a new
-		 * frozen descendant, but their state can't change because of
-		 * this.
-		 */
-		if (cgrp->freezer.e_freeze)
-			tcgrp->freezer.nr_frozen_descendants++;
+			/*
+			 * If the new cgroup is frozen, all ancestor cgroups get
+			 * a new frozen descendant, but their state can't change
+			 * because of this.
+			 */
+			if (cgrp->freezer.e_freeze)
+				tcgrp->freezer.nr_frozen_descendants++;
+		}
 	}
-	raw_spin_unlock_irq(&css_set_lock);
 
 	list_add_tail_rcu(&cgrp->self.sibling, &cgroup_parent(cgrp)->self.children);
 	atomic_inc(&root->nr_cgrps);
@@ -6183,10 +6155,10 @@ static int cgroup_destroy_locked(struct
 	 */
 	cgrp->self.flags &= ~CSS_ONLINE;
 
-	raw_spin_lock_irq(&css_set_lock);
-	list_for_each_entry(link, &cgrp->cset_links, cset_link)
-		link->cset->dead = true;
-	raw_spin_unlock_irq(&css_set_lock);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		list_for_each_entry(link, &cgrp->cset_links, cset_link)
+			link->cset->dead = true;
+	}
 
 	/* initiate massacre of all css's */
 	for_each_css(css, ssid, cgrp)
@@ -6199,18 +6171,18 @@ static int cgroup_destroy_locked(struct
 	if (cgroup_is_threaded(cgrp))
 		parent->nr_threaded_children--;
 
-	raw_spin_lock_irq(&css_set_lock);
-	for (tcgrp = parent; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
-		tcgrp->nr_descendants--;
-		tcgrp->nr_dying_descendants++;
-		/*
-		 * If the dying cgroup is frozen, decrease frozen descendants
-		 * counters of ancestor cgroups.
-		 */
-		if (test_bit(CGRP_FROZEN, &cgrp->flags))
-			tcgrp->freezer.nr_frozen_descendants--;
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		for (tcgrp = parent; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
+			tcgrp->nr_descendants--;
+			tcgrp->nr_dying_descendants++;
+			/*
+			 * If the dying cgroup is frozen, decrease frozen
+			 * descendants counters of ancestor cgroups.
+			 */
+			if (test_bit(CGRP_FROZEN, &cgrp->flags))
+				tcgrp->freezer.nr_frozen_descendants--;
+		}
 	}
-	raw_spin_unlock_irq(&css_set_lock);
 
 	cgroup1_check_for_release(parent);
 
@@ -6549,17 +6521,14 @@ EXPORT_SYMBOL_GPL(cgroup_get_from_id);
 int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 		     struct pid *pid, struct task_struct *tsk)
 {
-	char *buf;
-	int retval;
 	struct cgroup_root *root;
 
-	retval = -ENOMEM;
-	buf = kmalloc(PATH_MAX, GFP_KERNEL);
+	char *buf __free(kfree) = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!buf)
-		goto out;
+		return -ENOMEM;
 
-	rcu_read_lock();
-	raw_spin_lock_irq(&css_set_lock);
+	guard(rcu)();
+	guard(raw_spinlock_irq)(&css_set_lock);
 
 	for_each_root(root) {
 		struct cgroup_subsys *ss;
@@ -6594,12 +6563,12 @@ int proc_cgroup_show(struct seq_file *m,
 		 * " (deleted)" is appended to the cgroup path.
 		 */
 		if (cgroup_on_dfl(cgrp) || !(tsk->flags & PF_EXITING)) {
-			retval = cgroup_path_ns_locked(cgrp, buf, PATH_MAX,
-						current->nsproxy->cgroup_ns);
+			int retval = cgroup_path_ns_locked(cgrp, buf, PATH_MAX,
+							   current->nsproxy->cgroup_ns);
 			if (retval == -E2BIG)
 				retval = -ENAMETOOLONG;
 			if (retval < 0)
-				goto out_unlock;
+				return retval;
 
 			seq_puts(m, buf);
 		} else {
@@ -6612,13 +6581,7 @@ int proc_cgroup_show(struct seq_file *m,
 			seq_putc(m, '\n');
 	}
 
-	retval = 0;
-out_unlock:
-	raw_spin_unlock_irq(&css_set_lock);
-	rcu_read_unlock();
-	kfree(buf);
-out:
-	return retval;
+	return 0;
 }
 
 /**
@@ -6702,14 +6665,14 @@ static int cgroup_css_set_fork(struct ke
 
 	cgroup_threadgroup_change_begin(current);
 
-	raw_spin_lock_irq(&css_set_lock);
-	cset = task_css_set(current);
-	get_css_set(cset);
-	if (kargs->cgrp)
-		kargs->kill_seq = kargs->cgrp->kill_seq;
-	else
-		kargs->kill_seq = cset->dfl_cgrp->kill_seq;
-	raw_spin_unlock_irq(&css_set_lock);
+	scoped_guard(raw_spinlock_irq, &css_set_lock) {
+		cset = task_css_set(current);
+		get_css_set(cset);
+		if (kargs->cgrp)
+			kargs->kill_seq = kargs->cgrp->kill_seq;
+		else
+			kargs->kill_seq = cset->dfl_cgrp->kill_seq;
+	}
 
 	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
 		kargs->cset = cset;
@@ -6899,56 +6862,56 @@ void cgroup_post_fork(struct task_struct
 	cset = kargs->cset;
 	kargs->cset = NULL;
 
-	raw_spin_lock_irq(&css_set_lock);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		/* init tasks are special, only link regular threads */
+		if (likely(child->pid)) {
+			if (kargs->cgrp) {
+				cgrp_flags = kargs->cgrp->flags;
+				cgrp_kill_seq = kargs->cgrp->kill_seq;
+			} else {
+				cgrp_flags = cset->dfl_cgrp->flags;
+				cgrp_kill_seq = cset->dfl_cgrp->kill_seq;
+			}
 
-	/* init tasks are special, only link regular threads */
-	if (likely(child->pid)) {
-		if (kargs->cgrp) {
-			cgrp_flags = kargs->cgrp->flags;
-			cgrp_kill_seq = kargs->cgrp->kill_seq;
+			WARN_ON_ONCE(!list_empty(&child->cg_list));
+			cset->nr_tasks++;
+			css_set_move_task(child, NULL, cset, false);
 		} else {
-			cgrp_flags = cset->dfl_cgrp->flags;
-			cgrp_kill_seq = cset->dfl_cgrp->kill_seq;
+			put_css_set(cset);
+			cset = NULL;
 		}
 
-		WARN_ON_ONCE(!list_empty(&child->cg_list));
-		cset->nr_tasks++;
-		css_set_move_task(child, NULL, cset, false);
-	} else {
-		put_css_set(cset);
-		cset = NULL;
-	}
-
-	if (!(child->flags & PF_KTHREAD)) {
-		if (unlikely(test_bit(CGRP_FREEZE, &cgrp_flags))) {
-			/*
-			 * If the cgroup has to be frozen, the new task has
-			 * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
-			 * get the task into the frozen state.
-			 */
-			spin_lock(&child->sighand->siglock);
-			WARN_ON_ONCE(child->frozen);
-			child->jobctl |= JOBCTL_TRAP_FREEZE;
-			spin_unlock(&child->sighand->siglock);
+		if (!(child->flags & PF_KTHREAD)) {
+			if (unlikely(test_bit(CGRP_FREEZE, &cgrp_flags))) {
+				/*
+				 * If the cgroup has to be frozen, the new task
+				 * has too. Let's set the JOBCTL_TRAP_FREEZE
+				 * jobctl bit to get the task into the frozen
+				 * state.
+				 */
+				spin_lock(&child->sighand->siglock);
+				WARN_ON_ONCE(child->frozen);
+				child->jobctl |= JOBCTL_TRAP_FREEZE;
+				spin_unlock(&child->sighand->siglock);
+
+				/*
+				 * Calling cgroup_update_frozen() isn't required
+				 * here, because it will be called anyway a bit
+				 * later from do_freezer_trap(). So we avoid
+				 * cgroup's transient switch from the frozen
+				 * state and back.
+				 */
+			}
 
 			/*
-			 * Calling cgroup_update_frozen() isn't required here,
-			 * because it will be called anyway a bit later from
-			 * do_freezer_trap(). So we avoid cgroup's transient
-			 * switch from the frozen state and back.
+			 * If the cgroup is to be killed notice it now and take
+			 * the child down right after we finished preparing it
+			 * for userspace.
 			 */
+			kill = kargs->kill_seq != cgrp_kill_seq;
 		}
-
-		/*
-		 * If the cgroup is to be killed notice it now and take the
-		 * child down right after we finished preparing it for
-		 * userspace.
-		 */
-		kill = kargs->kill_seq != cgrp_kill_seq;
 	}
 
-	raw_spin_unlock_irq(&css_set_lock);
-
 	/*
 	 * Call ss->fork().  This must happen after @child is linked on
 	 * css_set; otherwise, @child might change state between ->fork()
@@ -6995,9 +6958,8 @@ void cgroup_task_exit(struct task_struct
 void cgroup_task_dead(struct task_struct *tsk)
 {
 	struct css_set *cset;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&css_set_lock, flags);
+	guard(raw_spinlock_irqsave)(&css_set_lock);
 
 	WARN_ON_ONCE(list_empty(&tsk->cg_list));
 	cset = task_css_set(tsk);
@@ -7014,8 +6976,6 @@ void cgroup_task_dead(struct task_struct
 	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
 		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
 		cgroup_update_frozen(task_dfl_cgroup(tsk));
-
-	raw_spin_unlock_irqrestore(&css_set_lock, flags);
 }
 
 void cgroup_task_release(struct task_struct *task)
@@ -7033,10 +6993,10 @@ void cgroup_task_free(struct task_struct
 	struct css_set *cset = task_css_set(task);
 
 	if (!list_empty(&task->cg_list)) {
-		raw_spin_lock_irq(&css_set_lock);
-		css_set_skip_task_iters(task_css_set(task), task);
-		list_del_init(&task->cg_list);
-		raw_spin_unlock_irq(&css_set_lock);
+		scoped_guard (raw_spinlock_irq, &css_set_lock) {
+			css_set_skip_task_iters(task_css_set(task), task);
+			list_del_init(&task->cg_list);
+		}
 	}
 
 	put_css_set(cset);
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -40,33 +40,34 @@ static u64 debug_taskcount_read(struct c
 static int current_css_set_read(struct seq_file *seq, void *v)
 {
 	struct kernfs_open_file *of = seq->private;
-	struct css_set *cset;
-	struct cgroup_subsys *ss;
-	struct cgroup_subsys_state *css;
-	int i, refcnt;
 
 	if (!cgroup_kn_lock_live(of->kn, false))
 		return -ENODEV;
 
-	raw_spin_lock_irq(&css_set_lock);
-	cset = task_css_set(current);
-	refcnt = refcount_read(&cset->refcount);
-	seq_printf(seq, "css_set %pK %d", cset, refcnt);
-	if (refcnt > cset->nr_tasks)
-		seq_printf(seq, " +%d", refcnt - cset->nr_tasks);
-	seq_puts(seq, "\n");
-
-	/*
-	 * Print the css'es stored in the current css_set.
-	 */
-	for_each_subsys(ss, i) {
-		css = cset->subsys[ss->id];
-		if (!css)
-			continue;
-		seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
-			  css, css->id);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		struct css_set *cset = task_css_set(current);
+		struct cgroup_subsys *ss;
+		struct cgroup_subsys_state *css;
+		int i, refcnt;
+
+		refcnt = refcount_read(&cset->refcount);
+		seq_printf(seq, "css_set %pK %d", cset, refcnt);
+		if (refcnt > cset->nr_tasks)
+			seq_printf(seq, " +%d", refcnt - cset->nr_tasks);
+		seq_puts(seq, "\n");
+
+		/*
+		 * Print the css'es stored in the current css_set.
+		 */
+		for_each_subsys(ss, i) {
+			css = cset->subsys[ss->id];
+			if (!css)
+				continue;
+			seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
+				   css, css->id);
+		}
 	}
-	raw_spin_unlock_irq(&css_set_lock);
+
 	cgroup_kn_unlock(of->kn);
 	return 0;
 }
@@ -86,13 +87,13 @@ static int current_css_set_cg_links_read
 {
 	struct cgrp_cset_link *link;
 	struct css_set *cset;
-	char *name_buf;
 
-	name_buf = kmalloc(NAME_MAX + 1, GFP_KERNEL);
+	char *name_buf __free(kfree) = kmalloc(NAME_MAX + 1, GFP_KERNEL);
 	if (!name_buf)
 		return -ENOMEM;
 
-	raw_spin_lock_irq(&css_set_lock);
+	guard(raw_spinlock_irq)(&css_set_lock);
+
 	cset = task_css_set(current);
 	list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
 		struct cgroup *c = link->cgrp;
@@ -101,8 +102,7 @@ static int current_css_set_cg_links_read
 		seq_printf(seq, "Root %d group %s\n",
 			   c->root->hierarchy_id, name_buf);
 	}
-	raw_spin_unlock_irq(&css_set_lock);
-	kfree(name_buf);
+
 	return 0;
 }
 
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -108,12 +108,12 @@ void cgroup_enter_frozen(void)
 	if (current->frozen)
 		return;
 
-	raw_spin_lock_irq(&css_set_lock);
+	guard (raw_spinlock_irq)(&css_set_lock);
+
 	current->frozen = true;
 	cgrp = task_dfl_cgroup(current);
 	cgroup_inc_frozen_cnt(cgrp);
 	cgroup_update_frozen(cgrp);
-	raw_spin_unlock_irq(&css_set_lock);
 }
 
 /*
@@ -129,7 +129,8 @@ void cgroup_leave_frozen(bool always_lea
 {
 	struct cgroup *cgrp;
 
-	raw_spin_lock_irq(&css_set_lock);
+	guard (raw_spinlock_irq)(&css_set_lock);
+
 	cgrp = task_dfl_cgroup(current);
 	if (always_leave || !test_bit(CGRP_FREEZE, &cgrp->flags)) {
 		cgroup_dec_frozen_cnt(cgrp);
@@ -142,7 +143,6 @@ void cgroup_leave_frozen(bool always_lea
 		set_thread_flag(TIF_SIGPENDING);
 		spin_unlock(&current->sighand->siglock);
 	}
-	raw_spin_unlock_irq(&css_set_lock);
 }
 
 /*
@@ -178,18 +178,18 @@ static void cgroup_do_freeze(struct cgro
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	raw_spin_lock_irq(&css_set_lock);
-	write_seqcount_begin(&cgrp->freezer.freeze_seq);
-	if (freeze) {
-		set_bit(CGRP_FREEZE, &cgrp->flags);
-		cgrp->freezer.freeze_start_nsec = ts_nsec;
-	} else {
-		clear_bit(CGRP_FREEZE, &cgrp->flags);
-		cgrp->freezer.frozen_nsec += (ts_nsec -
-			cgrp->freezer.freeze_start_nsec);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		write_seqcount_begin(&cgrp->freezer.freeze_seq);
+		if (freeze) {
+			set_bit(CGRP_FREEZE, &cgrp->flags);
+			cgrp->freezer.freeze_start_nsec = ts_nsec;
+		} else {
+			clear_bit(CGRP_FREEZE, &cgrp->flags);
+			cgrp->freezer.frozen_nsec +=
+				(ts_nsec - cgrp->freezer.freeze_start_nsec);
+		}
+		write_seqcount_end(&cgrp->freezer.freeze_seq);
 	}
-	write_seqcount_end(&cgrp->freezer.freeze_seq);
-	raw_spin_unlock_irq(&css_set_lock);
 
 	if (freeze)
 		TRACE_CGROUP_PATH(freeze, cgrp);
@@ -212,10 +212,10 @@ static void cgroup_do_freeze(struct cgro
 	 * Cgroup state should be revisited here to cover empty leaf cgroups
 	 * and cgroups which descendants are already in the desired state.
 	 */
-	raw_spin_lock_irq(&css_set_lock);
-	if (cgrp->nr_descendants == cgrp->freezer.nr_frozen_descendants)
-		cgroup_update_frozen(cgrp);
-	raw_spin_unlock_irq(&css_set_lock);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		if (cgrp->nr_descendants == cgrp->freezer.nr_frozen_descendants)
+			cgroup_update_frozen(cgrp);
+	}
 }
 
 /*
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -70,10 +70,10 @@ struct cgroup_namespace *copy_cgroup_ns(
 		return ERR_PTR(-ENOSPC);
 
 	/* It is not safe to take cgroup_mutex here */
-	raw_spin_lock_irq(&css_set_lock);
-	cset = task_css_set(current);
-	get_css_set(cset);
-	raw_spin_unlock_irq(&css_set_lock);
+	scoped_guard (raw_spinlock_irq, &css_set_lock) {
+		cset = task_css_set(current);
+		get_css_set(cset);
+	}
 
 	new_ns = alloc_cgroup_ns();
 	if (IS_ERR(new_ns)) {

