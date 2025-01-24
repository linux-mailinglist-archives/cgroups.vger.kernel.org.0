Return-Path: <cgroups+bounces-6280-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5247A1BBAE
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 18:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A227A5A54
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2F921C19A;
	Fri, 24 Jan 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cHdk7aZC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NYiEuO3y"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD75021B905;
	Fri, 24 Jan 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740787; cv=none; b=kF4EtPSyUTCbLszop9tykPq2aGsgm0Kfbes4/LVRGC8FOKh6tsbGvMDffPBVFRwyPk6xwaBk9OfeSnZxhwS+akqv5EtY8uBJPGhJ8UzcJfv6ikC3ZcmI9rSV4QurR8Vz3I84BLFdQV8XXftB24J/PXeA4J+31cUukNYPrm4jMss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740787; c=relaxed/simple;
	bh=N+eJYXcDSRYWGgE4LpN8HqQ7eD76hz+6U8QJbttznU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cADXdl4hjt23Qy4iJFFMrtQekUzq2mp8Qm2mWj3uuU1SIS/+Li4LU+YGQBX29fym1HE4ZUaYiqZWXGB4N9O8G3F/v5qElHUZpMPQ7aZrByJM0H4JNmgw0Op7aWHH86GLtaZ7Ug8OmvOg3fpuGfHfvPGheyc0XIcxpQ9LYLWPi20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cHdk7aZC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NYiEuO3y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737740781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OWEC59J0oyfuIoT5iBObE6dWRdUE3eLFH8H0jxThZ4=;
	b=cHdk7aZCeiawMHB2xVujvM/Re5f8uNrh+Oe5wmMNS/m4wwRm+zC2ixUz8Vf4HmC0vzcPNB
	/UxovaVyPH3n6sPEQVuhdfYHJaQ0CsTVcVdCTlkeoOTfwB77u9NyS8l5cTmzj0JtH6L2GR
	qvLEa64LOPJhXzqrKUEiOZeFk2rZdwHDUjzgwrA5cuELo+B4rQ/8/CxAe5J8uKXbOOgoUn
	13AZlKWn9+KB83OR5vpVVQMZ734XepH/MANFzpWaeXZcMinPu/307OzgMoY7KLhLP2FQcf
	sPVaStYBxERZkkoHYK5bXM8/wtudCxNH5ftkCPxbJPADggbwPJ7mbRAkTkruUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737740781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OWEC59J0oyfuIoT5iBObE6dWRdUE3eLFH8H0jxThZ4=;
	b=NYiEuO3yUEFftTWPHSW/GErm7DcpM+LY9H9ba2WomRve/2VUxqKCdzA0xbz7JZiD+4qb2A
	eXw3x+jwF75tEWDQ==
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
Subject: [PATCH v4 5/6] kernfs: Use RCU to access kernfs_node::parent.
Date: Fri, 24 Jan 2025 18:46:13 +0100
Message-ID: <20250124174614.866884-6-bigeasy@linutronix.de>
In-Reply-To: <20250124174614.866884-1-bigeasy@linutronix.de>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kernfs_rename_lock is used to obtain stable kernfs_node::{name|parent}
pointer. This is a preparation to access kernfs_node::parent under RCU
and ensure that the pointer remains stable under the RCU lifetime
guarantees.

For a complete path, as it is done in kernfs_path_from_node(), the
kernfs_rename_lock is still required in order to obtain a stable parent
relationship while computing the relevant node depth. This must not
change while the nodes are inspected in order to build the path.
If the kernfs user never moves the nodes (changes the parent) then the
kernfs_rename_lock is not required and the RCU guarantees are
sufficient. This "restriction" can be set with
KERNFS_ROOT_INVARIANT_PARENT. Otherwise the lock is required.

Rename kernfs_node::parent to kernfs_node::__parent to denote the RCU
access and use RCU accessor while accessing the node.
Make cgroup use KERNFS_ROOT_INVARIANT_PARENT since the parent here can
not change.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 52 ++++++++-------
 fs/kernfs/dir.c                        | 87 +++++++++++++++-----------
 fs/kernfs/kernfs-internal.h            | 19 +++++-
 fs/kernfs/mount.c                      | 10 +--
 fs/kernfs/symlink.c                    | 23 +++----
 fs/sysfs/file.c                        | 24 ++++---
 include/linux/kernfs.h                 |  7 ++-
 kernel/cgroup/cgroup-v1.c              |  2 +-
 kernel/cgroup/cgroup.c                 | 16 +++--
 9 files changed, 149 insertions(+), 91 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c
index d906a1cd84917..3d5d03f22c10d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -947,10 +947,16 @@ static int rdt_last_cmd_status_show(struct kernfs_ope=
n_file *of,
 	return 0;
 }
