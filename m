Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDBA4EF190
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2019 01:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbfKEAAQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Nov 2019 19:00:16 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46291 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbfKEAAM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Nov 2019 19:00:12 -0500
Received: by mail-qt1-f194.google.com with SMTP id u22so26726834qtq.13;
        Mon, 04 Nov 2019 16:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=StDF3mAXV3B3BTVHMDmB1zfit4dLUdsFQUmlMXqBrMs=;
        b=kKrTjDPv3EYRg0aDo6aAt7w7Xz+0M/JMj1GuHqO01CKc1DAy645E66QpCbz0oW/Uyr
         NeixBRQi7Ur7qCl3lNRrQPtrfugmbXGa6d6WR519IhEIYLbmRWHMEvltyCJuohI07sk+
         gwpc+3WZJkw/wppXP7xqZQPEw8ArhyM19hDNH42kmTUiPqYNwUHLXenFSoikxJM3xRdV
         CpT7p08GC7gtXZxs4LtsN7ehktUQFQa4ufXxEa5bOysbGLMTr3gQICtUu4k1xx/Xdd8s
         yXYG1aujs/n08U9vywBv0PiclzrhYIMEGOngdVjEZI/pu6A6kkNMwvJa6aM3GLCw6xIZ
         Fq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=StDF3mAXV3B3BTVHMDmB1zfit4dLUdsFQUmlMXqBrMs=;
        b=UU9W/J+LlSesNm/IAk8CMRpRG0P5aYAPObJja3VVc/AxUcphZjnQeuK1oNK2RqkjZX
         DCuZjNIrLDA5ZKJJ61UAPd9sq2mXvxcn/O6JOMy7vL4VxcGkxbn3fP93098LzBSf5/i8
         9y6bbB9YYw8/eRhHoSxkyJSKKwPq53xhDUV9i0Nnh+KZC8OqvNYxyIEOJVdo8AuVo5wh
         irNsf6Sblio3bRPU6p5Tcf20OdMwun9KcznEVeixQMDZuBi2G4GP9l4Brn0r9Pn8I7bv
         O+Ev19zLebW74vqt8N4TagBp7+2Jg+x+0wZtAzz9n4UhbkkNH8ZdVPKPPuMfBtxrxLTv
         Cwqg==
X-Gm-Message-State: APjAAAVXNa48sqGdZ7rq3vyWsFPtJAypXigMqbaICdz4cU9yW11BO2ux
        L9I0RmgZkINsP3Cy+jWSif8=
X-Google-Smtp-Source: APXvYqxDOHc4L//HdpC3l2JkQKIp0499DrA1/Kh9t61XZn28XQu7hq1zNC2HDgagw7M9Q80IZ5A5rg==
X-Received: by 2002:ac8:862:: with SMTP id x31mr15126821qth.58.1572912010976;
        Mon, 04 Nov 2019 16:00:10 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:51f8])
        by smtp.gmail.com with ESMTPSA id n55sm10198086qta.24.2019.11.04.16.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 16:00:10 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/10] cgroup: use cgrp->kn->id as the cgroup ID
Date:   Mon,  4 Nov 2019 15:59:44 -0800
Message-Id: <20191104235944.3470866-11-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104235944.3470866-1-tj@kernel.org>
References: <20191104235944.3470866-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup ID is currently allocated using a dedicated per-hierarchy idr
and used internally and exposed through tracepoints and bpf.  This is
confusing because there are tracepoints and other interfaces which use
the cgroupfs ino as IDs.

The preceding changes made kn->id exposed as ino as 64bit ino on
supported archs or ino+gen (low 32bits as ino, high gen).  There's no
reason for cgroup to use different IDs.  The kernfs IDs are unique and
userland can easily discover them and map them back to paths using
standard file operations.

This patch replaces cgroup IDs with kernfs IDs.

* cgroup_id() is added and all cgroup ID users are converted to use it.

* kernfs_node creation is moved to earlier during cgroup init so that
  cgroup_id() is available during init.

* While at it, s/cgroup/cgrp/ in psi helpers for consistency.

