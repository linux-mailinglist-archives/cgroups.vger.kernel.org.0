Return-Path: <cgroups+bounces-5517-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1EC9C6185
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2024 20:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95322BA2F71
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2024 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0193920651E;
	Tue, 12 Nov 2024 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zDEaIm7Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DgUbS9rn"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FF202F7D;
	Tue, 12 Nov 2024 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427042; cv=none; b=f/wZ05qxHjdgbxTOrRl7iliV2h0tbFG2AL1WTPpu1hA0KUwNDB+J4ulL2tUlbNqk820WZ6hc4Wksb8aIELHqXYItpK28pf3NQLewlQ/ZTpfmBjIO2ZUiQZBtDyXEbVf5rP8RGVTFFNUKqHyRHZDUBekgI/YPnzDz36AE03rOQ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427042; c=relaxed/simple;
	bh=is8pT83fllftAi/8QRmcBtd7SYgg0sbRwqr4hI1szIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPzOfdaAnufebmtHqilg7TOWZwHjET14q13F7vaS6UFCoJFGUzQ+mYtZKSUmetzvqYt9vrwIp4vqSuXxqKISsJIF3G1suotEq8YbphISQHOKS9C3oyHv/mn1FzmWZayV1n20zV8XZw0E2wzcJp2GGvqBn2Kut3ij6yeypfkHdkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zDEaIm7Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DgUbS9rn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731427038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8kklPfS1ZS4RUUP7ZeRJquVqkA8mXRTVNA08dtDI4k=;
	b=zDEaIm7QaHcKxe7v51QDdsJoo9snuOXIc4KsC7H/BG0DYEJAFcW74lO53i2dt1LEO3wZYO
	KZ7/zSmygeBZ4dsf+3joOiLKrrA+5rJ5sTV3EGfrjws+lKTsQvSD6WNQwd+Yj3M1uTr58x
	Jlk2hiMBkcB08EqJ7taRX75mNjQroXEzJL49GgKTPJ/HJttBcNKVMaeMMFgKqWw/itFY+N
	zh7WuMQLCm2FzfNQlLqM3/BthtBJ1/sb9TUEQbdkK8sL4OuPWoe3WnF6MTK4VEFrD39M2e
	NrkrCu2T+mOtX1sW9fyidezHfArz03kVNbHq9avxVeFe5rqyaHoBSdvvxlZEqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731427038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8kklPfS1ZS4RUUP7ZeRJquVqkA8mXRTVNA08dtDI4k=;
	b=DgUbS9rnYDtWxpj7LRH5VzuHHjMSSjFa6TL20k0I1GaCplpoj0ONZHMtTlGJyhl1Bzn7xe
	qzsgcjqweKHz7ODQ==
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: [PATCH v2 2/2] cgroup, kernfs: Move cgroup to the RCU interface for name lookups
Date: Tue, 12 Nov 2024 16:52:39 +0100
Message-ID: <20241112155713.269214-3-bigeasy@linutronix.de>
In-Reply-To: <20241112155713.269214-1-bigeasy@linutronix.de>
References: <20241112155713.269214-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

cgroup only renames nodes and keeps the same parent node. It can be
switched RCU for name lookups to avoid acquiring a lock.
For the switch the flag KERNFS_ROOT_SAME_PARENT is added while creating
the root node and lookups are switched to the _rcu() interface.

The pr_cont_kernfs_.*() is only used by cgroup and is renamed as part of
the switch.
kernfs_path() has one user in tree, sysfs.
kernfs_name() has no callers, could be removed.
kernfs_path_from_node() has no in-tree module callers, module export is
removed.

Fixes: 2b5067a8143e3 ("mm: mmap_lock: add tracepoints around lock acquisiti=
on")
Reported-by: syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/67251dc6.050a0220.529b6.015e.GAE@googl=
e.com/
Reported-by: Hillf Danton <hdanton@sina.com>
Closes: https://lore.kernel.org/20241102001224.2789-1-hdanton@sina.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/kernfs/dir.c        | 21 +++++++++++----------
 include/linux/cgroup.h |  8 ++++----
 include/linux/kernfs.h | 26 ++++++++++++++++++++++----
 kernel/cgroup/cgroup.c |  9 +++++----
 4 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 41c87ee76aa70..93bdaad8b9886 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -264,7 +264,6 @@ int kernfs_path_from_node(struct kernfs_node *to, struc=
t kernfs_node *from,
 	}
 	return kernfs_path_from_node_locked(to, from, buf, buflen);
 }