=20
+static void *rdt_get_kn_parent_priv(struct kernfs_node *kn)
+{
+	guard(rcu)();
+	return rcu_dereference(kn->__parent)->priv;
+}
+
 static int rdt_num_closids_show(struct kernfs_open_file *of,
 				struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s =3D of->kn->parent->priv;
+	struct resctrl_schema *s =3D rdt_get_kn_parent_priv(of->kn);
=20
 	seq_printf(seq, "%u\n", s->num_closid);
 	return 0;
@@ -959,7 +965,7 @@ static int rdt_num_closids_show(struct kernfs_open_file=
 *of,
 static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s =3D of->kn->parent->priv;
+	struct resctrl_schema *s =3D rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r =3D s->res;
=20
 	seq_printf(seq, "%x\n", r->default_ctrl);
@@ -969,7 +975,7 @@ static int rdt_default_ctrl_show(struct kernfs_open_fil=
e *of,
 static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s =3D of->kn->parent->priv;
+	struct resctrl_schema *s =3D rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r =3D s->res;
=20
 	seq_printf(seq, "%u\n", r->cache.min_cbm_bits);
@@ -979,7 +985,7 @@ static int rdt_min_cbm_bits_show(struct kernfs_open_fil=
e *of,
 static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 				   struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s =3D of->kn->parent->priv;
+	struct resctrl_schema *s =3D rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r =3D s->res;
=20
 	seq_printf(seq, "%x\n", r->cache.shareable_bits);
@@ -1003,7 +1009,7 @@ static int rdt_shareable_bits_show(struct kernfs_open=
_file *of,
 static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			      struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s =3D of->kn->parent->priv;
+	struct resctrl_schema *s =3D rdt_get_kn_parent_priv(of->kn);
 	/*
 	 * Use unsigned long even though only 32 bits are used to ensure
 	 * test_bit() is used safely.
@@ -1085,7 +1091,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file=
 *of,
 static int rdt_min_bw_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s =3D of->kn->parent->priv;
+	struct resctrl_schema *s =3D rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r =3D s->res;
=20
 	seq_printf(seq, "%u\n", r->membw.min_bw);
@@ -1095,7 +1101,7 @@ static int rdt_min_bw_show(struct kernfs_open_file *o=
f,
 static int rdt_num_rmids_show(struct kernfs_open_file *of,
 			      struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r =3D of->kn->parent->priv;
+	struct rdt_resource *r =3D rdt_get_kn_parent_priv(of->kn);
=20
 	seq_printf(seq, "%d\n", r->num_rmid);
=20
@@ -1105,7 +1111,7 @@ static int rdt_num_rmids_show(struct kernfs_open_file=
 *of,
 static int rdt_mon_features_show(struct kernfs_open_file *of,
 				 struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r =3D of->kn->parent->priv;
+	struct rdt_resource *r =3D rdt_get_kn_parent_priv(of->kn);
 	struct mon_evt *mevt;
=20
 	list_for_each_entry(mevt, &r->evt_list, list) {
@@ -1120,7 +1126,7 @@ static int rdt_mon_features_show(struct kernfs_open_f=
ile *of,
 static int rdt_bw_gran_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s =3D of->kn->parent->priv;
+	struct resctrl_schema *s =3D rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r =3D s->res;
=20
 	seq_printf(seq, "%u\n", r->membw.bw_gran);
@@ -1130,7 +1136,7 @@ static int rdt_bw_gran_show(struct kernfs_open_file *=
of,
 static int rdt_delay_linear_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s =3D of->kn->parent->priv;
+	struct resctrl_schema *s =3D rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r =3D s->res;
=20
 	seq_printf(seq, "%u\n", r->membw.delay_linear);
@@ -1148,7 +1154,7 @@ static int max_threshold_occ_show(struct kernfs_open_=
file *of,
 static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
 					 struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s =3D of->kn->parent->priv;
+	struct resctrl_schema *s =3D rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r =3D s->res;
=20
 	if (r->membw.throttle_mode =3D=3D THREAD_THROTTLE_PER_THREAD)
@@ -1213,7 +1219,7 @@ static enum resctrl_conf_type resctrl_peer_type(enum =
resctrl_conf_type my_type)
 static int rdt_has_sparse_bitmasks_show(struct kernfs_open_file *of,
 					struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s =3D of->kn->parent->priv;
+	struct resctrl_schema *s =3D rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r =3D s->res;
=20
 	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmasks);
@@ -1625,7 +1631,7 @@ static int mbm_config_show(struct seq_file *s, struct=
 rdt_resource *r, u32 evtid
 static int mbm_total_bytes_config_show(struct kernfs_open_file *of,
 				       struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r =3D of->kn->parent->priv;
+	struct rdt_resource *r =3D rdt_get_kn_parent_priv(of->kn);
=20
 	mbm_config_show(seq, r, QOS_L3_MBM_TOTAL_EVENT_ID);
=20
@@ -1635,7 +1641,7 @@ static int mbm_total_bytes_config_show(struct kernfs_=
open_file *of,
 static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
 				       struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r =3D of->kn->parent->priv;
+	struct rdt_resource *r =3D rdt_get_kn_parent_priv(of->kn);
=20
 	mbm_config_show(seq, r, QOS_L3_MBM_LOCAL_EVENT_ID);
=20
@@ -1741,7 +1747,7 @@ static ssize_t mbm_total_bytes_config_write(struct ke=
rnfs_open_file *of,
 					    char *buf, size_t nbytes,
 					    loff_t off)
 {
-	struct rdt_resource *r =3D of->kn->parent->priv;
+	struct rdt_resource *r =3D rdt_get_kn_parent_priv(of->kn);
 	int ret;
=20
 	/* Valid input requires a trailing newline */
@@ -1767,7 +1773,7 @@ static ssize_t mbm_local_bytes_config_write(struct ke=
rnfs_open_file *of,
 					    char *buf, size_t nbytes,
 					    loff_t off)
 {
-	struct rdt_resource *r =3D of->kn->parent->priv;
+	struct rdt_resource *r =3D rdt_get_kn_parent_priv(of->kn);
 	int ret;
=20
 	/* Valid input requires a trailing newline */
@@ -2429,12 +2435,13 @@ static struct rdtgroup *kernfs_to_rdtgroup(struct k=
ernfs_node *kn)
 		 * resource. "info" and its subdirectories don't
 		 * have rdtgroup structures, so return NULL here.
 		 */
-		if (kn =3D=3D kn_info || kn->parent =3D=3D kn_info)
+		if (kn =3D=3D kn_info ||
+		    rcu_dereference_check(kn->__parent, true) =3D=3D kn_info)
 			return NULL;
 		else
 			return kn->priv;
 	} else {
-		return kn->parent->priv;
+		return rdt_get_kn_parent_priv(kn);
 	}
 }
=20
@@ -3760,7 +3767,7 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgr=
p, cpumask_var_t tmpmask)
=20
 static int rdtgroup_rmdir(struct kernfs_node *kn)
 {
-	struct kernfs_node *parent_kn =3D kn->parent;
+	struct kernfs_node *parent_kn;
 	struct rdtgroup *rdtgrp;
 	cpumask_var_t tmpmask;
 	int ret =3D 0;
@@ -3773,6 +3780,7 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 		ret =3D -EPERM;
 		goto out;
 	}
+	parent_kn =3D rcu_dereference_check(kn->__parent, lockdep_is_held(&rdtgro=
up_mutex));
=20
 	/*
 	 * If the rdtgroup is a ctrl_mon group and parent directory
@@ -3841,6 +3849,7 @@ static void mongrp_reparent(struct rdtgroup *rdtgrp,
 static int rdtgroup_rename(struct kernfs_node *kn,
 			   struct kernfs_node *new_parent, const char *new_name)
 {
+	struct kernfs_node *kn_parent;
 	struct rdtgroup *new_prdtgrp;
 	struct rdtgroup *rdtgrp;
 	cpumask_var_t tmpmask;
@@ -3875,8 +3884,9 @@ static int rdtgroup_rename(struct kernfs_node *kn,
 		goto out;
 	}
=20
-	if (rdtgrp->type !=3D RDTMON_GROUP || !kn->parent ||
-	    !is_mon_groups(kn->parent, kn->name)) {
+	kn_parent =3D rcu_dereference_check(kn->__parent, lockdep_is_held(&rdtgro=
up_mutex));
+	if (rdtgrp->type !=3D RDTMON_GROUP || !kn_parent ||
+	    !is_mon_groups(kn_parent, kn->name)) {
 		rdt_last_cmd_puts("Source must be a MON group\n");
 		ret =3D -EPERM;
 		goto out;
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5a1fea414996e..8e92928c6bca6 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -56,7 +56,7 @@ static int kernfs_name_locked(struct kernfs_node *kn, cha=
r *buf, size_t buflen)
 	if (!kn)
 		return strscpy(buf, "(null)", buflen);
=20
-	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
+	return strscpy(buf, rcu_access_pointer(kn->__parent) ? kn->name : "/", bu=
flen);
 }
=20
 /* kernfs_node_depth - compute depth from @from to @to */
@@ -64,9 +64,9 @@ static size_t kernfs_depth(struct kernfs_node *from, stru=
ct kernfs_node *to)
 {
 	size_t depth =3D 0;
=20
-	while (to->parent && to !=3D from) {
+	while (rcu_dereference(to->__parent) && to !=3D from) {
 		depth++;
-		to =3D to->parent;
+		to =3D rcu_dereference(to->__parent);
 	}
 	return depth;
 }
@@ -84,18 +84,18 @@ static struct kernfs_node *kernfs_common_ancestor(struc=
t kernfs_node *a,
 	db =3D kernfs_depth(rb->kn, b);
=20
 	while (da > db) {
-		a =3D a->parent;
+		a =3D rcu_dereference(a->__parent);
 		da--;
 	}
 	while (db > da) {
-		b =3D b->parent;
+		b =3D rcu_dereference(b->__parent);
 		db--;
 	}
=20
 	/* worst case b and a will be the same at root */
 	while (b !=3D a) {
-		b =3D b->parent;
-		a =3D a->parent;
+		b =3D rcu_dereference(b->__parent);
+		a =3D rcu_dereference(a->__parent);
 	}
=20
 	return a;
@@ -168,8 +168,9 @@ static int kernfs_path_from_node_locked(struct kernfs_n=
ode *kn_to,
=20
 	/* Calculate how many bytes we need for the rest */
 	for (i =3D depth_to - 1; i >=3D 0; i--) {
+
 		for (kn =3D kn_to, j =3D 0; j < i; j++)
-			kn =3D kn->parent;
+			kn =3D rcu_dereference(kn->__parent);
=20
 		len +=3D scnprintf(buf + len, buflen - len, "/%s", kn->name);
 	}
@@ -295,7 +296,7 @@ struct kernfs_node *kernfs_get_parent(struct kernfs_nod=
e *kn)
 	unsigned long flags;
=20
 	read_lock_irqsave(&kernfs_rename_lock, flags);
-	parent =3D kn->parent;
+	parent =3D rcu_dereference_check(kn->__parent, lockdep_is_held(&kernfs_re=
name_lock));
 	kernfs_get(parent);
 	read_unlock_irqrestore(&kernfs_rename_lock, flags);
=20
@@ -360,8 +361,12 @@ static int kernfs_sd_compare(const struct kernfs_node =
*left,
  */
 static int kernfs_link_sibling(struct kernfs_node *kn)
 {
-	struct rb_node **node =3D &kn->parent->dir.children.rb_node;
 	struct rb_node *parent =3D NULL;
+	struct kernfs_node *kn_parent;
+	struct rb_node **node;
+
+	kn_parent =3D kernfs_parent(kn);
+	node =3D &kn_parent->dir.children.rb_node;
=20
 	while (*node) {
 		struct kernfs_node *pos;
@@ -380,13 +385,13 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
=20
 	/* add new node and rebalance the tree */
 	rb_link_node(&kn->rb, parent, node);
-	rb_insert_color(&kn->rb, &kn->parent->dir.children);
+	rb_insert_color(&kn->rb, &kn_parent->dir.children);
=20
 	/* successfully added, account subdir number */
 	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 	if (kernfs_type(kn) =3D=3D KERNFS_DIR)
-		kn->parent->dir.subdirs++;
-	kernfs_inc_rev(kn->parent);
+		kn_parent->dir.subdirs++;
+	kernfs_inc_rev(kn_parent);
 	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
=20
 	return 0;
@@ -407,16 +412,19 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
  */
 static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 {
+	struct kernfs_node *kn_parent;
+
 	if (RB_EMPTY_NODE(&kn->rb))
 		return false;
=20
+	kn_parent =3D kernfs_parent(kn);
 	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 	if (kernfs_type(kn) =3D=3D KERNFS_DIR)
-		kn->parent->dir.subdirs--;
-	kernfs_inc_rev(kn->parent);
+		kn_parent->dir.subdirs--;
+	kernfs_inc_rev(kn_parent);
 	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
=20
-	rb_erase(&kn->rb, &kn->parent->dir.children);
+	rb_erase(&kn->rb, &kn_parent->dir.children);
 	RB_CLEAR_NODE(&kn->rb);
 	return true;
 }
@@ -562,7 +570,7 @@ void kernfs_put(struct kernfs_node *kn)
 	 * Moving/renaming is always done while holding reference.
 	 * kn->parent won't change beneath us.
 	 */
-	parent =3D kn->parent;
+	parent =3D rcu_dereference_check(kn->__parent, !atomic_read(&kn->count));
=20
 	WARN_ONCE(atomic_read(&kn->active) !=3D KN_DEACTIVATED_BIAS,
 		  "kernfs_put: %s/%s: released with incorrect active_ref %d\n",
@@ -701,7 +709,7 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node =
*parent,
 			       name, mode, uid, gid, flags);
 	if (kn) {
 		kernfs_get(parent);
-		kn->parent =3D parent;
+		rcu_assign_pointer(kn->__parent, parent);
 	}
 	return kn;
 }
@@ -769,13 +777,14 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(st=
ruct kernfs_root *root,
  */
 int kernfs_add_one(struct kernfs_node *kn)
 {
-	struct kernfs_node *parent =3D kn->parent;
-	struct kernfs_root *root =3D kernfs_root(parent);
+	struct kernfs_root *root =3D kernfs_root(kn);
 	struct kernfs_iattrs *ps_iattr;
+	struct kernfs_node *parent;
 	bool has_ns;
 	int ret;
=20
 	down_write(&root->kernfs_rwsem);
+	parent =3D kernfs_parent(kn);
=20
 	ret =3D -EINVAL;
 	has_ns =3D kernfs_ns_enabled(parent);
@@ -1111,7 +1120,7 @@ struct kernfs_node *kernfs_create_empty_dir(struct ke=
rnfs_node *parent,
=20
 static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 {
-	struct kernfs_node *kn;
+	struct kernfs_node *kn, *parent;
 	struct kernfs_root *root;
=20
 	if (flags & LOOKUP_RCU)
@@ -1162,8 +1171,9 @@ static int kernfs_dop_revalidate(struct dentry *dentr=
y, unsigned int flags)
 	if (!kernfs_active(kn))
 		goto out_bad;
=20
+	parent =3D kernfs_parent(kn);
 	/* The kernfs node has been moved? */
-	if (kernfs_dentry_node(dentry->d_parent) !=3D kn->parent)
+	if (kernfs_dentry_node(dentry->d_parent) !=3D parent)
 		goto out_bad;
=20
 	/* The kernfs node has been renamed */
@@ -1171,7 +1181,7 @@ static int kernfs_dop_revalidate(struct dentry *dentr=
y, unsigned int flags)
 		goto out_bad;
=20
 	/* The kernfs node has been moved to a different namespace */
-	if (kn->parent && kernfs_ns_enabled(kn->parent) &&
+	if (parent && kernfs_ns_enabled(parent) &&
 	    kernfs_info(dentry->d_sb)->ns !=3D kn->ns)
 		goto out_bad;
=20
@@ -1364,7 +1374,7 @@ static struct kernfs_node *kernfs_next_descendant_pos=
t(struct kernfs_node *pos,
 		return kernfs_leftmost_descendant(rb_to_kn(rbn));
=20
 	/* no sibling left, visit parent */
-	return pos->parent;
+	return kernfs_parent(pos);
 }
=20
 static void kernfs_activate_one(struct kernfs_node *kn)
@@ -1376,7 +1386,7 @@ static void kernfs_activate_one(struct kernfs_node *k=
n)
 	if (kernfs_active(kn) || (kn->flags & (KERNFS_HIDDEN | KERNFS_REMOVING)))
 		return;
=20
-	WARN_ON_ONCE(kn->parent && RB_EMPTY_NODE(&kn->rb));
+	WARN_ON_ONCE(kernfs_parent(kn) && RB_EMPTY_NODE(&kn->rb));
 	WARN_ON_ONCE(atomic_read(&kn->active) !=3D KN_DEACTIVATED_BIAS);
=20
 	atomic_sub(KN_DEACTIVATED_BIAS, &kn->active);
@@ -1446,7 +1456,7 @@ void kernfs_show(struct kernfs_node *kn, bool show)
=20
 static void __kernfs_remove(struct kernfs_node *kn)
 {
-	struct kernfs_node *pos;
+	struct kernfs_node *pos, *parent;
=20
 	/* Short-circuit if non-root @kn has already finished removal. */
 	if (!kn)
@@ -1458,7 +1468,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 	 * This is for kernfs_remove_self() which plays with active ref
 	 * after removal.
 	 */
-	if (kn->parent && RB_EMPTY_NODE(&kn->rb))
+	if (kernfs_parent(kn) && RB_EMPTY_NODE(&kn->rb))
 		return;
=20
 	pr_debug("kernfs %s: removing\n", kn->name);
@@ -1484,14 +1494,14 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		kernfs_get(pos);
=20
 		kernfs_drain(pos);
-
+		parent =3D kernfs_parent(pos);
 		/*
 		 * kernfs_unlink_sibling() succeeds once per node.  Use it
 		 * to decide who's responsible for cleanups.
 		 */
-		if (!pos->parent || kernfs_unlink_sibling(pos)) {
+		if (!parent || kernfs_unlink_sibling(pos)) {
 			struct kernfs_iattrs *ps_iattr =3D
-				pos->parent ? pos->parent->iattr : NULL;
+				parent ? parent->iattr : NULL;
=20
 			/* update timestamps on the parent */
 			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
@@ -1721,7 +1731,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct k=
ernfs_node *new_parent,
 	int error;
=20
 	/* can't move or rename root */
-	if (!kn->parent)
+	if (!rcu_access_pointer(kn->__parent))
 		return -EINVAL;
=20
 	root =3D kernfs_root(kn);
@@ -1732,8 +1742,15 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct =
kernfs_node *new_parent,
 	    (new_parent->flags & KERNFS_EMPTY_DIR))
 		goto out;
=20
+	old_parent =3D kernfs_parent(kn);
+	if (root->flags & KERNFS_ROOT_INVARIANT_PARENT) {
+		error =3D -EINVAL;
+		if (WARN_ON_ONCE(old_parent !=3D new_parent))
+			goto out;
+	}
+
 	error =3D 0;
-	if ((kn->parent =3D=3D new_parent) && (kn->ns =3D=3D new_ns) &&
+	if ((old_parent =3D=3D new_parent) && (kn->ns =3D=3D new_ns) &&
 	    (strcmp(kn->name, new_name) =3D=3D 0))
 		goto out;	/* nothing to rename */
=20
@@ -1760,8 +1777,8 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct k=
ernfs_node *new_parent,
 	/* rename_lock protects ->parent and ->name accessors */
 	write_lock_irq(&kernfs_rename_lock);
=20
-	old_parent =3D kn->parent;
-	kn->parent =3D new_parent;
+	old_parent =3D rcu_dereference_check(kn->__parent, kernfs_root_is_locked(=
kn));
+	rcu_assign_pointer(kn->__parent, new_parent);
=20
 	kn->ns =3D new_ns;
 	if (new_name) {
@@ -1794,7 +1811,7 @@ static struct kernfs_node *kernfs_dir_pos(const void =
*ns,
 {
 	if (pos) {
 		int valid =3D kernfs_active(pos) &&
-			pos->parent =3D=3D parent && hash =3D=3D pos->hash;
+			kernfs_parent(pos) =3D=3D parent && hash =3D=3D pos->hash;
 		kernfs_put(pos);
 		if (!valid)
 			pos =3D NULL;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index b42ee6547cdc1..da3a933b9cac0 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -64,11 +64,14 @@ struct kernfs_root {
  *
  * Return: the kernfs_root @kn belongs to.
  */
-static inline struct kernfs_root *kernfs_root(struct kernfs_node *kn)
+static inline struct kernfs_root *kernfs_root(const struct kernfs_node *kn)
 {
+	const struct kernfs_node *knp;
 	/* if parent exists, it's always a dir; otherwise, @sd is a dir */
-	if (kn->parent)
-		kn =3D kn->parent;
+	guard(rcu)();
+	knp =3D rcu_dereference(kn->__parent);
+	if (knp)
+		kn =3D knp;
 	return kn->dir.root;
 }
=20
@@ -97,6 +100,16 @@ struct kernfs_super_info {
 };
 #define kernfs_info(SB) ((struct kernfs_super_info *)(SB->s_fs_info))
=20
+static inline bool kernfs_root_is_locked(const struct kernfs_node *kn)
+{
+	return lockdep_is_held(&kernfs_root(kn)->kernfs_rwsem);
+}
+
+static inline struct kernfs_node *kernfs_parent(const struct kernfs_node *=
kn)
+{
+	return rcu_dereference_check(kn->__parent, kernfs_root_is_locked(kn));
+}
+
 static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
 {
 	if (d_really_is_negative(dentry))
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 4a0ff08d589ca..2252b16e6ef0b 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -148,7 +148,7 @@ static struct dentry *kernfs_get_parent_dentry(struct d=
entry *child)
 	struct kernfs_root *root =3D kernfs_root(kn);
=20
 	guard(rwsem_read)(&root->kernfs_rwsem);
-	return d_obtain_alias(kernfs_get_inode(child->d_sb, kn->parent));
+	return d_obtain_alias(kernfs_get_inode(child->d_sb, kernfs_parent(kn)));
 }
=20
 static const struct export_operations kernfs_export_ops =3D {
@@ -188,10 +188,10 @@ static struct kernfs_node *find_next_ancestor(struct =
kernfs_node *child,
 		return NULL;
 	}
=20
-	while (child->parent !=3D parent) {
-		if (!child->parent)
+	while (kernfs_parent(child) !=3D parent) {
+		child =3D kernfs_parent(child);
+		if (!child)
 			return NULL;
-		child =3D child->parent;
 	}
=20
 	return child;
@@ -216,7 +216,7 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *k=
n,
 	dentry =3D dget(sb->s_root);
=20
 	/* Check if this is the root kernfs_node */
-	if (!kn->parent)
+	if (!rcu_access_pointer(kn->__parent))
 		return dentry;
=20
 	root =3D kernfs_root(kn);
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 45371a70caa71..05c62ca93c53d 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -62,10 +62,10 @@ static int kernfs_get_target_path(struct kernfs_node *p=
arent,
=20
 	/* go up to the root, stop at the base */
 	base =3D parent;
-	while (base->parent) {
-		kn =3D target->parent;
-		while (kn->parent && base !=3D kn)
-			kn =3D kn->parent;
+	while (kernfs_parent(base)) {
+		kn =3D kernfs_parent(target);
+		while (kernfs_parent(kn) && base !=3D kn)
+			kn =3D kernfs_parent(kn);
=20
 		if (base =3D=3D kn)
 			break;
@@ -75,14 +75,14 @@ static int kernfs_get_target_path(struct kernfs_node *p=
arent,
=20
 		strcpy(s, "../");
 		s +=3D 3;
-		base =3D base->parent;
+		base =3D kernfs_parent(base);
 	}
=20
 	/* determine end of target string for reverse fillup */
 	kn =3D target;
-	while (kn->parent && kn !=3D base) {
+	while (kernfs_parent(kn) && kn !=3D base) {
 		len +=3D strlen(kn->name) + 1;
-		kn =3D kn->parent;
+		kn =3D kernfs_parent(kn);
 	}
=20
 	/* check limits */
@@ -94,7 +94,7 @@ static int kernfs_get_target_path(struct kernfs_node *par=
ent,
=20
 	/* reverse fillup of target string from target to base */
 	kn =3D target;
-	while (kn->parent && kn !=3D base) {
+	while (kernfs_parent(kn) && kn !=3D base) {
 		int slen =3D strlen(kn->name);
=20
 		len -=3D slen;
@@ -102,7 +102,7 @@ static int kernfs_get_target_path(struct kernfs_node *p=
arent,
 		if (len)
 			s[--len] =3D '/';
=20
-		kn =3D kn->parent;
+		kn =3D kernfs_parent(kn);
 	}
=20
 	return 0;
@@ -111,12 +111,13 @@ static int kernfs_get_target_path(struct kernfs_node =
*parent,
 static int kernfs_getlink(struct inode *inode, char *path)
 {
 	struct kernfs_node *kn =3D inode->i_private;
-	struct kernfs_node *parent =3D kn->parent;
+	struct kernfs_node *parent;
 	struct kernfs_node *target =3D kn->symlink.target_kn;
-	struct kernfs_root *root =3D kernfs_root(parent);
+	struct kernfs_root *root =3D kernfs_root(kn);
 	int error;
=20
 	down_read(&root->kernfs_rwsem);
+	parent =3D kernfs_parent(kn);
 	error =3D kernfs_get_target_path(parent, target, path);
 	up_read(&root->kernfs_rwsem);
=20
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 785408861c01c..1d16b4a386aa9 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -19,13 +19,19 @@
=20
 #include "sysfs.h"
=20
+static struct kobject *sysfs_file_kobj(struct kernfs_node *kn)
+{
+	guard(rcu)();
+	return rcu_dereference(kn->__parent)->priv;
+}
+
 /*
  * Determine ktype->sysfs_ops for the given kernfs_node.  This function
  * must be called while holding an active reference.
  */
 static const struct sysfs_ops *sysfs_file_ops(struct kernfs_node *kn)
 {
-	struct kobject *kobj =3D kn->parent->priv;
+	struct kobject *kobj =3D sysfs_file_kobj(kn);
=20
 	if (kn->flags & KERNFS_LOCKDEP)
 		lockdep_assert_held(kn);
@@ -40,7 +46,7 @@ static const struct sysfs_ops *sysfs_file_ops(struct kern=
fs_node *kn)
 static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
 {
 	struct kernfs_open_file *of =3D sf->private;
-	struct kobject *kobj =3D of->kn->parent->priv;
+	struct kobject *kobj =3D sysfs_file_kobj(of->kn);
 	const struct sysfs_ops *ops =3D sysfs_file_ops(of->kn);
 	ssize_t count;
 	char *buf;
@@ -78,7 +84,7 @@ static ssize_t sysfs_kf_bin_read(struct kernfs_open_file =
*of, char *buf,
 				 size_t count, loff_t pos)
 {
 	struct bin_attribute *battr =3D of->kn->priv;
-	struct kobject *kobj =3D of->kn->parent->priv;
+	struct kobject *kobj =3D sysfs_file_kobj(of->kn);
 	loff_t size =3D file_inode(of->file)->i_size;
=20
 	if (!count)
@@ -105,7 +111,7 @@ static ssize_t sysfs_kf_read(struct kernfs_open_file *o=
f, char *buf,
 			     size_t count, loff_t pos)
 {
 	const struct sysfs_ops *ops =3D sysfs_file_ops(of->kn);
-	struct kobject *kobj =3D of->kn->parent->priv;
+	struct kobject *kobj =3D sysfs_file_kobj(of->kn);
 	ssize_t len;
=20
 	/*
@@ -131,7 +137,7 @@ static ssize_t sysfs_kf_write(struct kernfs_open_file *=
of, char *buf,
 			      size_t count, loff_t pos)
 {
 	const struct sysfs_ops *ops =3D sysfs_file_ops(of->kn);
-	struct kobject *kobj =3D of->kn->parent->priv;
+	struct kobject *kobj =3D sysfs_file_kobj(of->kn);
=20
 	if (!count)
 		return 0;
@@ -144,7 +150,7 @@ static ssize_t sysfs_kf_bin_write(struct kernfs_open_fi=
le *of, char *buf,
 				  size_t count, loff_t pos)
 {
 	struct bin_attribute *battr =3D of->kn->priv;
-	struct kobject *kobj =3D of->kn->parent->priv;
+	struct kobject *kobj =3D sysfs_file_kobj(of->kn);
 	loff_t size =3D file_inode(of->file)->i_size;
=20
 	if (size) {
@@ -168,7 +174,7 @@ static int sysfs_kf_bin_mmap(struct kernfs_open_file *o=
f,
 			     struct vm_area_struct *vma)
 {
 	struct bin_attribute *battr =3D of->kn->priv;
-	struct kobject *kobj =3D of->kn->parent->priv;
+	struct kobject *kobj =3D sysfs_file_kobj(of->kn);
=20
 	return battr->mmap(of->file, kobj, battr, vma);
 }
@@ -177,7 +183,7 @@ static loff_t sysfs_kf_bin_llseek(struct kernfs_open_fi=
le *of, loff_t offset,
 				  int whence)
 {
 	struct bin_attribute *battr =3D of->kn->priv;
-	struct kobject *kobj =3D of->kn->parent->priv;
+	struct kobject *kobj =3D sysfs_file_kobj(of->kn);
=20
 	if (battr->llseek)
 		return battr->llseek(of->file, kobj, battr, offset, whence);
@@ -494,7 +500,7 @@ EXPORT_SYMBOL_GPL(sysfs_break_active_protection);
  */
 void sysfs_unbreak_active_protection(struct kernfs_node *kn)
 {
-	struct kobject *kobj =3D kn->parent->priv;
+	struct kobject *kobj =3D sysfs_file_kobj(kn);
=20
 	kernfs_unbreak_active_protection(kn);
 	kernfs_put(kn);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 87c79d076d6d7..9d4f09711cd73 100644
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
+	KERNFS_ROOT_INVARIANT_PARENT		=3D 0x0010,
 };
=20
 /* type-specific structures for kernfs_node union members */
@@ -199,8 +204,8 @@ struct kernfs_node {
 	 * never moved to a different parent, it is safe to access the
 	 * parent directly.
 	 */
-	struct kernfs_node	*parent;
 	const char		*name;
+	struct kernfs_node	__rcu *__parent;
=20
 	struct rb_node		rb;
=20
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index e28d5f0d20ed0..c9752eb607ec9 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -844,7 +844,7 @@ static int cgroup1_rename(struct kernfs_node *kn, struc=
t kernfs_node *new_parent
=20
 	if (kernfs_type(kn) !=3D KERNFS_DIR)
 		return -ENOTDIR;
-	if (kn->parent !=3D new_parent)
+	if (rcu_access_pointer(kn->__parent) !=3D new_parent)
 		return -EIO;
=20
 	/*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d9061bd55436b..02c4b5da2a6c3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -633,9 +633,14 @@ int cgroup_task_count(const struct cgroup *cgrp)
 	return count;
 }
=20
+static struct cgroup *kn_get_priv(struct kernfs_node *kn)
+{
+	return rcu_dereference_check(kn->__parent, kn->flags & KERNFS_ROOT_INVARI=
ANT_PARENT)->priv;
+}
+
 struct cgroup_subsys_state *of_css(struct kernfs_open_file *of)
 {
-	struct cgroup *cgrp =3D of->kn->parent->priv;
+	struct cgroup *cgrp =3D kn_get_priv(of->kn);
 	struct cftype *cft =3D of_cft(of);
=20
 	/*
@@ -1612,7 +1617,7 @@ void cgroup_kn_unlock(struct kernfs_node *kn)
 	if (kernfs_type(kn) =3D=3D KERNFS_DIR)
 		cgrp =3D kn->priv;
 	else
-		cgrp =3D kn->parent->priv;
+		cgrp =3D kn_get_priv(kn);
=20
 	cgroup_unlock();
=20
@@ -1644,7 +1649,7 @@ struct cgroup *cgroup_kn_lock_live(struct kernfs_node=
 *kn, bool drain_offline)
 	if (kernfs_type(kn) =3D=3D KERNFS_DIR)
 		cgrp =3D kn->priv;
 	else
-		cgrp =3D kn->parent->priv;
+		cgrp =3D kn_get_priv(kn);
=20
 	/*
 	 * We're gonna grab cgroup_mutex which nests outside kernfs
@@ -2118,7 +2123,8 @@ int cgroup_setup_root(struct cgroup_root *root, u16 s=
s_mask)
 	root->kf_root =3D kernfs_create_root(kf_sops,
 					   KERNFS_ROOT_CREATE_DEACTIVATED |
 					   KERNFS_ROOT_SUPPORT_EXPORTOP |
-					   KERNFS_ROOT_SUPPORT_USER_XATTR,
+					   KERNFS_ROOT_SUPPORT_USER_XATTR |
+					   KERNFS_ROOT_INVARIANT_PARENT,
 					   root_cgrp);
 	if (IS_ERR(root->kf_root)) {
 		ret =3D PTR_ERR(root->kf_root);
@@ -4119,7 +4125,7 @@ static ssize_t cgroup_file_write(struct kernfs_open_f=
ile *of, char *buf,
 				 size_t nbytes, loff_t off)
 {
 	struct cgroup_file_ctx *ctx =3D of->priv;
-	struct cgroup *cgrp =3D of->kn->parent->priv;
+	struct cgroup *cgrp =3D kn_get_priv(of->kn);
 	struct cftype *cft =3D of_cft(of);
 	struct cgroup_subsys_state *css;
 	int ret;
--=20
2.47.2


