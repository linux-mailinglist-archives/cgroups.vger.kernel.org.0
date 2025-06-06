Return-Path: <cgroups+bounces-8456-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C54C2AD0685
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 18:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0712E18908FA
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B8A28A1CF;
	Fri,  6 Jun 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCdCwFXC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CFC289E1E;
	Fri,  6 Jun 2025 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749226740; cv=none; b=TZPC7wivowUtTaNerXPLkKy4MmTzVynduCjuRFDTbKqPMw6e6eoG2hoX5JofwTfEAJIKJB7xJc414yy6Ua7BCNajV2+apb23DjTiMus8oW3QtTEPygChHpDyWBB3ZHqc8EcTdsDLZJY8+DHWpefNpoP+GTO907J6BkP62qItqF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749226740; c=relaxed/simple;
	bh=66uE4ADvwMO+JAwbLytri/SGyTvQWdDnR/8WUrZcnu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8VjlXAVpkVcgGBHuEE3atcLSV5oX2vNFceDTncxYi72jkoDVsWk0OepHIuB4TJXKbCT3Vd+oE53OwnabSpBISmNP8gXrzAObARpRYOg5248tQUWL2clby/NU/5TCfodVVBVqHBgnvthEcwIv5kEtf2RO9/qPIelaijUQN8hli0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCdCwFXC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73972a54919so2126966b3a.3;
        Fri, 06 Jun 2025 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749226737; x=1749831537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOGlw03uEXEglmTbHf49Wqe0F7+bcmF9jdey3sgb7do=;
        b=VCdCwFXCqdYkcY4Xq72a5XGaAaTHxnmGlUPl8rw9aBbrluZMJyGl8ATazOgK3G1mmJ
         Z2ggp1yyhxy0YqfXK5VvdJjay309dzIHpxcV2zxkBVnzAVX2ucT2gh8Hps+6//c2hbbC
         1ZbhaKQmQiZceN4DExLSjVanRwrXKmB4Hg4qpRQgUMD5fZP2p4ywcbKSMskyRhky92Q6
         le1n8xkkl0WHp9L31nDFSjD/P1XWOqDAvZjGixcE0PukAJ92BnIuOQtsiR/aMTDr0Wp1
         Zc4VUBU16V9KXG2wiSBmOLORHdVZMHQNmca9mjypJ5qEzorb50lQ6hEdJguyzgqwGRM1
         EXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749226737; x=1749831537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOGlw03uEXEglmTbHf49Wqe0F7+bcmF9jdey3sgb7do=;
        b=KirRaNWPOlUKlLwuPbR9vjsbQHW0dU30GCuCNuttXJum1Rw0wqKBCH//4UpSm9Uoe4
         Z2H+uFD2Fkvb7Nhm7hIfY9YjnhukrEbr5uNKRztRjG1jckiG6BM2LZpiOhxqCFXVD700
         7R5EdlivtupSBIuuff0eMcbG3EkEnkfhx0pMLsjshW1qpLjVI4G4vhgz9E5t8FJzLsQh
         36GFD6kZBqvlDs1bCX8k/7CMwRrkAflffr8TuZmjX4+VwSlh4hKKCLg8D9hTj+k49DpV
         5Y67Kr03567yOUr4dRWwAUcbL5zYO4NilMnx9R4I9gNWAAjMeJ/HuNlL4H2aVEEVPzaV
         WRew==
X-Forwarded-Encrypted: i=1; AJvYcCVDez6guwNmq/Bc6PaRC81gVeRGox90DUkSkSftw4cniqrH3hx9Fx0YNi5N0JI5Fj0Re3YvNWFvcHFbm6ii@vger.kernel.org, AJvYcCXV+ubV0XfNYzwXAB5BZDHxYboDdsBNj0Pq3Ze4F9jV4fttUFWOfLvlHEptUB/o/LBfcwezCXGp@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8zqeZkbyMlEPY7JCXUZsOUxeZHY4x4+wqOmbT3HC9uygPAGm
	fjjcguSfaB99bnWo+Zb8hHGF4iT7q5QINmrd8f+ZmCDqiqHr8/cWpKLP
X-Gm-Gg: ASbGncs0tY+NUbaMgXdyHWP3H3WYnpqtDNF07iPyDNMbF8DeHqlZkkGn4Jsga6tZY5Q
	hNkhd6R3vIwSwr4VuzhX3TkdfYi/XUcah6gUw/4vTimdcCopjgVJM61d5AGwZI0BtmRysdqUAci
	LYdx+FoyVtcMKS4TeYkf61ooCP2oX2QOJF2gsW6eyl/GBuwBzbWyzJJvfe0bQxNHvKY7LsLp1Qx
	3nLvEY15V5ox9/GJIFLVNjzYB0DmQIeSsRg/fsmHqjeCc39PrSdubIpd7VMKQzaHefWwXVc3Kwu
	GKjKFcfSVI80Cg0AVP2dVg2o2M+6TM4kJCJe9lfLCN4QSbOO8mcHwi2b53uaiw==
X-Google-Smtp-Source: AGHT+IGe3M+8qdP4zCxVxsd9uyxwdFMpt1ozi68ZkJe0eF5GPp6N9qZ+dH1oZ8S4SSjZyF69rqE6WA==
X-Received: by 2002:a05:6a00:993:b0:73e:23be:11fc with SMTP id d2e1a72fcca58-74827f379b0mr5443465b3a.22.1749226736294;
        Fri, 06 Jun 2025 09:18:56 -0700 (PDT)
