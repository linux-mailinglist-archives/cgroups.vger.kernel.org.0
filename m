Return-Path: <cgroups+bounces-6419-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A753A25B62
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 14:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AAF166ABC
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 13:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E520207657;
	Mon,  3 Feb 2025 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IpZncNhT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uqgIxwXo"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513122066D1;
	Mon,  3 Feb 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590638; cv=none; b=KpNfnp3wnKONUasfGMfHIE1xcy3OIR4zCMUDIVAHG7tGv0Ei8LIDJmww54snZeOaCTo1RbBrhc5Vbr+xev93fCJMbtU2xuB931ulTo5pQFm3tckCygOXJkBWW62qi6AT7Q2vNOE9Rikerm7a7uYPvNPJbkAllZ9y0B64IKexI3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590638; c=relaxed/simple;
	bh=16ta/n2/ACL9c8/Zn6hy8F9lJM+In4WAlZ2QLg9NcBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tai/hXHO7lsjPbMZtc3jjgASYumCr16F/MdGiG5PCmAEO93XQRX7piYNzpFCettMyt1Li6py4CI/cfL/b1SSQpFR+8yr/3hB1KqsaO3A0SZyvfD9TMoLqanar0BzVQGK+lgMXRp/6iJGVi4Jognd149Fgg8fUg9LIGh2FmTNmVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IpZncNhT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uqgIxwXo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738590632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=St8Cjt+R4cbKqQnu7LqwFJxuqRU3JYVV15JfxyVZyY8=;
	b=IpZncNhTXeKSJH0M4mvqB9ACLw5wach44WpyABl9s6qaKjQckzKMUbTfGuypVInHf9FScK
	Nbb2RHsqv3v5JqCPSd538XhfdD6hXQsGDhP+jv7zCi8qX5zox/WMZxoAM+8i+/SmBGAz2X
	AJhGq1VI++e2c6Xw1X3ukVOj6fgKMYntFsqE6f27WVI5Rqz0Az+FQIeO6x8qZmNuJ58/mt
	flfQyt3gm+4rRgL3SLbqURKpqjbmaMWspMroUGGcvgjA8Upjq6+9tJSFY1suNqOBVWKcPH
	g9nfeLA8zeYeVU2mZqkhOoJ3iKqNmOiZJlttjoF+okA4sRLSaBwxmlNf8KJJ5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738590632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=St8Cjt+R4cbKqQnu7LqwFJxuqRU3JYVV15JfxyVZyY8=;
	b=uqgIxwXov/h4LXyNXK/5s2q/pteswhnvyliJZ0IB2+S0u6XyrYrASRvjeAhNiJUWK/Gsp0
	OKs6M6ELKGr5JzAw==
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
	tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: [PATCH v7 6/6] kernfs: Use RCU to access kernfs_node::name.
Date: Mon,  3 Feb 2025 14:50:23 +0100
Message-ID: <20250203135023.416828-7-bigeasy@linutronix.de>
In-Reply-To: <20250203135023.416828-1-bigeasy@linutronix.de>
References: <20250203135023.416828-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Using RCU lifetime rules to access kernfs_node::name can avoid the
trouble with kernfs_rename_lock in kernfs_name() and kernfs_path_from_node()
if the fs was created with KERNFS_ROOT_INVARIANT_PARENT. This is usefull
as it allows to implement kernfs_path_from_node() only with RCU
protection and avoiding kernfs_rename_lock. The lock is only required if
the __parent node can be changed and the function requires an unchanged
hierarchy while it iterates from the node to its parent.
The change is needed to allow the lookup of the node's path
(kernfs_path_from_node()) from context which runs always with disabled
preemption and or interrutps even on PREEMPT_RT. The problem is that
kernfs_rename_lock becomes a sleeping lock on PREEMPT_RT.

I went through all ::name users and added the required access for the lookup
with a few extensions:
- rdtgroup_pseudo_lock_create() drops all locks and then uses the name
  later on. resctrl supports rename with different parents. Here I made
  a temporal copy of the name while it is used outside of the lock.

