Return-Path: <cgroups+bounces-5516-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C57A9C5C9C
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2024 17:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35031F23A03
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2024 16:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3BC2064F1;
	Tue, 12 Nov 2024 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dSe0P4Y4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WQIM3Pqs"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F724206073;
	Tue, 12 Nov 2024 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427042; cv=none; b=uPWaRaamPtnpA273a/gY6ntvchiyp8LGJBBFCqv3hmqMna9aboYfWRCD2OAR2kP/jL4HidUdyTUNZVJR7FPsiZYiEQt4DTJTx1mOYa0GPZa1q9t8f3QZyNYxxoagJCaZ8zB6KVzoXbvVzDFvWypu2yMyif2pw9CeOQPNB9cqTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427042; c=relaxed/simple;
	bh=jWikD1hxByruciVic/Uzph1jw19Hyrc0HF+i5caP3ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGFEdjvdtNruCfK0JNa68apdmaBarBBExjBx93zks2ORtBvsm0NLaEKGp4mNjH5eodzkNzhgJ/ks14ILTEPxfiBUjfXSS/j12wR00cyyx6vSM2zGbO3s5edKuyR8Hx6vyC9JrtLHd6t+GlcdSElBZS0L1TyDrCyLMIQnTzndLWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dSe0P4Y4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WQIM3Pqs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731427037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QzIwAuXoumzQ5FPiiY1R/gDEePHvKPqi/0TCM7N+9o=;
	b=dSe0P4Y46u0bjWLsraOrwSE2ZYrLvfnnse698jH5r3KnEMnI51K/0r2F1HOtfqwAqGp7Ro
	l+DGX1AGKTdIUxjYeOafj3sR+IKr3ycVvZpfEhgvdKrrpULlcVGVTs2JYwiNwx3f7vwMSk
	CAoMWdCbO6jaPdxZnOPhvQr8PKG+e/aBkLXi7X1b3sSSk2XPrAsus7iiAUD74UdZasPpxq
	fKGyHJjOPgc743qddRVE+BwbCX+wLBVVo9M3/Rt0LkaCFfcbLJ+s863qeZwOPQmt9yqmx4
	ajvuxvJG4cBch8tqL18yH/sZyDTu9v2ke1v2IDtfalccHba6FlPKvhsNmKAi5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731427037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QzIwAuXoumzQ5FPiiY1R/gDEePHvKPqi/0TCM7N+9o=;
	b=WQIM3PqsxTVia5Rpc0XpwRPQZM7mo90kKZrJqtLxmxLLEmaw77lyEcJ9Q71FhhpYXhQB0p
	VFB+8FcX+CtHqXDQ==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 1/2] kernfs: Make it possible to use RCU for kernfs_node::name lookup.
Date: Tue, 12 Nov 2024 16:52:38 +0100
Message-ID: <20241112155713.269214-2-bigeasy@linutronix.de>
In-Reply-To: <20241112155713.269214-1-bigeasy@linutronix.de>
References: <20241112155713.269214-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of using kernfs_rename_lock for lookups of ::name allow to use
RCU protection for lookup. Rely on kn's kernfs_root::kernfs_rwsem for
update synchronisation.

KERNFS_ROOT_SAME_PARENT is added to signal that the parent never
changes. kernfs_rename_ns() checks that flag and if it is seen, it
ensures that the parent is the same and then does not acquire
kernfs_rename_lock during parent/ name assignment and updates only the
name attribute. Without the flag, the update is performed as always.

kernfs_name_rcu() is a copy of kernfs_name() which is using RCU
protection while accessing the kernfs_node::name. Both functions
validate the KERNFS_ROOT_SAME_PARENT flag. The same is true for
kernfs_path_from_node() and kernfs_path_from_node_rcu().

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/kernfs/dir.c        | 151 ++++++++++++++++++++++++++++++-----------
 include/linux/kernfs.h |  23 ++++++-
 2 files changed, 133 insertions(+), 41 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 458519e416fe7..41c87ee76aa70 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -51,14 +51,6 @@ static bool kernfs_lockdep(struct kernfs_node *kn)
 #endif
 }