Received: from jemmy.. ([180.172.46.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af38353sm1518675b3a.10.2025.06.06.09.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 09:18:55 -0700 (PDT)
From: Jemmy Wong <jemmywong512@gmail.com>
To: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] cgroup: add lock guard support for css_set_lock and rcu
Date: Sat,  7 Jun 2025 00:18:40 +0800
Message-ID: <20250606161841.44354-3-jemmywong512@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606161841.44354-1-jemmywong512@gmail.com>
References: <20250606161841.44354-1-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>

---
 kernel/cgroup/cgroup-v1.c |  29 +-
 kernel/cgroup/cgroup.c    | 580 ++++++++++++++++++--------------------
 kernel/cgroup/cpuset-v1.c |  16 +-
 kernel/cgroup/debug.c     | 185 ++++++------
 kernel/cgroup/freezer.c   |  28 +-
 kernel/cgroup/namespace.c |   8 +-
 6 files changed, 401 insertions(+), 445 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index f4658eda4445..fcc2d474b470 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -70,9 +70,9 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
 
-		spin_lock_irq(&css_set_lock);
-		from_cgrp = task_cgroup_from_root(from, root);
-		spin_unlock_irq(&css_set_lock);
+		scoped_guard(spinlock_irq, &css_set_lock) {
+			from_cgrp = task_cgroup_from_root(from, root);
+		}
 
 		retval = cgroup_attach_task(from_cgrp, tsk, false);
 		if (retval)
@@ -117,10 +117,10 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	cgroup_attach_lock(true);
 
 	/* all tasks in @from are being moved, all csets are source */
-	spin_lock_irq(&css_set_lock);
-	list_for_each_entry(link, &from->cset_links, cset_link)
-		cgroup_migrate_add_src(link->cset, to, &mgctx);
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		list_for_each_entry(link, &from->cset_links, cset_link)
+			cgroup_migrate_add_src(link->cset, to, &mgctx);
+	}
 
 	ret = cgroup_migrate_prepare_dst(&mgctx);
 	if (ret)
@@ -728,13 +728,12 @@ int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry)
 	 * @kn->priv's validity.  For this and css_tryget_online_from_dir(),
 	 * @kn->priv is RCU safe.  Let's do the RCU dancing.
 	 */
-	rcu_read_lock();
-	cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
-	if (!cgrp || !cgroup_tryget(cgrp)) {
-		rcu_read_unlock();
-		return -ENOENT;
+	scoped_guard(rcu) {
+		cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
+		if (!cgrp || !cgroup_tryget(cgrp)) {
+			return -ENOENT;
+		}
 	}
-	rcu_read_unlock();
 
 	css_task_iter_start(&cgrp->self, 0, &it);
 	while ((tsk = css_task_iter_next(&it))) {
@@ -1294,7 +1293,7 @@ struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id)
 	struct cgroup_root *root;
 	unsigned long flags;
 
-	rcu_read_lock();
+	guard(rcu)();
 	for_each_root(root) {
 		/* cgroup1 only*/
 		if (root == &cgrp_dfl_root)
@@ -1308,7 +1307,7 @@ struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id)
 		spin_unlock_irqrestore(&css_set_lock, flags);
 		break;
 	}
-	rcu_read_unlock();
+
 	return cgrp;
 }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 54f80afe4f65..46b677a066d1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -631,13 +631,8 @@ int __cgroup_task_count(const struct cgroup *cgrp)
  */
 int cgroup_task_count(const struct cgroup *cgrp)
 {
-	int count;
-
-	spin_lock_irq(&css_set_lock);
-	count = __cgroup_task_count(cgrp);
-	spin_unlock_irq(&css_set_lock);
-
-	return count;
+	guard(spinlock_irq)(&css_set_lock);
+	return __cgroup_task_count(cgrp);
 }
 
 static struct cgroup *kn_priv(struct kernfs_node *kn)
@@ -1202,11 +1197,11 @@ static struct css_set *find_css_set(struct css_set *old_cset,
 
 	/* First see if we already have a cgroup group that matches
 	 * the desired set */
-	spin_lock_irq(&css_set_lock);
-	cset = find_existing_css_set(old_cset, cgrp, template);
-	if (cset)
-		get_css_set(cset);
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		cset = find_existing_css_set(old_cset, cgrp, template);
+		if (cset)
+			get_css_set(cset);
+	}
 
 	if (cset)
 		return cset;
@@ -1238,34 +1233,33 @@ static struct css_set *find_css_set(struct css_set *old_cset,
 	 * find_existing_css_set() */
 	memcpy(cset->subsys, template, sizeof(cset->subsys));
 
-	spin_lock_irq(&css_set_lock);
-	/* Add reference counts and links from the new css_set. */
-	list_for_each_entry(link, &old_cset->cgrp_links, cgrp_link) {
-		struct cgroup *c = link->cgrp;
+	scoped_guard(spinlock_irq, &css_set_lock) {
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
+				&css->cgroup->e_csets[ssid]);
+			css_get(css);
+		}
 	}
 
-	spin_unlock_irq(&css_set_lock);
-
 	/*
 	 * If @cset should be threaded, look up the matching dom_cset and
 	 * link them up.  We first fully initialize @cset then look for the
@@ -1281,11 +1275,11 @@ static struct css_set *find_css_set(struct css_set *old_cset,
 			return NULL;
 		}
 
-		spin_lock_irq(&css_set_lock);
-		cset->dom_cset = dcset;
-		list_add_tail(&cset->threaded_csets_node,
-			      &dcset->threaded_csets);
-		spin_unlock_irq(&css_set_lock);
+		scoped_guard(spinlock_irq, &css_set_lock) {
+			cset->dom_cset = dcset;
+			list_add_tail(&cset->threaded_csets_node,
+				&dcset->threaded_csets);
+		}
 	}
 
 	return cset;
@@ -1362,16 +1356,14 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	 * Release all the links from cset_links to this hierarchy's
 	 * root cgroup
 	 */
-	spin_lock_irq(&css_set_lock);
-
-	list_for_each_entry_safe(link, tmp_link, &cgrp->cset_links, cset_link) {
-		list_del(&link->cset_link);
-		list_del(&link->cgrp_link);
-		kfree(link);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		list_for_each_entry_safe(link, tmp_link, &cgrp->cset_links, cset_link) {
+			list_del(&link->cset_link);
+			list_del(&link->cgrp_link);
+			kfree(link);
+		}
 	}
 