* Fallback ID value is changed to 1 to be consistent with root cgroup
  ID.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/cgroup-defs.h   | 17 +-------
 include/linux/cgroup.h        | 17 ++++----
 include/trace/events/cgroup.h |  6 +--
 kernel/bpf/helpers.c          |  2 +-
 kernel/bpf/local_storage.c    |  2 +-
 kernel/cgroup/cgroup.c        | 76 ++++++++++++-----------------------
 kernel/trace/blktrace.c       |  4 +-
 net/core/filter.c             |  4 +-
 8 files changed, 43 insertions(+), 85 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 430e219e3aba..cc38408aa065 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -354,16 +354,6 @@ struct cgroup {
 
 	unsigned long flags;		/* "unsigned long" so bitops work */
 
-	/*
-	 * idr allocated in-hierarchy ID.
-	 *
-	 * ID 0 is not used, the ID of the root cgroup is always 1, and a
-	 * new cgroup will be assigned with a smallest available ID.
-	 *
-	 * Allocating/Removing ID must be protected by cgroup_mutex.
-	 */
-	int id;
-
 	/*
 	 * The depth this cgroup is at.  The root is at depth zero and each
 	 * step down the hierarchy increments the level.  This along with
@@ -488,7 +478,7 @@ struct cgroup {
 	struct cgroup_freezer_state freezer;
 
 	/* ids of the ancestors at each level including self */
-	int ancestor_ids[];
+	u64 ancestor_ids[];
 };
 
 /*
@@ -509,7 +499,7 @@ struct cgroup_root {
 	struct cgroup cgrp;
 
 	/* for cgrp->ancestor_ids[0] */
-	int cgrp_ancestor_id_storage;
+	u64 cgrp_ancestor_id_storage;
 
 	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
 	atomic_t nr_cgrps;