- kernfs_rename_ns() accepts NULL as new_parent. This simplifies
  sysfs_move_dir_ns() where it can set NULL in order to reuse the current
  name.

- kernfs_rename_ns() is only using kernfs_rename_lock if the parents are
  different. All users use either kernfs_rwsem (for stable path view) or
  just RCU for the lookup. The ::name uses always RCU free.

Use RCU lifetime guarantees to access kernfs_node::name.

Suggested-by: Tejun Heo <tj@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Reported-by: syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/67251dc6.050a0220.529b6.015e.GAE@googl=
e.com/
Reported-by: Hillf Danton <hdanton@sina.com>
Closes: https://lore.kernel.org/20241102001224.2789-1-hdanton@sina.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/cpu/resctrl/internal.h    |   5 +
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  14 ++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  10 +-
 fs/kernfs/dir.c                           | 113 ++++++++++++----------
 fs/kernfs/file.c                          |   4 +-
 fs/kernfs/kernfs-internal.h               |   5 +
 fs/kernfs/mount.c                         |   5 +-
 fs/kernfs/symlink.c                       |   7 +-
 fs/sysfs/dir.c                            |   2 +-
 include/linux/kernfs.h                    |   4 +-
 security/selinux/hooks.c                  |   7 +-
 11 files changed, 105 insertions(+), 71 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h
index 20c898f09b7e7..dd5d6b4bfcc22 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -507,6 +507,11 @@ int parse_bw(struct rdt_parse_data *data, struct resct=
rl_schema *s,
=20
 extern struct mutex rdtgroup_mutex;
=20
+static inline const char *rdt_kn_name(const struct kernfs_node *kn)
+{
+	return rcu_dereference_check(kn->name, lockdep_is_held(&rdtgroup_mutex));
+}
+
 extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 extern struct dentry *debugfs_resctrl;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cp=
u/resctrl/pseudo_lock.c
index 42cc162f7fc91..7a2db7fa41083 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -52,7 +52,8 @@ static char *pseudo_lock_devnode(const struct device *dev=
, umode_t *mode)
 	rdtgrp =3D dev_get_drvdata(dev);
 	if (mode)
 		*mode =3D 0600;
-	return kasprintf(GFP_KERNEL, "pseudo_lock/%s", rdtgrp->kn->name);
+	guard(mutex)(&rdtgroup_mutex);
+	return kasprintf(GFP_KERNEL, "pseudo_lock/%s", rdt_kn_name(rdtgrp->kn));
 }
=20
 static const struct class pseudo_lock_class =3D {
@@ -1293,6 +1294,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtg=
rp)
 	struct task_struct *thread;
 	unsigned int new_minor;
 	struct device *dev;
+	char *kn_name __free(kfree) =3D NULL;
 	int ret;
=20
 	ret =3D pseudo_lock_region_alloc(plr);
@@ -1304,6 +1306,11 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdt=
grp)
 		ret =3D -EINVAL;
 		goto out_region;
 	}
+	kn_name =3D kstrdup(rdt_kn_name(rdtgrp->kn), GFP_KERNEL);
+	if (!kn_name) {
+		ret =3D -ENOMEM;
+		goto out_cstates;
+	}
=20
 	plr->thread_done =3D 0;
=20
@@ -1348,8 +1355,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtg=
rp)
 	mutex_unlock(&rdtgroup_mutex);
=20
 	if (!IS_ERR_OR_NULL(debugfs_resctrl)) {
-		plr->debugfs_dir =3D debugfs_create_dir(rdtgrp->kn->name,
-						      debugfs_resctrl);
+		plr->debugfs_dir =3D debugfs_create_dir(kn_name, debugfs_resctrl);
 		if (!IS_ERR_OR_NULL(plr->debugfs_dir))
 			debugfs_create_file("pseudo_lock_measure", 0200,
 					    plr->debugfs_dir, rdtgrp,
@@ -1358,7 +1364,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtg=
rp)
=20
 	dev =3D device_create(&pseudo_lock_class, NULL,
 			    MKDEV(pseudo_lock_major, new_minor),
-			    rdtgrp, "%s", rdtgrp->kn->name);
+			    rdtgrp, "%s", kn_name);
=20
 	mutex_lock(&rdtgroup_mutex);