-	spin_unlock_irq(&css_set_lock);
-
 	WARN_ON_ONCE(list_empty(&root->root_list));
 	list_del_rcu(&root->root_list);
 	cgroup_root_count--;
@@ -1437,13 +1429,10 @@ current_cgns_cgroup_from_root(struct cgroup_root *root)
 
 	lockdep_assert_held(&css_set_lock);
 
-	rcu_read_lock();
-
-	cset = current->nsproxy->cgroup_ns->root_cset;
-	res = __cset_cgroup_from_root(cset, root);
-
-	rcu_read_unlock();
-
+	scoped_guard(rcu) {
+		cset = current->nsproxy->cgroup_ns->root_cset;
+		res = __cset_cgroup_from_root(cset, root);
+	}
 	/*
 	 * The namespace_sem is held by current, so the root cgroup can't
 	 * be umounted. Therefore, we can ensure that the res is non-NULL.
@@ -1867,25 +1856,25 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		rcu_assign_pointer(dcgrp->subsys[ssid], css);
 		ss->root = dst_root;
 
-		spin_lock_irq(&css_set_lock);
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
+		scoped_guard(spinlock_irq, &css_set_lock) {
+			css->cgroup = dcgrp;
+			WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
+			list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
+						e_cset_node[ss->id]) {
+				list_move_tail(&cset->e_cset_node[ss->id],
+					&dcgrp->e_csets[ss->id]);
+				/*
+				 * all css_sets of scgrp together in same order to dcgrp,
+				 * patch in-flight iterators to preserve correct iteration.
+				 * since the iterator is always advanced right away and
+				 * finished when it->cset_pos meets it->cset_head, so only
+				 * update it->cset_head is enough here.
+				 */
+				list_for_each_entry(it, &cset->task_iters, iters_node)
+					if (it->cset_head == &scgrp->e_csets[ss->id])
+						it->cset_head = &dcgrp->e_csets[ss->id];
+			}
 		}
-		spin_unlock_irq(&css_set_lock);
 
 		/* default hierarchy doesn't enable controllers by default */
 		dst_root->subsys_mask |= 1 << ssid;
@@ -1921,10 +1910,10 @@ int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 	if (!buf)
 		return -ENOMEM;
 
-	spin_lock_irq(&css_set_lock);
-	ns_cgroup = current_cgns_cgroup_from_root(kf_cgroot);
-	len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		ns_cgroup = current_cgns_cgroup_from_root(kf_cgroot);
+		len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
+	}
 
 	if (len == -E2BIG)
 		len = -ERANGE;
@@ -2175,13 +2164,13 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	 * Link the root cgroup in this hierarchy into all the css_set
 	 * objects.
 	 */
-	spin_lock_irq(&css_set_lock);
-	hash_for_each(css_set_table, i, cset, hlist) {
-		link_css_set(&tmp_links, cset, root_cgrp);
-		if (css_set_populated(cset))
-			cgroup_update_populated(root_cgrp, true);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		hash_for_each(css_set_table, i, cset, hlist) {
+			link_css_set(&tmp_links, cset, root_cgrp);
+			if (css_set_populated(cset))
+				cgroup_update_populated(root_cgrp, true);
+		}
 	}
-	spin_unlock_irq(&css_set_lock);
 
 	BUG_ON(!list_empty(&root_cgrp->self.children));
 	BUG_ON(atomic_read(&root->nr_cgrps) != 1);
@@ -2225,11 +2214,8 @@ int cgroup_do_get_tree(struct fs_context *fc)
 		struct cgroup *cgrp;
 
 		scoped_guard(cgroup_mutex) {
-			spin_lock_irq(&css_set_lock);
-
+			guard(spinlock_irq)(&css_set_lock);
 			cgrp = cset_cgroup_from_root(ctx->ns->root_cset, ctx->root);
-
-			spin_unlock_irq(&css_set_lock);
 		}
 
 		nsdentry = kernfs_node_dentry(cgrp->kn, sb);
@@ -2438,16 +2424,10 @@ int cgroup_path_ns_locked(struct cgroup *cgrp, char *buf, size_t buflen,
 int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
 		   struct cgroup_namespace *ns)
 {
-	int ret;
-
 	guard(cgroup_mutex)();
-	spin_lock_irq(&css_set_lock);
-
-	ret = cgroup_path_ns_locked(cgrp, buf, buflen, ns);
-
-	spin_unlock_irq(&css_set_lock);
+	guard(spinlock_irq)(&css_set_lock);
 
-	return ret;
+	return cgroup_path_ns_locked(cgrp, buf, buflen, ns);
 }
 EXPORT_SYMBOL_GPL(cgroup_path_ns);
 
@@ -2629,27 +2609,27 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 	 * the new cgroup.  There are no failure cases after here, so this
 	 * is the commit point.
 	 */
-	spin_lock_irq(&css_set_lock);
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
+	scoped_guard(spinlock_irq, &css_set_lock) {
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
+				 * If the source or destination cgroup is frozen,
+				 * the task might require to change its state.
+				 */
+				cgroup_freezer_migrate_task(task, from_cset->dfl_cgrp,
+							to_cset->dfl_cgrp);
+				put_css_set_locked(from_cset);
 
+			}
 		}
 	}