@@ -520,9 +510,6 @@ struct cgroup_root {
 	/* Hierarchy-specific flags */
 	unsigned int flags;
 
-	/* IDs for cgroups in this hierarchy */
-	struct idr cgroup_idr;
-
 	/* The path to use for release notifications. */
 	char release_agent_path[PATH_MAX];
 
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 815fff49d555..d7ddebd0cdec 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -304,6 +304,11 @@ void css_task_iter_end(struct css_task_iter *it);
  * Inline functions.
  */
 
+static inline u64 cgroup_id(struct cgroup *cgrp)
+{
+	return cgrp->kn->id;
+}
+
 /**
  * css_get - obtain a reference on the specified css
  * @css: target css
@@ -565,7 +570,7 @@ static inline bool cgroup_is_descendant(struct cgroup *cgrp,
 {
 	if (cgrp->root != ancestor->root || cgrp->level < ancestor->level)
 		return false;
-	return cgrp->ancestor_ids[ancestor->level] == ancestor->id;
+	return cgrp->ancestor_ids[ancestor->level] == cgroup_id(ancestor);
 }
 
 /**
@@ -687,17 +692,13 @@ static inline void cgroup_kthread_ready(void)
 	current->no_cgroup_migration = 0;
 }
 
-static inline u64 cgroup_get_kernfs_id(struct cgroup *cgrp)
-{
-	return cgrp->kn->id;
-}
-
 void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
 #else /* !CONFIG_CGROUPS */
 
 struct cgroup_subsys_state;
 struct cgroup;
 
+static inline u64 cgroup_id(struct cgroup *cgrp) { return 1; }
 static inline void css_get(struct cgroup_subsys_state *css) {}
 static inline void css_put(struct cgroup_subsys_state *css) {}
 static inline int cgroup_attach_task_all(struct task_struct *from,
@@ -717,10 +718,6 @@ static inline int cgroup_init_early(void) { return 0; }
 static inline int cgroup_init(void) { return 0; }
 static inline void cgroup_init_kthreadd(void) {}
 static inline void cgroup_kthread_ready(void) {}
-static inline union u64 cgroup_get_kernfs_id(struct cgroup *cgrp)
-{
-	return 0;
-}
 
 static inline struct cgroup *cgroup_parent(struct cgroup *cgrp)
 {
diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index a566cc521476..7f42a3de59e6 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -66,7 +66,7 @@ DECLARE_EVENT_CLASS(cgroup,
 
 	TP_fast_assign(
 		__entry->root = cgrp->root->hierarchy_id;
-		__entry->id = cgrp->id;
+		__entry->id = cgroup_id(cgrp);
 		__entry->level = cgrp->level;
 		__assign_str(path, path);
 	),
@@ -135,7 +135,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
 
 	TP_fast_assign(
 		__entry->dst_root = dst_cgrp->root->hierarchy_id;
-		__entry->dst_id = dst_cgrp->id;
+		__entry->dst_id = cgroup_id(dst_cgrp);
 		__entry->dst_level = dst_cgrp->level;
 		__assign_str(dst_path, path);
 		__entry->pid = task->pid;
@@ -179,7 +179,7 @@ DECLARE_EVENT_CLASS(cgroup_event,
 
 	TP_fast_assign(
 		__entry->root = cgrp->root->hierarchy_id;
-		__entry->id = cgrp->id;
+		__entry->id = cgroup_id(cgrp);
 		__entry->level = cgrp->level;
 		__assign_str(path, path);
 		__entry->val = val;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 912e761cd17a..cada974c9f4e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -317,7 +317,7 @@ BPF_CALL_0(bpf_get_current_cgroup_id)
 {
 	struct cgroup *cgrp = task_dfl_cgroup(current);
 
-	return cgrp->kn->id;
+	return cgroup_id(cgrp);
 }
 
 const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 5d867f6d7204..2ba750725cb2 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -569,7 +569,7 @@ void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
 		return;
 
 	storage->key.attach_type = type;
-	storage->key.cgroup_inode_id = cgroup->kn->id;
+	storage->key.cgroup_inode_id = cgroup_id(cgroup);
 
 	map = storage->map;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b5dcbee5aa6c..c12dcf7dc432 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1308,10 +1308,7 @@ static void cgroup_exit_root_id(struct cgroup_root *root)
 
 void cgroup_free_root(struct cgroup_root *root)
 {
-	if (root) {
-		idr_destroy(&root->cgroup_idr);
-		kfree(root);
-	}
+	kfree(root);
 }
 
 static void cgroup_destroy_root(struct cgroup_root *root)
@@ -1917,7 +1914,6 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
-	idr_init(&root->cgroup_idr);
 
 	root->flags = ctx->flags;
 	if (ctx->release_agent)
@@ -1938,12 +1934,6 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	ret = cgroup_idr_alloc(&root->cgroup_idr, root_cgrp, 1, 2, GFP_KERNEL);
-	if (ret < 0)
-		goto out;
-	root_cgrp->id = ret;
-	root_cgrp->ancestor_ids[0] = ret;
-
 	ret = percpu_ref_init(&root_cgrp->self.refcnt, css_release,
 			      0, GFP_KERNEL);
 	if (ret)
@@ -1976,6 +1966,8 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 		goto exit_root_id;
 	}
 	root_cgrp->kn = root->kf_root->kn;
+	WARN_ON_ONCE(cgroup_id(root_cgrp) != 1);
+	root_cgrp->ancestor_ids[0] = cgroup_id(root_cgrp);
 
 	ret = css_populate_dir(&root_cgrp->self);
 	if (ret)
@@ -3552,22 +3544,22 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 #ifdef CONFIG_PSI
 static int cgroup_io_pressure_show(struct seq_file *seq, void *v)
 {
-	struct cgroup *cgroup = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup->id == 1 ? &psi_system : &cgroup->psi;
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	struct psi_group *psi = cgroup_id(cgrp) == 1 ? &psi_system : &cgrp->psi;
 
 	return psi_show(seq, psi, PSI_IO);
 }
 static int cgroup_memory_pressure_show(struct seq_file *seq, void *v)
 {
-	struct cgroup *cgroup = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup->id == 1 ? &psi_system : &cgroup->psi;
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	struct psi_group *psi = cgroup_id(cgrp) == 1 ? &psi_system : &cgrp->psi;
 
 	return psi_show(seq, psi, PSI_MEM);
 }
 static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
 {
-	struct cgroup *cgroup = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup->id == 1 ? &psi_system : &cgroup->psi;
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	struct psi_group *psi = cgroup_id(cgrp) == 1 ? &psi_system : &cgrp->psi;
 
 	return psi_show(seq, psi, PSI_CPU);
 }
@@ -4987,9 +4979,6 @@ static void css_release_work_fn(struct work_struct *work)
 			tcgrp->nr_dying_descendants--;
 		spin_unlock_irq(&css_set_lock);
 
-		cgroup_idr_remove(&cgrp->root->cgroup_idr, cgrp->id);
-		cgrp->id = -1;
-
 		/*
 		 * There are two control paths which try to determine
 		 * cgroup from dentry without going through kernfs -
@@ -5154,10 +5143,12 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
  * it isn't associated with its kernfs_node and doesn't have the control
  * mask applied.
  */
-static struct cgroup *cgroup_create(struct cgroup *parent)
+static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
+				    umode_t mode)
 {
 	struct cgroup_root *root = parent->root;
 	struct cgroup *cgrp, *tcgrp;
+	struct kernfs_node *kn;
 	int level = parent->level + 1;
 	int ret;
 
@@ -5177,15 +5168,13 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
 			goto out_cancel_ref;
 	}
 
-	/*
-	 * Temporarily set the pointer to NULL, so idr_find() won't return
-	 * a half-baked cgroup.
-	 */
-	cgrp->id = cgroup_idr_alloc(&root->cgroup_idr, NULL, 2, 0, GFP_KERNEL);
-	if (cgrp->id < 0) {
-		ret = -ENOMEM;
+	/* create the directory */
+	kn = kernfs_create_dir(parent->kn, name, mode, cgrp);
+	if (IS_ERR(kn)) {
+		ret = PTR_ERR(kn);
 		goto out_stat_exit;
 	}
+	cgrp->kn = kn;
 
 	init_cgroup_housekeeping(cgrp);
 
@@ -5195,7 +5184,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
 
 	ret = psi_cgroup_alloc(cgrp);
 	if (ret)
-		goto out_idr_free;
+		goto out_kernfs_remove;
 
 	ret = cgroup_bpf_inherit(cgrp);
 	if (ret)
@@ -5219,7 +5208,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
 
 	spin_lock_irq(&css_set_lock);
 	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
-		cgrp->ancestor_ids[tcgrp->level] = tcgrp->id;
+		cgrp->ancestor_ids[tcgrp->level] = cgroup_id(tcgrp);
 
 		if (tcgrp != cgrp) {
 			tcgrp->nr_descendants++;
@@ -5248,12 +5237,6 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
 	atomic_inc(&root->nr_cgrps);
 	cgroup_get_live(parent);
 
-	/*
-	 * @cgrp is now fully operational.  If something fails after this
-	 * point, it'll be released via the normal destruction path.
-	 */
-	cgroup_idr_replace(&root->cgroup_idr, cgrp, cgrp->id);
-
 	/*
 	 * On the default hierarchy, a child doesn't automatically inherit
 	 * subtree_control from the parent.  Each is configured manually.
@@ -5267,8 +5250,8 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
 
 out_psi_free:
 	psi_cgroup_free(cgrp);
-out_idr_free:
-	cgroup_idr_remove(&root->cgroup_idr, cgrp->id);
+out_kernfs_remove:
+	kernfs_remove(cgrp->kn);
 out_stat_exit:
 	if (cgroup_on_dfl(parent))
 		cgroup_rstat_exit(cgrp);
@@ -5305,7 +5288,6 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 {
 	struct cgroup *parent, *cgrp;
-	struct kernfs_node *kn;
 	int ret;
 
 	/* do not accept '\n' to prevent making /proc/<pid>/cgroup unparsable */
@@ -5321,27 +5303,19 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 		goto out_unlock;
 	}
 
-	cgrp = cgroup_create(parent);
+	cgrp = cgroup_create(parent, name, mode);
 	if (IS_ERR(cgrp)) {
 		ret = PTR_ERR(cgrp);
 		goto out_unlock;
 	}
 
-	/* create the directory */
-	kn = kernfs_create_dir(parent->kn, name, mode, cgrp);
-	if (IS_ERR(kn)) {
-		ret = PTR_ERR(kn);
-		goto out_destroy;
-	}
-	cgrp->kn = kn;
-
 	/*
 	 * This extra ref will be put in cgroup_free_fn() and guarantees
 	 * that @cgrp->kn is always accessible.
 	 */
-	kernfs_get(kn);
+	kernfs_get(cgrp->kn);
 
-	ret = cgroup_kn_set_ugid(kn);
+	ret = cgroup_kn_set_ugid(cgrp->kn);
 	if (ret)
 		goto out_destroy;
 
@@ -5356,7 +5330,7 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 	TRACE_CGROUP_PATH(mkdir, cgrp);
 
 	/* let's create and online css's */
-	kernfs_activate(kn);
+	kernfs_activate(cgrp->kn);
 
 	ret = 0;
 	goto out_unlock;
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index a7dac5b63f3f..475e29498bca 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -171,7 +171,7 @@ void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,
 		blkcg = NULL;
 #ifdef CONFIG_BLK_CGROUP
 	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n,
-		blkcg ? cgroup_get_kernfs_id(blkcg->css.cgroup) : 0);
+		   blkcg ? cgroup_id(blkcg->css.cgroup) : 1);
 #else
 	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n, 0);
 #endif
@@ -759,7 +759,7 @@ static u64 blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
 
 	if (!bio->bi_blkg)
 		return 0;
-	return cgroup_get_kernfs_id(bio_blkcg(bio)->css.cgroup);
+	return cgroup_id(bio_blkcg(bio)->css.cgroup);
 }
 #else
 u64 blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
diff --git a/net/core/filter.c b/net/core/filter.c
index b360a7beb6fc..caef7c74cad5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4089,7 +4089,7 @@ BPF_CALL_1(bpf_skb_cgroup_id, const struct sk_buff *, skb)
 		return 0;
 
 	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
-	return cgrp->kn->id;
+	return cgroup_id(cgrp);
 }
 
 static const struct bpf_func_proto bpf_skb_cgroup_id_proto = {
@@ -4114,7 +4114,7 @@ BPF_CALL_2(bpf_skb_ancestor_cgroup_id, const struct sk_buff *, skb, int,
 	if (!ancestor)
 		return 0;
 
-	return ancestor->kn->id;
+	return cgroup_id(ancestor);
 }
 
 static const struct bpf_func_proto bpf_skb_ancestor_cgroup_id_proto = {
-- 
2.17.1