=20
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c
index 55dcdeea1a1b4..10afc4eaa467e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -916,14 +916,14 @@ int proc_resctrl_show(struct seq_file *s, struct pid_=
namespace *ns,
 			continue;
=20
 		seq_printf(s, "res:%s%s\n", (rdtg =3D=3D &rdtgroup_default) ? "/" : "",
-			   rdtg->kn->name);
+			   rdt_kn_name(rdtg->kn));
 		seq_puts(s, "mon:");
 		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
 				    mon.crdtgrp_list) {
 			if (!resctrl_arch_match_rmid(tsk, crg->mon.parent->closid,
 						     crg->mon.rmid))
 				continue;
-			seq_printf(s, "%s", crg->kn->name);
+			seq_printf(s, "%s", rdt_kn_name(crg->kn));
 			break;
 		}
 		seq_putc(s, '\n');
@@ -3675,7 +3675,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node=
 *parent_kn,
  */
 static bool is_mon_groups(struct kernfs_node *kn, const char *name)
 {
-	return (!strcmp(kn->name, "mon_groups") &&
+	return (!strcmp(rdt_kn_name(kn), "mon_groups") &&
 		strcmp(name, "mon_groups"));
 }
=20
@@ -3824,7 +3824,7 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 			ret =3D rdtgroup_rmdir_ctrl(rdtgrp, tmpmask);
 		}
 	} else if (rdtgrp->type =3D=3D RDTMON_GROUP &&
-		 is_mon_groups(parent_kn, kn->name)) {
+		 is_mon_groups(parent_kn, rdt_kn_name(kn))) {
 		ret =3D rdtgroup_rmdir_mon(rdtgrp, tmpmask);
 	} else {
 		ret =3D -EPERM;
@@ -3912,7 +3912,7 @@ static int rdtgroup_rename(struct kernfs_node *kn,
=20
 	kn_parent =3D rdt_kn_parent(kn);
 	if (rdtgrp->type !=3D RDTMON_GROUP || !kn_parent ||
-	    !is_mon_groups(kn_parent, kn->name)) {
+	    !is_mon_groups(kn_parent, rdt_kn_name(kn))) {
 		rdt_last_cmd_puts("Source must be a MON group\n");
 		ret =3D -EPERM;
 		goto out;
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 1d370c497e8a3..c5a578c46759a 100644
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
-	return strscpy(buf, rcu_access_pointer(kn->__parent) ? kn->name : "/", bu=
flen);
-}
-
 /* kernfs_node_depth - compute depth from @from to @to */
 static size_t kernfs_depth(struct kernfs_node *from, struct kernfs_node *t=
o)
 {
@@ -168,11 +160,13 @@ static int kernfs_path_from_node_locked(struct kernfs=
_node *kn_to,
=20
 	/* Calculate how many bytes we need for the rest */
 	for (i =3D depth_to - 1; i >=3D 0; i--) {
+		const char *name;
=20
 		for (kn =3D kn_to, j =3D 0; j < i; j++)
 			kn =3D rcu_dereference(kn->__parent);
=20
-		len +=3D scnprintf(buf + len, buflen - len, "/%s", kn->name);
+		name =3D rcu_dereference(kn->name);
+		len +=3D scnprintf(buf + len, buflen - len, "/%s", name);
 	}
=20
 	return len;
@@ -196,13 +190,18 @@ static int kernfs_path_from_node_locked(struct kernfs=
_node *kn_to,
  */
 int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
 {
-	unsigned long flags;
-	int ret;
+	struct kernfs_node *kn_parent;
=20
-	read_lock_irqsave(&kernfs_rename_lock, flags);
-	ret =3D kernfs_name_locked(kn, buf, buflen);
-	read_unlock_irqrestore(&kernfs_rename_lock, flags);
-	return ret;
+	if (!kn)
+		return strscpy(buf, "(null)", buflen);
+
+	guard(rcu)();
+	/*
+	 * KERNFS_ROOT_INVARIANT_PARENT is ignored here. The name is RCU freed and
+	 * the parent is either existing or not.
+	 */
+	kn_parent =3D rcu_dereference(kn->__parent);
+	return strscpy(buf, kn_parent ? rcu_dereference(kn->name) : "/", buflen);
 }
=20
 /**
@@ -224,14 +223,17 @@ int kernfs_name(struct kernfs_node *kn, char *buf, si=
ze_t buflen)
 int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
 			  char *buf, size_t buflen)
 {
-	unsigned long flags;
-	int ret;
+	struct kernfs_root *root;
=20
 	guard(rcu)();
-	read_lock_irqsave(&kernfs_rename_lock, flags);
-	ret =3D kernfs_path_from_node_locked(to, from, buf, buflen);
-	read_unlock_irqrestore(&kernfs_rename_lock, flags);
-	return ret;
+	if (to) {
+		root =3D kernfs_root(to);
+		if (!(root->flags & KERNFS_ROOT_INVARIANT_PARENT)) {
+			guard(read_lock_irqsave)(&kernfs_rename_lock);
+			return kernfs_path_from_node_locked(to, from, buf, buflen);
+		}
+	}
+	return kernfs_path_from_node_locked(to, from, buf, buflen);
 }
 EXPORT_SYMBOL_GPL(kernfs_path_from_node);
=20
@@ -338,13 +340,13 @@ static int kernfs_name_compare(unsigned int hash, con=
st char *name,
 		return -1;
 	if (ns > kn->ns)
 		return 1;
-	return strcmp(name, kn->name);
+	return strcmp(name, kernfs_rcu_name(kn));
 }
=20
 static int kernfs_sd_compare(const struct kernfs_node *left,
 			     const struct kernfs_node *right)
 {
-	return kernfs_name_compare(left->hash, left->name, left->ns, right);
+	return kernfs_name_compare(left->hash, kernfs_rcu_name(left), left->ns, r=
ight);
 }
=20
 /**
@@ -542,7 +544,8 @@ static void kernfs_free_rcu(struct rcu_head *rcu)
 {
 	struct kernfs_node *kn =3D container_of(rcu, struct kernfs_node, rcu);
=20
-	kfree_const(kn->name);
+	/* If the whole node goes away, then name can't be used outside */
+	kfree_const(rcu_access_pointer(kn->name));
=20
 	if (kn->iattr) {
 		simple_xattrs_free(&kn->iattr->xattrs, NULL);
@@ -575,7 +578,8 @@ void kernfs_put(struct kernfs_node *kn)
=20
 	WARN_ONCE(atomic_read(&kn->active) !=3D KN_DEACTIVATED_BIAS,
 		  "kernfs_put: %s/%s: released with incorrect active_ref %d\n",
-		  parent ? parent->name : "", kn->name, atomic_read(&kn->active));
+		  parent ? rcu_dereference(parent->name) : "",
+		  rcu_dereference(kn->name), atomic_read(&kn->active));
=20
 	if (kernfs_type(kn) =3D=3D KERNFS_LINK)
 		kernfs_put(kn->symlink.target_kn);
@@ -652,7 +656,7 @@ static struct kernfs_node *__kernfs_new_node(struct ker=
nfs_root *root,
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
 	RB_CLEAR_NODE(&kn->rb);
=20
-	kn->name =3D name;
+	rcu_assign_pointer(kn->name, name);
 	kn->mode =3D mode;
 	kn->flags =3D flags;
=20
@@ -790,7 +794,8 @@ int kernfs_add_one(struct kernfs_node *kn)
 	ret =3D -EINVAL;
 	has_ns =3D kernfs_ns_enabled(parent);
 	if (WARN(has_ns !=3D (bool)kn->ns, KERN_WARNING "kernfs: ns %s in '%s' fo=
r '%s'\n",
-		 has_ns ? "required" : "invalid", parent->name, kn->name))
+		 has_ns ? "required" : "invalid",
+		 kernfs_rcu_name(parent), kernfs_rcu_name(kn)))
 		goto out_unlock;
=20
 	if (kernfs_type(parent) !=3D KERNFS_DIR)
@@ -800,7 +805,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	if (parent->flags & (KERNFS_REMOVING | KERNFS_EMPTY_DIR))
 		goto out_unlock;
=20
-	kn->hash =3D kernfs_name_hash(kn->name, kn->ns);
+	kn->hash =3D kernfs_name_hash(kernfs_rcu_name(kn), kn->ns);
=20
 	ret =3D kernfs_link_sibling(kn);
 	if (ret)
@@ -856,7 +861,7 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs=
_node *parent,
=20
 	if (has_ns !=3D (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
-		     has_ns ? "required" : "invalid", parent->name, name);
+		     has_ns ? "required" : "invalid", kernfs_rcu_name(parent), name);
 		return NULL;
 	}
=20
@@ -1135,8 +1140,6 @@ static int kernfs_dop_revalidate(struct inode *dir, c=
onst struct qstr *name,
=20
 	/* Negative hashed dentry? */
 	if (d_really_is_negative(dentry)) {
-		struct kernfs_node *parent;
-
 		/* If the kernfs parent node has changed discard and
 		 * proceed to ->lookup.
 		 *
@@ -1184,7 +1187,7 @@ static int kernfs_dop_revalidate(struct inode *dir, c=
onst struct qstr *name,
 		goto out_bad;
=20
 	/* The kernfs node has been renamed */
-	if (strcmp(dentry->d_name.name, kn->name) !=3D 0)
+	if (strcmp(dentry->d_name.name, kernfs_rcu_name(kn)) !=3D 0)
 		goto out_bad;
=20
 	/* The kernfs node has been moved to a different namespace */
@@ -1478,7 +1481,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 	if (kernfs_parent(kn) && RB_EMPTY_NODE(&kn->rb))
 		return;
=20
-	pr_debug("kernfs %s: removing\n", kn->name);
+	pr_debug("kernfs %s: removing\n", kernfs_rcu_name(kn));
=20
 	/* prevent new usage by marking all nodes removing and deactivating */
 	pos =3D NULL;
@@ -1734,7 +1737,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct k=
ernfs_node *new_parent,
 {
 	struct kernfs_node *old_parent;
 	struct kernfs_root *root;
-	const char *old_name =3D NULL;
+	const char *old_name;
 	int error;
=20
 	/* can't move or rename root */
@@ -1757,8 +1760,11 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct =
kernfs_node *new_parent,
 	}
=20
 	error =3D 0;
+	old_name =3D kernfs_rcu_name(kn);
+	if (!new_name)
+		new_name =3D old_name;
 	if ((old_parent =3D=3D new_parent) && (kn->ns =3D=3D new_ns) &&
-	    (strcmp(kn->name, new_name) =3D=3D 0))
+	    (strcmp(old_name, new_name) =3D=3D 0))
 		goto out;	/* nothing to rename */
=20
 	error =3D -EEXIST;
@@ -1766,7 +1772,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct k=
ernfs_node *new_parent,
 		goto out;
=20
 	/* rename kernfs_node */
-	if (strcmp(kn->name, new_name) !=3D 0) {
+	if (strcmp(old_name, new_name) !=3D 0) {
 		error =3D -ENOMEM;
 		new_name =3D kstrdup_const(new_name, GFP_KERNEL);
 		if (!new_name)
@@ -1779,27 +1785,32 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct=
 kernfs_node *new_parent,
 	 * Move to the appropriate place in the appropriate directories rbtree.
 	 */
 	kernfs_unlink_sibling(kn);
-	kernfs_get(new_parent);
=20
-	/* rename_lock protects ->parent and ->name accessors */
-	write_lock_irq(&kernfs_rename_lock);
+	/* rename_lock protects ->parent accessors */
+	if (old_parent !=3D new_parent) {
+		kernfs_get(new_parent);
+		write_lock_irq(&kernfs_rename_lock);
=20
-	old_parent =3D kernfs_parent(kn);
-	rcu_assign_pointer(kn->__parent, new_parent);
+		rcu_assign_pointer(kn->__parent, new_parent);
=20
-	kn->ns =3D new_ns;
-	if (new_name) {
-		old_name =3D kn->name;
-		kn->name =3D new_name;
+		kn->ns =3D new_ns;
+		if (new_name)
+			rcu_assign_pointer(kn->name, new_name);
+
+		write_unlock_irq(&kernfs_rename_lock);
+		kernfs_put(old_parent);
+	} else {
+		/* name assignment is RCU protected, parent is the same */
+		kn->ns =3D new_ns;
+		if (new_name)
+			rcu_assign_pointer(kn->name, new_name);
 	}
=20
-	write_unlock_irq(&kernfs_rename_lock);
-
-	kn->hash =3D kernfs_name_hash(kn->name, kn->ns);
+	kn->hash =3D kernfs_name_hash(new_name ?: old_name, kn->ns);
 	kernfs_link_sibling(kn);
=20
-	kernfs_put(old_parent);
-	kfree_const(old_name);
+	if (new_name && !is_kernel_rodata((unsigned long)old_name))
+		kfree_rcu_mightsleep(old_name);
=20
 	error =3D 0;
  out:
@@ -1884,7 +1895,7 @@ static int kernfs_fop_readdir(struct file *file, stru=
ct dir_context *ctx)
 	for (pos =3D kernfs_dir_pos(ns, parent, ctx->pos, pos);
 	     pos;
 	     pos =3D kernfs_dir_next_pos(ns, parent, ctx->pos, pos)) {
-		const char *name =3D pos->name;
+		const char *name =3D kernfs_rcu_name(pos);
 		unsigned int type =3D fs_umode_to_dtype(pos->mode);
 		int len =3D strlen(name);
 		ino_t ino =3D kernfs_ino(pos);
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index c4ffa8dc89ebc..66fe8fe41f060 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -915,6 +915,7 @@ static void kernfs_notify_workfn(struct work_struct *wo=
rk)
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
 		struct inode *p_inode =3D NULL;
+		const char *kn_name;
 		struct inode *inode;
 		struct qstr name;
=20
@@ -928,7 +929,8 @@ static void kernfs_notify_workfn(struct work_struct *wo=
rk)
 		if (!inode)
 			continue;
=20
-		name =3D QSTR(kn->name);
+		kn_name =3D kernfs_rcu_name(kn);
+		name =3D QSTR(kn_name);
 		parent =3D kernfs_get_parent(kn);
 		if (parent) {
 			p_inode =3D ilookup(info->sb, kernfs_ino(parent));
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index c43bee18b79f7..40a2a9cd819d0 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -107,6 +107,11 @@ static inline bool kernfs_root_is_locked(const struct =
kernfs_node *kn)
 	return lockdep_is_held(&kernfs_root(kn)->kernfs_rwsem);
 }
=20
+static inline const char *kernfs_rcu_name(const struct kernfs_node *kn)
+{
+	return rcu_dereference_check(kn->name, kernfs_root_is_locked(kn));
+}
+
 static inline struct kernfs_node *kernfs_parent(const struct kernfs_node *=
kn)
 {
 	/*
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 2252b16e6ef0b..d1f512b7bf867 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -231,6 +231,7 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *k=
n,
 	do {
 		struct dentry *dtmp;
 		struct kernfs_node *kntmp;
+		const char *name;
=20
 		if (kn =3D=3D knparent)
 			return dentry;
@@ -239,8 +240,8 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *k=
n,
 			dput(dentry);
 			return ERR_PTR(-EINVAL);
 		}
-		dtmp =3D lookup_positive_unlocked(kntmp->name, dentry,
-					       strlen(kntmp->name));
+		name =3D rcu_dereference(kntmp->name);
+		dtmp =3D lookup_positive_unlocked(name, dentry, strlen(name));
 		dput(dentry);
 		if (IS_ERR(dtmp))
 			return dtmp;
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 05c62ca93c53d..0bd8a2143723d 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -81,7 +81,7 @@ static int kernfs_get_target_path(struct kernfs_node *par=
ent,
 	/* determine end of target string for reverse fillup */
 	kn =3D target;
 	while (kernfs_parent(kn) && kn !=3D base) {
-		len +=3D strlen(kn->name) + 1;
+		len +=3D strlen(kernfs_rcu_name(kn)) + 1;
 		kn =3D kernfs_parent(kn);
 	}
=20
@@ -95,10 +95,11 @@ static int kernfs_get_target_path(struct kernfs_node *p=
arent,
 	/* reverse fillup of target string from target to base */
 	kn =3D target;
 	while (kernfs_parent(kn) && kn !=3D base) {
-		int slen =3D strlen(kn->name);
+		const char *name =3D kernfs_rcu_name(kn);
+		int slen =3D strlen(name);
=20
 		len -=3D slen;
-		memcpy(s + len, kn->name, slen);
+		memcpy(s + len, name, slen);
 		if (len)
 			s[--len] =3D '/';
=20
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 4df2afa551dc6..94e12efd92f21 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -123,7 +123,7 @@ int sysfs_move_dir_ns(struct kobject *kobj, struct kobj=
ect *new_parent_kobj,
 	new_parent =3D new_parent_kobj && new_parent_kobj->sd ?
 		new_parent_kobj->sd : sysfs_root_kn;
=20
-	return kernfs_rename_ns(kn, new_parent, kn->name, new_ns);
+	return kernfs_rename_ns(kn, new_parent, NULL, new_ns);
 }
=20
 /**
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 5dda9a268e44c..b5a5f32fdfd1a 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -204,8 +204,8 @@ struct kernfs_node {
 	 * never moved to a different parent, it is safe to access the
 	 * parent directly.
 	 */
-	const char		*name;
 	struct kernfs_node	__rcu *__parent;
+	const char		__rcu *name;
=20
 	struct rb_node		rb;
=20
@@ -400,7 +400,7 @@ static inline bool kernfs_ns_enabled(struct kernfs_node=
 *kn)
 }
=20
 int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen);
-int kernfs_path_from_node(struct kernfs_node *root_kn, struct kernfs_node =
*kn,
+int kernfs_path_from_node(struct kernfs_node *kn_to, struct kernfs_node *k=
n_from,
 			  char *buf, size_t buflen);
 void pr_cont_kernfs_name(struct kernfs_node *kn);
 void pr_cont_kernfs_path(struct kernfs_node *kn);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88ba..7dee9616147d2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3584,10 +3584,13 @@ static int selinux_kernfs_init_security(struct kern=
fs_node *kn_dir,
 		newsid =3D tsec->create_sid;
 	} else {
 		u16 secclass =3D inode_mode_to_security_class(kn->mode);
+		const char *kn_name;
 		struct qstr q;
=20
-		q.name =3D kn->name;
-		q.hash_len =3D hashlen_string(kn_dir, kn->name);
+		/* kn is fresh, can't be renamed, name goes not away */
+		kn_name =3D rcu_dereference_check(kn->name, true);
+		q.name =3D kn_name;
+		q.hash_len =3D hashlen_string(kn_dir, kn_name);
=20
 		rc =3D security_transition_sid(tsec->sid,
 					     parent_sid, secclass, &q,
--=20
2.47.2