-	spin_unlock_irq(&css_set_lock);
 
 	/*
 	 * Migration is committed, all target tasks are now on dst_csets.
@@ -2682,13 +2662,13 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 		} while_each_subsys_mask();
 	}
 out_release_tset:
-	spin_lock_irq(&css_set_lock);
-	list_splice_init(&tset->dst_csets, &tset->src_csets);
-	list_for_each_entry_safe(cset, tmp_cset, &tset->src_csets, mg_node) {
-		list_splice_tail_init(&cset->mg_tasks, &cset->tasks);
-		list_del_init(&cset->mg_node);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		list_splice_init(&tset->dst_csets, &tset->src_csets);
+		list_for_each_entry_safe(cset, tmp_cset, &tset->src_csets, mg_node) {
+			list_splice_tail_init(&cset->mg_tasks, &cset->tasks);
+			list_del_init(&cset->mg_node);
+		}
 	}
-	spin_unlock_irq(&css_set_lock);
 
 	/*
 	 * Re-initialize the cgroup_taskset structure in case it is reused
@@ -2746,7 +2726,7 @@ void cgroup_migrate_finish(struct cgroup_mgctx *mgctx)
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	spin_lock_irq(&css_set_lock);
+	guard(spinlock_irq)(&css_set_lock);
 
 	list_for_each_entry_safe(cset, tmp_cset, &mgctx->preloaded_src_csets,
 				 mg_src_preload_node) {
@@ -2765,8 +2745,6 @@ void cgroup_migrate_finish(struct cgroup_mgctx *mgctx)
 		list_del_init(&cset->mg_dst_preload_node);
 		put_css_set_locked(cset);
 	}
-
-	spin_unlock_irq(&css_set_lock);
 }
 
 /**
@@ -2909,14 +2887,14 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
 	 * section to prevent tasks from being freed while taking the snapshot.
 	 * spin_lock_irq() implies RCU critical section here.
 	 */
-	spin_lock_irq(&css_set_lock);
-	task = leader;
-	do {
-		cgroup_migrate_add_task(task, mgctx);
-		if (!threadgroup)
-			break;
-	} while_each_thread(leader, task);
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		task = leader;
+		do {
+			cgroup_migrate_add_task(task, mgctx);
+			if (!threadgroup)
+				break;
+		} while_each_thread(leader, task);
+	}
 
 	return cgroup_migrate_execute(mgctx);
 }
@@ -2937,16 +2915,15 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 	int ret = 0;
 
 	/* look up all src csets */
-	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
-	task = leader;
-	do {
-		cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
-		if (!threadgroup)
-			break;
-	} while_each_thread(leader, task);
-	rcu_read_unlock();
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		guard(rcu)();
+		task = leader;
+		do {
+			cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
+			if (!threadgroup)
+				break;
+		} while_each_thread(leader, task);
+	}
 
 	/* prepare dst csets and commit */
 	ret = cgroup_migrate_prepare_dst(&mgctx);
@@ -3088,23 +3065,23 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	lockdep_assert_held(&cgroup_mutex);
 
 	/* look up all csses currently attached to @cgrp's subtree */
-	spin_lock_irq(&css_set_lock);
-	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
-		struct cgrp_cset_link *link;
+	scoped_guard(spinlock_irq, &css_set_lock) {
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
-	spin_unlock_irq(&css_set_lock);
 
 	/*
 	 * We need to write-lock threadgroup_rwsem while migrating tasks.
@@ -3120,16 +3097,16 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	if (ret)
 		goto out_finish;
 
-	spin_lock_irq(&css_set_lock);
-	list_for_each_entry(src_cset, &mgctx.preloaded_src_csets,
-			    mg_src_preload_node) {
-		struct task_struct *task, *ntask;
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		list_for_each_entry(src_cset, &mgctx.preloaded_src_csets,
+				mg_src_preload_node) {
+			struct task_struct *task, *ntask;
 
-		/* all tasks in src_csets need to be migrated */
-		list_for_each_entry_safe(task, ntask, &src_cset->tasks, cg_list)
-			cgroup_migrate_add_task(task, &mgctx);
+			/* all tasks in src_csets need to be migrated */
+			list_for_each_entry_safe(task, ntask, &src_cset->tasks, cg_list)
+				cgroup_migrate_add_task(task, &mgctx);
+		}
 	}
-	spin_unlock_irq(&css_set_lock);
 
 	ret = cgroup_migrate_execute(&mgctx);
 out_finish:
@@ -3734,7 +3711,8 @@ static int cgroup_stat_show(struct seq_file *seq, void *v)
 	 * Without proper lock protection, racing is possible. So the
 	 * numbers may not be consistent when that happens.
 	 */
-	rcu_read_lock();
+	guard(rcu)();
+
 	for (ssid = 0; ssid < CGROUP_SUBSYS_COUNT; ssid++) {
 		dying_cnt[ssid] = -1;
 		if ((BIT(ssid) & cgrp_dfl_inhibit_ss_mask) ||
@@ -3753,7 +3731,6 @@ static int cgroup_stat_show(struct seq_file *seq, void *v)
 			seq_printf(seq, "nr_dying_subsys_%s %d\n",
 				   cgroup_subsys[ssid]->name, dying_cnt[ssid]);
 	}
-	rcu_read_unlock();
 	return 0;
 }
 
@@ -3771,11 +3748,10 @@ static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
 {
 	struct cgroup_subsys_state *css;
 
-	rcu_read_lock();
+	guard(rcu)();
 	css = cgroup_css(cgrp, ss);
 	if (css && !css_tryget_online(css))
 		css = NULL;
-	rcu_read_unlock();
 
 	return css;
 }