-EXPORT_SYMBOL_GPL(kernfs_path_from_node);
=20
 /**
  * kernfs_path_from_node_rcu - build path of node @to relative to @from.
@@ -291,38 +290,40 @@ int kernfs_path_from_node_rcu(struct kernfs_node *to,=
 struct kernfs_node *from,
 }
=20
 /**
- * pr_cont_kernfs_name - pr_cont name of a kernfs_node
+ * pr_cont_kernfs_name_rcu - pr_cont name of a kernfs_node
  * @kn: kernfs_node of interest
  *
- * This function can be called from any context.
+ * This function can be called from any context. The root node must be with
+ * KERNFS_ROOT_SAME_PARENT.
  */
-void pr_cont_kernfs_name(struct kernfs_node *kn)
+void pr_cont_kernfs_name_rcu(struct kernfs_node *kn)
 {
 	unsigned long flags;
=20
 	spin_lock_irqsave(&kernfs_pr_cont_lock, flags);
=20
-	kernfs_name(kn, kernfs_pr_cont_buf, sizeof(kernfs_pr_cont_buf));
+	kernfs_name_rcu(kn, kernfs_pr_cont_buf, sizeof(kernfs_pr_cont_buf));
 	pr_cont("%s", kernfs_pr_cont_buf);
=20
 	spin_unlock_irqrestore(&kernfs_pr_cont_lock, flags);
 }
=20
 /**
- * pr_cont_kernfs_path - pr_cont path of a kernfs_node
+ * pr_cont_kernfs_path_rcu - pr_cont path of a kernfs_node
  * @kn: kernfs_node of interest
  *
- * This function can be called from any context.
+ * This function can be called from any context. The root node must be with
+ * KERNFS_ROOT_SAME_PARENT.
  */
-void pr_cont_kernfs_path(struct kernfs_node *kn)
+void pr_cont_kernfs_path_rcu(struct kernfs_node *kn)
 {
 	unsigned long flags;
 	int sz;
=20
 	spin_lock_irqsave(&kernfs_pr_cont_lock, flags);
=20
-	sz =3D kernfs_path_from_node(kn, NULL, kernfs_pr_cont_buf,
-				   sizeof(kernfs_pr_cont_buf));
+	sz =3D kernfs_path_from_node_rcu(kn, NULL, kernfs_pr_cont_buf,
+				       sizeof(kernfs_pr_cont_buf));
 	if (sz < 0) {
 		if (sz =3D=3D -E2BIG)
 			pr_cont("(name too long)");
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f8ef47f8a634d..555a299e583ef 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -591,22 +591,22 @@ static inline struct cgroup_subsys_state *seq_css(str=
uct seq_file *seq)
=20
 static inline int cgroup_name(struct cgroup *cgrp, char *buf, size_t bufle=
n)
 {
-	return kernfs_name(cgrp->kn, buf, buflen);
+	return kernfs_name_rcu(cgrp->kn, buf, buflen);
 }
=20
 static inline int cgroup_path(struct cgroup *cgrp, char *buf, size_t bufle=
n)
 {
-	return kernfs_path(cgrp->kn, buf, buflen);
+	return kernfs_path_rcu(cgrp->kn, buf, buflen);
 }
=20
 static inline void pr_cont_cgroup_name(struct cgroup *cgrp)
 {
-	pr_cont_kernfs_name(cgrp->kn);
+	pr_cont_kernfs_name_rcu(cgrp->kn);
 }
=20
 static inline void pr_cont_cgroup_path(struct cgroup *cgrp)
 {
-	pr_cont_kernfs_path(cgrp->kn);
+	pr_cont_kernfs_path_rcu(cgrp->kn);
 }
=20
 bool cgroup_psi_enabled(void);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index b52393f1045c6..a1907f3c944d0 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -408,8 +408,8 @@ int kernfs_path_from_node(struct kernfs_node *kn_to, st=
ruct kernfs_node *kn_from
 			  char *buf, size_t buflen);
 int kernfs_path_from_node_rcu(struct kernfs_node *kn_to, struct kernfs_nod=
e *kn_from,
 			      char *buf, size_t buflen);
-void pr_cont_kernfs_name(struct kernfs_node *kn);
-void pr_cont_kernfs_path(struct kernfs_node *kn);
+void pr_cont_kernfs_name_rcu(struct kernfs_node *kn);
+void pr_cont_kernfs_path_rcu(struct kernfs_node *kn);
 struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn);
 struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 					   const char *name, const void *ns);