=20
-static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t bu=
flen)
-{
-	if (!kn)
-		return strscpy(buf, "(null)", buflen);
-
-	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
-}
-
 /* kernfs_node_depth - compute depth from @from to @to */
 static size_t kernfs_depth(struct kernfs_node *from, struct kernfs_node *t=
o)
 {
@@ -168,10 +160,13 @@ static int kernfs_path_from_node_locked(struct kernfs=
_node *kn_to,
=20
 	/* Calculate how many bytes we need for the rest */
 	for (i =3D depth_to - 1; i >=3D 0; i--) {
+		const char *name;
+
 		for (kn =3D kn_to, j =3D 0; j < i; j++)
 			kn =3D kn->parent;
=20
-		len +=3D scnprintf(buf + len, buflen - len, "/%s", kn->name);
+		name =3D rcu_dereference_check(kn->name_rcu, lockdep_is_held(&kernfs_ren=
ame_lock));
+		len +=3D scnprintf(buf + len, buflen - len, "/%s", name);
 	}
=20
 	return len;
@@ -184,7 +179,8 @@ static int kernfs_path_from_node_locked(struct kernfs_n=
ode *kn_to,
  * @buflen: size of @buf
  *
  * Copies the name of @kn into @buf of @buflen bytes.  The behavior is
- * similar to strscpy().
+ * similar to strscpy(). The root node must not be initialized with
+ * KERNFS_ROOT_SAME_PARENT.
  *
  * Fills buffer with "(null)" if @kn is %NULL.
  *
@@ -195,13 +191,47 @@ static int kernfs_path_from_node_locked(struct kernfs=
_node *kn_to,
  */
 int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
 {
-	unsigned long flags;
-	int ret;
+	struct kernfs_root *root;
=20
-	read_lock_irqsave(&kernfs_rename_lock, flags);
-	ret =3D kernfs_name_locked(kn, buf, buflen);
-	read_unlock_irqrestore(&kernfs_rename_lock, flags);
-	return ret;
+	guard(read_lock_irqsave)(&kernfs_rename_lock);
+	if (kn) {
+		root =3D kernfs_root(kn);
+		if (WARN_ON_ONCE(root->flags & KERNFS_ROOT_SAME_PARENT))
+			kn =3D NULL;
+	}
+
+	if (!kn)
+		return strscpy(buf, "(null)", buflen);
+
+	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
+}
+
+/**
+ * kernfs_name_rcu - obtain the name of a given node
+ * @kn: kernfs_node of interest
+ * @buf: buffer to copy @kn's name into
+ * @buflen: size of @buf
+ *
+ * Same as kernfs_name except it uses RCU for name lookup. The root node m=
ust
+ * be with KERNFS_ROOT_SAME_PARENT.
+ *
+ * This function can be called from any context.
+ */
+
+int kernfs_name_rcu(struct kernfs_node *kn, char *buf, size_t buflen)
+{
+	struct kernfs_root *root;
+
+	if (kn) {
+		root =3D kernfs_root(kn);
+		if (WARN_ON_ONCE(!(root->flags & KERNFS_ROOT_SAME_PARENT)))
+			kn =3D NULL;
+	}
+	if (!kn)
+		return strscpy(buf, "(null)", buflen);
+
+	guard(rcu)();
+	return strscpy(buf, kn->parent ? rcu_dereference(kn->name_rcu) : "/", buf=
len);
 }
=20
 /**
@@ -214,7 +244,8 @@ int kernfs_name(struct kernfs_node *kn, char *buf, size=
_t buflen)
  * Builds @to's path relative to @from in @buf. @from and @to must
  * be on the same kernfs-root. If @from is not parent of @to, then a relat=
ive
  * path (which includes '..'s) as needed to reach from @from to @to is
- * returned.
+ * returned. The root node must not be initialized with
+ * KERNFS_ROOT_SAME_PARENT.
  *
  * Return: the length of the constructed path.  If the path would have been
  * greater than @buflen, @buf contains the truncated path with the trailing
@@ -223,16 +254,42 @@ int kernfs_name(struct kernfs_node *kn, char *buf, si=
ze_t buflen)
 int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
 			  char *buf, size_t buflen)
 {
-	unsigned long flags;
-	int ret;
+	struct kernfs_root *root;
=20
-	read_lock_irqsave(&kernfs_rename_lock, flags);
-	ret =3D kernfs_path_from_node_locked(to, from, buf, buflen);
-	read_unlock_irqrestore(&kernfs_rename_lock, flags);
-	return ret;
+	guard(read_lock_irqsave)(&kernfs_rename_lock);
+	if (to) {
+		root =3D kernfs_root(to);
+		if (WARN_ON_ONCE(root->flags & KERNFS_ROOT_SAME_PARENT))
+			to =3D NULL;
+	}
+	return kernfs_path_from_node_locked(to, from, buf, buflen);
 }
 EXPORT_SYMBOL_GPL(kernfs_path_from_node);
=20
+/**
+ * kernfs_path_from_node_rcu - build path of node @to relative to @from.
+ * @from: parent kernfs_node relative to which we need to build the path
+ * @to: kernfs_node of interest
+ * @buf: buffer to copy @to's path into
+ * @buflen: size of @buf
+ *
+ * Same as kernfs_path_from_node. Uses RCU for the name lookup. The root n=
ode
+ * must be initialized with KERNFS_ROOT_SAME_PARENT.
+ */
+int kernfs_path_from_node_rcu(struct kernfs_node *to, struct kernfs_node *=
from,
+			      char *buf, size_t buflen)
+{
+	struct kernfs_root *root;
+
+	if (to) {
+		root =3D kernfs_root(to);
+		if (WARN_ON_ONCE(!(root->flags & KERNFS_ROOT_SAME_PARENT)))
+			to =3D NULL;
+	}
+	guard(rcu)();
+	return kernfs_path_from_node_locked(to, from, buf, buflen);
+}
+
 /**
  * pr_cont_kernfs_name - pr_cont name of a kernfs_node
  * @kn: kernfs_node of interest
@@ -1717,7 +1774,8 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct k=
ernfs_node *new_parent,
 {
 	struct kernfs_node *old_parent;
 	struct kernfs_root *root;
-	const char *old_name =3D NULL;
+	bool rcu_name =3D false;
+	const char *kn_name;
 	int error;
=20
 	/* can't move or rename root */
@@ -1732,9 +1790,18 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct =
kernfs_node *new_parent,
 	    (new_parent->flags & KERNFS_EMPTY_DIR))
 		goto out;
=20
+	if (root->flags & KERNFS_ROOT_SAME_PARENT) {
+		error =3D -EINVAL;
+		if (WARN_ON_ONCE(kn->parent !=3D new_parent))
+			goto out;
+		rcu_name =3D true;
+	}
+
 	error =3D 0;
+	kn_name =3D rcu_dereference_check(kn->name_rcu,
+					lockdep_is_held(&root->kernfs_rwsem));
 	if ((kn->parent =3D=3D new_parent) && (kn->ns =3D=3D new_ns) &&
-	    (strcmp(kn->name, new_name) =3D=3D 0))
+	    (strcmp(kn_name, new_name) =3D=3D 0))
 		goto out;	/* nothing to rename */
=20
 	error =3D -EEXIST;
@@ -1742,7 +1809,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct k=
ernfs_node *new_parent,
 		goto out;
=20
 	/* rename kernfs_node */
-	if (strcmp(kn->name, new_name) !=3D 0) {
+	if (strcmp(kn_name, new_name) !=3D 0) {
 		error =3D -ENOMEM;
 		new_name =3D kstrdup_const(new_name, GFP_KERNEL);
 		if (!new_name)
@@ -1755,27 +1822,33 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct=
 kernfs_node *new_parent,
 	 * Move to the appropriate place in the appropriate directories rbtree.
 	 */
 	kernfs_unlink_sibling(kn);
-	kernfs_get(new_parent);
=20
 	/* rename_lock protects ->parent and ->name accessors */
-	write_lock_irq(&kernfs_rename_lock);
+	if (!rcu_name) {
+		write_lock_irq(&kernfs_rename_lock);
=20
-	old_parent =3D kn->parent;
-	kn->parent =3D new_parent;
+		kernfs_get(new_parent);
+		old_parent =3D kn->parent;
+		kn->parent =3D new_parent;
=20
-	kn->ns =3D new_ns;
-	if (new_name) {
-		old_name =3D kn->name;
-		kn->name =3D new_name;
+		kn->ns =3D new_ns;
+		if (new_name)
+			kn->name =3D new_name;
+
+		write_unlock_irq(&kernfs_rename_lock);
+		kernfs_put(old_parent);
+	} else {
+		/* name assignment is RCU protected, parent is the same */
+		kn->ns =3D new_ns;
+		if (new_name)
+			rcu_assign_pointer(kn->name_rcu, new_name);
 	}
=20
-	write_unlock_irq(&kernfs_rename_lock);
-
-	kn->hash =3D kernfs_name_hash(kn->name, kn->ns);
+	kn->hash =3D kernfs_name_hash(new_name ?: kn_name, kn->ns);
 	kernfs_link_sibling(kn);
=20
-	kernfs_put(old_parent);
-	kfree_const(old_name);
+	if (new_name && !is_kernel_rodata((unsigned long)kn_name))
+		kfree_rcu_mightsleep(kn_name);
=20
 	error =3D 0;
  out:
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 87c79d076d6d7..b52393f1045c6 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -147,6 +147,11 @@ enum kernfs_root_flag {
 	 * Support user xattrs to be written to nodes rooted at this root.
 	 */
 	KERNFS_ROOT_SUPPORT_USER_XATTR		=3D 0x0008,
+
+	/*
+	 * Renames must not change the parent node.
+	 */
+	KERNFS_ROOT_SAME_PARENT			=3D 0x0010,
 };
=20
 /* type-specific structures for kernfs_node union members */
@@ -200,7 +205,10 @@ struct kernfs_node {
 	 * parent directly.
 	 */
 	struct kernfs_node	*parent;
-	const char		*name;
+	union {
+		const char		__rcu *name_rcu;
+		const char		*name;
+	};
=20
 	struct rb_node		rb;
=20
@@ -395,8 +403,11 @@ static inline bool kernfs_ns_enabled(struct kernfs_nod=
e *kn)
 }
=20
 int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen);
-int kernfs_path_from_node(struct kernfs_node *root_kn, struct kernfs_node =
*kn,
+int kernfs_name_rcu(struct kernfs_node *kn, char *buf, size_t buflen);
+int kernfs_path_from_node(struct kernfs_node *kn_to, struct kernfs_node *k=
n_from,
 			  char *buf, size_t buflen);
+int kernfs_path_from_node_rcu(struct kernfs_node *kn_to, struct kernfs_nod=
e *kn_from,
+			      char *buf, size_t buflen);
 void pr_cont_kernfs_name(struct kernfs_node *kn);
 void pr_cont_kernfs_path(struct kernfs_node *kn);
 struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn);
@@ -475,11 +486,19 @@ static inline bool kernfs_ns_enabled(struct kernfs_no=
de *kn)
 static inline int kernfs_name(struct kernfs_node *kn, char *buf, size_t bu=
flen)
 { return -ENOSYS; }
=20
+static inline int kernfs_name_rcu(struct kernfs_node *kn, char *buf, size_=
t buflen)
+{ return -ENOSYS; }
+
 static inline int kernfs_path_from_node(struct kernfs_node *root_kn,
 					struct kernfs_node *kn,
 					char *buf, size_t buflen)
 { return -ENOSYS; }
=20
+static inline int kernfs_path_from_node_rcu(struct kernfs_node *root_kn,
+					    struct kernfs_node *kn,
+					    char *buf, size_t buflen)
+{ return -ENOSYS; }
+
 static inline void pr_cont_kernfs_name(struct kernfs_node *kn) { }
 static inline void pr_cont_kernfs_path(struct kernfs_node *kn) { }
=20
--=20
2.45.2