@@ -4056,9 +4032,9 @@ static void __cgroup_kill(struct cgroup *cgrp)
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	spin_lock_irq(&css_set_lock);
-	cgrp->kill_seq++;
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		cgrp->kill_seq++;
+	}
 
 	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
 	while ((task = css_task_iter_next(&it))) {
@@ -4187,9 +4163,9 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 	 * doesn't need to be pinned.  The RCU locking is not necessary
 	 * either.  It's just for the convenience of using cgroup_css().
 	 */
-	rcu_read_lock();
-	css = cgroup_css(cgrp, cft->ss);
-	rcu_read_unlock();
+	scoped_guard(rcu) {
+		css = cgroup_css(cgrp, cft->ss);
+	}
 
 	if (cft->write_u64) {
 		unsigned long long v;
@@ -4815,14 +4791,14 @@ bool css_has_online_children(struct cgroup_subsys_state *css)
 	struct cgroup_subsys_state *child;
 	bool ret = false;
 
-	rcu_read_lock();
+	guard(rcu)();
 	css_for_each_child(child, css) {
 		if (child->flags & CSS_ONLINE) {
 			ret = true;
 			break;
 		}
 	}
-	rcu_read_unlock();
+
 	return ret;
 }
 
@@ -5247,9 +5223,9 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 		goto out_unlock;
 
 	/* find the source cgroup */
-	spin_lock_irq(&css_set_lock);
-	src_cgrp = task_cgroup_from_root(task, &cgrp_dfl_root);
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		src_cgrp = task_cgroup_from_root(task, &cgrp_dfl_root);
+	}
 
 	/*
 	 * Process and thread migrations follow same delegation rule. Check
@@ -5531,11 +5507,11 @@ static inline void css_release_work_fn_locked(struct work_struct *work)
 
 		css_rstat_flush(&cgrp->self);
 
-		spin_lock_irq(&css_set_lock);
-		for (tcgrp = cgroup_parent(cgrp); tcgrp;
-		     tcgrp = cgroup_parent(tcgrp))
-			tcgrp->nr_dying_descendants--;
-		spin_unlock_irq(&css_set_lock);
+		scoped_guard(spinlock_irq, &css_set_lock) {
+			for (tcgrp = cgroup_parent(cgrp); tcgrp;
+				tcgrp = cgroup_parent(tcgrp))
+					tcgrp->nr_dying_descendants--;
+		}
 
 		/*
 		 * There are two control paths which try to determine
@@ -5790,20 +5766,20 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 		goto out_psi_free;
 
 	/* allocation complete, commit to creation */
-	spin_lock_irq(&css_set_lock);
-	for (i = 0; i < level; i++) {
-		tcgrp = cgrp->ancestors[i];
-		tcgrp->nr_descendants++;
+	scoped_guard(spinlock_irq, &css_set_lock) {
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
+			 * If the new cgroup is frozen, all ancestor cgroups get a new
+			 * frozen descendant, but their state can't change because of
+			 * this.
+			 */
+			if (cgrp->freezer.e_freeze)
+				tcgrp->freezer.nr_frozen_descendants++;
+		}
 	}
-	spin_unlock_irq(&css_set_lock);
 
 	list_add_tail_rcu(&cgrp->self.sibling, &cgroup_parent(cgrp)->self.children);
 	atomic_inc(&root->nr_cgrps);
@@ -6047,10 +6023,10 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 	 */
 	cgrp->self.flags &= ~CSS_ONLINE;
 
-	spin_lock_irq(&css_set_lock);
-	list_for_each_entry(link, &cgrp->cset_links, cset_link)
-		link->cset->dead = true;
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		list_for_each_entry(link, &cgrp->cset_links, cset_link)
+			link->cset->dead = true;
+	}
 
 	/* initiate massacre of all css's */
 	for_each_css(css, ssid, cgrp)
@@ -6063,18 +6039,18 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 	if (cgroup_is_threaded(cgrp))
 		parent->nr_threaded_children--;
 
-	spin_lock_irq(&css_set_lock);
-	for (tcgrp = parent; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
-		tcgrp->nr_descendants--;
-		tcgrp->nr_dying_descendants++;
-		/*
-		 * If the dying cgroup is frozen, decrease frozen descendants
-		 * counters of ancestor cgroups.
-		 */
-		if (test_bit(CGRP_FROZEN, &cgrp->flags))
-			tcgrp->freezer.nr_frozen_descendants--;
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		for (tcgrp = parent; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
+			tcgrp->nr_descendants--;
+			tcgrp->nr_dying_descendants++;
+			/*
+			 * If the dying cgroup is frozen, decrease frozen descendants
+			 * counters of ancestor cgroups.
+			 */
+			if (test_bit(CGRP_FROZEN, &cgrp->flags))
+				tcgrp->freezer.nr_frozen_descendants--;
+		}
 	}
-	spin_unlock_irq(&css_set_lock);
 
 	cgroup1_check_for_release(parent);
 
@@ -6356,13 +6332,12 @@ struct cgroup *cgroup_get_from_id(u64 id)
 		return ERR_PTR(-ENOENT);
 	}
 
-	rcu_read_lock();
-
-	cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
-	if (cgrp && !cgroup_tryget(cgrp))
-		cgrp = NULL;
+	scoped_guard(rcu) {
+		cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
+		if (cgrp && !cgroup_tryget(cgrp))
+			cgrp = NULL;
+	}
 
-	rcu_read_unlock();
 	kernfs_put(kn);
 
 	if (!cgrp)
@@ -6539,14 +6514,14 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 
 	cgroup_threadgroup_change_begin(current);
 
-	spin_lock_irq(&css_set_lock);
-	cset = task_css_set(current);
-	get_css_set(cset);
-	if (kargs->cgrp)
-		kargs->kill_seq = kargs->cgrp->kill_seq;
-	else
-		kargs->kill_seq = cset->dfl_cgrp->kill_seq;
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		cset = task_css_set(current);
+		get_css_set(cset);
+		if (kargs->cgrp)
+			kargs->kill_seq = kargs->cgrp->kill_seq;
+		else
+			kargs->kill_seq = cset->dfl_cgrp->kill_seq;
+	}
 
 	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
 		kargs->cset = cset;