@@ -499,8 +499,8 @@ static inline int kernfs_path_from_node_rcu(struct kern=
fs_node *root_kn,
 					    char *buf, size_t buflen)
 { return -ENOSYS; }
=20
-static inline void pr_cont_kernfs_name(struct kernfs_node *kn) { }
-static inline void pr_cont_kernfs_path(struct kernfs_node *kn) { }
+static inline void pr_cont_kernfs_name_rcu(struct kernfs_node *kn) { }
+static inline void pr_cont_kernfs_path_rcu(struct kernfs_node *kn) { }
=20
 static inline struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn)
 { return NULL; }
@@ -617,6 +617,24 @@ static inline int kernfs_path(struct kernfs_node *kn, =
char *buf, size_t buflen)
 	return kernfs_path_from_node(kn, NULL, buf, buflen);
 }
=20
+/**
+ * kernfs_path_rcu - build full path of a given node
+ * @kn: kernfs_node of interest
+ * @buf: buffer to copy @kn's name into
+ * @buflen: size of @buf
+ *
+ * If @kn is NULL result will be "(null)". The root node must be with
+ * KERNFS_ROOT_SAME_PARENT.
+ *
+ * Returns the length of the full path.  If the full length is equal to or
+ * greater than @buflen, @buf contains the truncated path with the trailing
+ * '\0'.  On error, -errno is returned.
+ */
+static inline int kernfs_path_rcu(struct kernfs_node *kn, char *buf, size_=
t buflen)
+{
+	return kernfs_path_from_node_rcu(kn, NULL, buf, buflen);
+}
+
 static inline struct kernfs_node *
 kernfs_find_and_get(struct kernfs_node *kn, const char *name)
 {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 044c7ba1cc482..6f8d555529525 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1906,7 +1906,7 @@ int cgroup_show_path(struct seq_file *sf, struct kern=
fs_node *kf_node,
=20
 	spin_lock_irq(&css_set_lock);
 	ns_cgroup =3D current_cgns_cgroup_from_root(kf_cgroot);
-	len =3D kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
+	len =3D kernfs_path_from_node_rcu(kf_node, ns_cgroup->kn, buf, PATH_MAX);
 	spin_unlock_irq(&css_set_lock);
=20
 	if (len =3D=3D -E2BIG)
@@ -2118,7 +2118,8 @@ int cgroup_setup_root(struct cgroup_root *root, u16 s=
s_mask)
 	root->kf_root =3D kernfs_create_root(kf_sops,
 					   KERNFS_ROOT_CREATE_DEACTIVATED |
 					   KERNFS_ROOT_SUPPORT_EXPORTOP |
-					   KERNFS_ROOT_SUPPORT_USER_XATTR,
+					   KERNFS_ROOT_SUPPORT_USER_XATTR |
+					   KERNFS_ROOT_SAME_PARENT,
 					   root_cgrp);
 	if (IS_ERR(root->kf_root)) {
 		ret =3D PTR_ERR(root->kf_root);
@@ -2387,7 +2388,7 @@ int cgroup_path_ns_locked(struct cgroup *cgrp, char *=
buf, size_t buflen,
 {
 	struct cgroup *root =3D cset_cgroup_from_root(ns->root_cset, cgrp->root);
=20
-	return kernfs_path_from_node(cgrp->kn, root->kn, buf, buflen);
+	return kernfs_path_from_node_rcu(cgrp->kn, root->kn, buf, buflen);
 }
=20
 int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
@@ -6275,7 +6276,7 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, si=
ze_t buflen)
 	kn =3D kernfs_find_and_get_node_by_id(cgrp_dfl_root.kf_root, id);
 	if (!kn)
 		return;
-	kernfs_path(kn, buf, buflen);
+	kernfs_path_rcu(kn, buf, buflen);
 	kernfs_put(kn);
 }
=20
--=20
2.45.2