@@ -6736,56 +6711,53 @@ void cgroup_post_fork(struct task_struct *child,
 	cset = kargs->cset;
 	kargs->cset = NULL;
 
-	spin_lock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
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
+				 * If the cgroup has to be frozen, the new task has
+				 * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
+				 * get the task into the frozen state.
+				 */
+				spin_lock(&child->sighand->siglock);
+				WARN_ON_ONCE(child->frozen);
+				child->jobctl |= JOBCTL_TRAP_FREEZE;
+				spin_unlock(&child->sighand->siglock);
+
+				/*
+				 * Calling cgroup_update_frozen() isn't required here,
+				 * because it will be called anyway a bit later from
+				 * do_freezer_trap(). So we avoid cgroup's transient
+				 * switch from the frozen state and back.
+				 */
+			}
 
 			/*
-			 * Calling cgroup_update_frozen() isn't required here,
-			 * because it will be called anyway a bit later from
-			 * do_freezer_trap(). So we avoid cgroup's transient
-			 * switch from the frozen state and back.
+			 * If the cgroup is to be killed notice it now and take the
+			 * child down right after we finished preparing it for
+			 * userspace.
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
-
-	spin_unlock_irq(&css_set_lock);
-
 	/*
 	 * Call ss->fork().  This must happen after @child is linked on
 	 * css_set; otherwise, @child might change state between ->fork()
@@ -6824,25 +6796,23 @@ void cgroup_exit(struct task_struct *tsk)
 	struct css_set *cset;
 	int i;
 
-	spin_lock_irq(&css_set_lock);
-
-	WARN_ON_ONCE(list_empty(&tsk->cg_list));
-	cset = task_css_set(tsk);
-	css_set_move_task(tsk, cset, NULL, false);
-	cset->nr_tasks--;
-	/* matches the signal->live check in css_task_iter_advance() */
-	if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
-		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
-
-	if (dl_task(tsk))
-		dec_dl_tasks_cs(tsk);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		WARN_ON_ONCE(list_empty(&tsk->cg_list));
+		cset = task_css_set(tsk);
+		css_set_move_task(tsk, cset, NULL, false);
+		cset->nr_tasks--;
+		/* matches the signal->live check in css_task_iter_advance() */
+		if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
+			list_add_tail(&tsk->cg_list, &cset->dying_tasks);
 
-	WARN_ON_ONCE(cgroup_task_frozen(tsk));
-	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
-		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
-		cgroup_update_frozen(task_dfl_cgroup(tsk));
+		if (dl_task(tsk))
+			dec_dl_tasks_cs(tsk);
 
-	spin_unlock_irq(&css_set_lock);
+		WARN_ON_ONCE(cgroup_task_frozen(tsk));
+		if (unlikely(!(tsk->flags & PF_KTHREAD) &&
+			test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
+			cgroup_update_frozen(task_dfl_cgroup(tsk));
+	}
 
 	/* see cgroup_post_fork() for details */
 	do_each_subsys_mask(ss, i, have_exit_callback) {
@@ -6860,10 +6830,9 @@ void cgroup_release(struct task_struct *task)
 	} while_each_subsys_mask();
 
 	if (!list_empty(&task->cg_list)) {
-		spin_lock_irq(&css_set_lock);
+		guard(spinlock_irq)(&css_set_lock);
 		css_set_skip_task_iters(task_css_set(task), task);
 		list_del_init(&task->cg_list);
-		spin_unlock_irq(&css_set_lock);
 	}
 }
 
@@ -6944,7 +6913,7 @@ struct cgroup_subsys_state *css_tryget_online_from_dir(struct dentry *dentry,
 	    !kn || kernfs_type(kn) != KERNFS_DIR)
 		return ERR_PTR(-EBADF);
 
-	rcu_read_lock();
+	guard(rcu)();
 
 	/*
 	 * This path doesn't originate from kernfs and @kn could already
@@ -6958,7 +6927,6 @@ struct cgroup_subsys_state *css_tryget_online_from_dir(struct dentry *dentry,
 	if (!css || !css_tryget_online(css))
 		css = ERR_PTR(-ENOENT);
 
-	rcu_read_unlock();
 	return css;
 }
 
@@ -7001,13 +6969,11 @@ struct cgroup *cgroup_get_from_path(const char *path)
 		goto out_kernfs;
 	}
 
-	rcu_read_lock();
-
-	cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
-	if (!cgrp || !cgroup_tryget(cgrp))
-		cgrp = ERR_PTR(-ENOENT);
-
-	rcu_read_unlock();
+	scoped_guard(rcu) {
+		cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
+		if (!cgrp || !cgroup_tryget(cgrp))
+			cgrp = ERR_PTR(-ENOENT);
+	}
 
 out_kernfs:
 	kernfs_put(kn);
@@ -7106,28 +7072,28 @@ void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
 {
 	struct cgroup *cgroup;
 
-	rcu_read_lock();
-	/* Don't associate the sock with unrelated interrupted task's cgroup. */
-	if (in_interrupt()) {
-		cgroup = &cgrp_dfl_root.cgrp;
-		cgroup_get(cgroup);
-		goto out;
-	}
+	scoped_guard(rcu) {
+		/* Don't associate the sock with unrelated interrupted task's cgroup. */
+		if (in_interrupt()) {
+			cgroup = &cgrp_dfl_root.cgrp;
+			cgroup_get(cgroup);
+			break;
+		}
 
-	while (true) {
-		struct css_set *cset;
+		while (true) {
+			struct css_set *cset;
 
-		cset = task_css_set(current);
-		if (likely(cgroup_tryget(cset->dfl_cgrp))) {
-			cgroup = cset->dfl_cgrp;
-			break;
+			cset = task_css_set(current);
+			if (likely(cgroup_tryget(cset->dfl_cgrp))) {
+				cgroup = cset->dfl_cgrp;
+				break;
+			}
+			cpu_relax();
 		}
-		cpu_relax();
+
+		skcd->cgroup = cgroup;
+		cgroup_bpf_get(cgroup);
 	}
-out:
-	skcd->cgroup = cgroup;
-	cgroup_bpf_get(cgroup);
-	rcu_read_unlock();
 }
 
 void cgroup_sk_clone(struct sock_cgroup_data *skcd)
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index b69a7db67090..114a63432d23 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -140,9 +140,8 @@ int cpuset_memory_pressure_enabled __read_mostly;
 
 void __cpuset_memory_pressure_bump(void)
 {
-	rcu_read_lock();
+	guard(rcu)();
 	fmeter_markevent(&task_cs(current)->fmeter);
-	rcu_read_unlock();
 }
 
 static int update_relax_domain_level(struct cpuset *cs, s64 val)
@@ -393,13 +392,12 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
 	if (!buf)
 		goto out;
 
-	rcu_read_lock();
-	spin_lock_irq(&css_set_lock);
-	css = task_css(tsk, cpuset_cgrp_id);
-	retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
-				       current->nsproxy->cgroup_ns);
-	spin_unlock_irq(&css_set_lock);
-	rcu_read_unlock();
+	scoped_guard(rcu) {
+		guard(spinlock_irq)(&css_set_lock);
+		css = task_css(tsk, cpuset_cgrp_id);
+		retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
+					current->nsproxy->cgroup_ns);
+	}
 
 	if (retval == -E2BIG)
 		retval = -ENAMETOOLONG;
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 80aa3f027ac3..2f04db56c8ac 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -48,27 +48,26 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 	if (!cgroup_kn_lock_live(of->kn, false))
 		return -ENODEV;
 
-	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
-	cset = task_css_set(current);
-	refcnt = refcount_read(&cset->refcount);
-	seq_printf(seq, "css_set %pK %d", cset, refcnt);
-	if (refcnt > cset->nr_tasks)
-		seq_printf(seq, " +%d", refcnt - cset->nr_tasks);
-	seq_puts(seq, "\n");
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		guard(rcu)();
+		cset = task_css_set(current);
+		refcnt = refcount_read(&cset->refcount);
+		seq_printf(seq, "css_set %pK %d", cset, refcnt);
+		if (refcnt > cset->nr_tasks)
+			seq_printf(seq, " +%d", refcnt - cset->nr_tasks);
+		seq_puts(seq, "\n");
 
-	/*
-	 * Print the css'es stored in the current css_set.
-	 */
-	for_each_subsys(ss, i) {
-		css = cset->subsys[ss->id];
-		if (!css)
-			continue;
-		seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
-			  css, css->id);
+		/*
+		* Print the css'es stored in the current css_set.
+		*/
+		for_each_subsys(ss, i) {
+			css = cset->subsys[ss->id];
+			if (!css)
+				continue;
+			seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
+				css, css->id);
+		}
 	}
-	rcu_read_unlock();
-	spin_unlock_irq(&css_set_lock);
 	cgroup_kn_unlock(of->kn);
 	return 0;
 }
@@ -76,12 +75,8 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 static u64 current_css_set_refcount_read(struct cgroup_subsys_state *css,
 					 struct cftype *cft)
 {
-	u64 count;
-
-	rcu_read_lock();
-	count = refcount_read(&task_css_set(current)->refcount);
-	rcu_read_unlock();
-	return count;
+	guard(rcu)();
+	return refcount_read(&task_css_set(current)->refcount);
 }
 
 static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
@@ -94,18 +89,17 @@ static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
 	if (!name_buf)
 		return -ENOMEM;
 
-	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
-	cset = task_css_set(current);
-	list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
-		struct cgroup *c = link->cgrp;
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		guard(rcu)();
+		cset = task_css_set(current);
+		list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
+			struct cgroup *c = link->cgrp;
 
-		cgroup_name(c, name_buf, NAME_MAX + 1);
-		seq_printf(seq, "Root %d group %s\n",
-			   c->root->hierarchy_id, name_buf);
+			cgroup_name(c, name_buf, NAME_MAX + 1);
+			seq_printf(seq, "Root %d group %s\n",
+				c->root->hierarchy_id, name_buf);
+		}
 	}
-	rcu_read_unlock();
-	spin_unlock_irq(&css_set_lock);
 	kfree(name_buf);
 	return 0;
 }
@@ -117,74 +111,73 @@ static int cgroup_css_links_read(struct seq_file *seq, void *v)
 	struct cgrp_cset_link *link;
 	int dead_cnt = 0, extra_refs = 0, threaded_csets = 0;
 
-	spin_lock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		list_for_each_entry(link, &css->cgroup->cset_links, cset_link) {
+			struct css_set *cset = link->cset;
+			struct task_struct *task;
+			int count = 0;
+			int refcnt = refcount_read(&cset->refcount);
+
+			/*
+			 * Print out the proc_cset and threaded_cset relationship
+			 * and highlight difference between refcount and task_count.
+			 */
+			seq_printf(seq, "css_set %pK", cset);
+			if (rcu_dereference_protected(cset->dom_cset, 1) != cset) {
+				threaded_csets++;
+				seq_printf(seq, "=>%pK", cset->dom_cset);
+			}
+			if (!list_empty(&cset->threaded_csets)) {
+				struct css_set *tcset;
+				int idx = 0;
+
+				list_for_each_entry(tcset, &cset->threaded_csets,
+						threaded_csets_node) {
+					seq_puts(seq, idx ? "," : "<=");
+					seq_printf(seq, "%pK", tcset);
+					idx++;
+				}
+			} else {
+				seq_printf(seq, " %d", refcnt);
+				if (refcnt - cset->nr_tasks > 0) {
+					int extra = refcnt - cset->nr_tasks;
+
+					seq_printf(seq, " +%d", extra);
+					/*
+					 * Take out the one additional reference in
+					 * init_css_set.
+					 */
+					if (cset == &init_css_set)
+						extra--;
+					extra_refs += extra;
+				}
+			}
+			seq_puts(seq, "\n");
 
-	list_for_each_entry(link, &css->cgroup->cset_links, cset_link) {
-		struct css_set *cset = link->cset;
-		struct task_struct *task;
-		int count = 0;
-		int refcnt = refcount_read(&cset->refcount);
+			list_for_each_entry(task, &cset->tasks, cg_list) {
+				if (count++ <= MAX_TASKS_SHOWN_PER_CSS)
+					seq_printf(seq, "  task %d\n",
+						task_pid_vnr(task));
+			}
 
-		/*
-		 * Print out the proc_cset and threaded_cset relationship
-		 * and highlight difference between refcount and task_count.
-		 */
-		seq_printf(seq, "css_set %pK", cset);
-		if (rcu_dereference_protected(cset->dom_cset, 1) != cset) {
-			threaded_csets++;
-			seq_printf(seq, "=>%pK", cset->dom_cset);
-		}
-		if (!list_empty(&cset->threaded_csets)) {
-			struct css_set *tcset;
-			int idx = 0;
-
-			list_for_each_entry(tcset, &cset->threaded_csets,
-					    threaded_csets_node) {
-				seq_puts(seq, idx ? "," : "<=");
-				seq_printf(seq, "%pK", tcset);
-				idx++;
+			list_for_each_entry(task, &cset->mg_tasks, cg_list) {
+				if (count++ <= MAX_TASKS_SHOWN_PER_CSS)
+					seq_printf(seq, "  task %d\n",
+						task_pid_vnr(task));
 			}
-		} else {
-			seq_printf(seq, " %d", refcnt);
-			if (refcnt - cset->nr_tasks > 0) {
-				int extra = refcnt - cset->nr_tasks;
-
-				seq_printf(seq, " +%d", extra);
-				/*
-				 * Take out the one additional reference in
-				 * init_css_set.
-				 */
-				if (cset == &init_css_set)
-					extra--;
-				extra_refs += extra;
+			/* show # of overflowed tasks */
+			if (count > MAX_TASKS_SHOWN_PER_CSS)
+				seq_printf(seq, "  ... (%d)\n",
+					count - MAX_TASKS_SHOWN_PER_CSS);
+
+			if (cset->dead) {
+				seq_puts(seq, "    [dead]\n");
+				dead_cnt++;
 			}
-		}
-		seq_puts(seq, "\n");
-
-		list_for_each_entry(task, &cset->tasks, cg_list) {
-			if (count++ <= MAX_TASKS_SHOWN_PER_CSS)
-				seq_printf(seq, "  task %d\n",
-					   task_pid_vnr(task));
-		}
 
-		list_for_each_entry(task, &cset->mg_tasks, cg_list) {
-			if (count++ <= MAX_TASKS_SHOWN_PER_CSS)
-				seq_printf(seq, "  task %d\n",
-					   task_pid_vnr(task));
+			WARN_ON(count != cset->nr_tasks);
 		}
-		/* show # of overflowed tasks */
-		if (count > MAX_TASKS_SHOWN_PER_CSS)
-			seq_printf(seq, "  ... (%d)\n",
-				   count - MAX_TASKS_SHOWN_PER_CSS);
-
-		if (cset->dead) {
-			seq_puts(seq, "    [dead]\n");
-			dead_cnt++;
-		}
-
-		WARN_ON(count != cset->nr_tasks);
 	}
-	spin_unlock_irq(&css_set_lock);
 
 	if (!dead_cnt && !extra_refs && !threaded_csets)
 		return 0;
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index bf1690a167dd..01134b3af176 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -108,12 +108,12 @@ void cgroup_enter_frozen(void)
 	if (current->frozen)
 		return;
 
-	spin_lock_irq(&css_set_lock);
+	guard(spinlock_irq)(&css_set_lock);
+
 	current->frozen = true;
 	cgrp = task_dfl_cgroup(current);
 	cgroup_inc_frozen_cnt(cgrp);
 	cgroup_update_frozen(cgrp);
-	spin_unlock_irq(&css_set_lock);
 }
 
 /*
@@ -129,7 +129,8 @@ void cgroup_leave_frozen(bool always_leave)
 {
 	struct cgroup *cgrp;
 
-	spin_lock_irq(&css_set_lock);
+	guard(spinlock_irq)(&css_set_lock);
+
 	cgrp = task_dfl_cgroup(current);
 	if (always_leave || !test_bit(CGRP_FREEZE, &cgrp->flags)) {
 		cgroup_dec_frozen_cnt(cgrp);
@@ -142,7 +143,6 @@ void cgroup_leave_frozen(bool always_leave)
 		set_thread_flag(TIF_SIGPENDING);
 		spin_unlock(&current->sighand->siglock);
 	}
-	spin_unlock_irq(&css_set_lock);
 }
 
 /*
@@ -178,12 +178,12 @@ static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze)
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	spin_lock_irq(&css_set_lock);
-	if (freeze)
-		set_bit(CGRP_FREEZE, &cgrp->flags);
-	else
-		clear_bit(CGRP_FREEZE, &cgrp->flags);
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		if (freeze)
+			set_bit(CGRP_FREEZE, &cgrp->flags);
+		else
+			clear_bit(CGRP_FREEZE, &cgrp->flags);
+	}
 
 	if (freeze)
 		TRACE_CGROUP_PATH(freeze, cgrp);
@@ -206,10 +206,10 @@ static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze)
 	 * Cgroup state should be revisited here to cover empty leaf cgroups
 	 * and cgroups which descendants are already in the desired state.
 	 */
-	spin_lock_irq(&css_set_lock);
-	if (cgrp->nr_descendants == cgrp->freezer.nr_frozen_descendants)
-		cgroup_update_frozen(cgrp);
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		if (cgrp->nr_descendants == cgrp->freezer.nr_frozen_descendants)
+			cgroup_update_frozen(cgrp);
+	}
 }
 
 /*
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index 144a464e45c6..3e2454a106aa 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -71,10 +71,10 @@ struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
 		return ERR_PTR(-ENOSPC);
 
 	/* It is not safe to take cgroup_mutex here */
-	spin_lock_irq(&css_set_lock);
-	cset = task_css_set(current);
-	get_css_set(cset);
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		cset = task_css_set(current);
+		get_css_set(cset);
+	}
 
 	new_ns = alloc_cgroup_ns();
 	if (IS_ERR(new_ns)) {
-- 
2.43.0


