Return-Path: <cgroups+bounces-5661-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3069D5229
	for <lists+cgroups@lfdr.de>; Thu, 21 Nov 2024 18:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24916282EEC
	for <lists+cgroups@lfdr.de>; Thu, 21 Nov 2024 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEEE1A9B57;
	Thu, 21 Nov 2024 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VLu8JG+y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X6LI2Zuh"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B56CDAF;
	Thu, 21 Nov 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732211576; cv=none; b=uuYzRDH5GUpabTUQxrWf0HW/rZbyotopvv6CUTMmFuoDn38CKvWPfgKpumqXgT39OB9NXby4uNzCnUXTB4YmTPqyDINBIfaU8hiI3n3X3eMuXOzHK8Cb14gSewXY2JHZlutoI7J3OryxLSqMpA9cjKehkU2c+3V8jYmUYzQ+qdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732211576; c=relaxed/simple;
	bh=tY6hNUAJnthwUZvC+WVcsDz14R6Jf5lV0Dqj358et94=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P82LFQa7TMwKp1dm6ji+Q7HpSFfcCYrX9Fu6PxzWUdzAR45G6Qaf3dVo8vGBpVDQj80NbPbdcoJh/XclzV2wjrqUx+JRX0O/roCErzlrd6drtPZ7SHNkosQ/lcCJHq/Nv51tV5mWO+rVcBb7wQVkJaZP+TCHdAL+JZQ0EZTj5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VLu8JG+y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X6LI2Zuh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Nov 2024 18:52:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732211571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Nak8CKTjQXJV4zHaV81stMRFlN2qGMBOJolHW5TWjmw=;
	b=VLu8JG+ycTeIdL4ji+wJyxcIzlZiGEivUEgJ1cdbwXPwfh4ZyYa6CMhqUPETH5N93wO1B3
	KP4lSTlnD2JhIf7b1u8GvCQqb3XDdOnHzjxsfFxwpJcmGuAiqsn0qMD5MpILlYoyKuAsI1
	2EQjOMun9nMqYGkk3N9q9q4KAyRnNEP+bsXB+kmg9vLKHyMslvsLVbWU30UJVxua/2tdmx
	6TaNtx2XzPWfICOFHLY8KrO5a2gbt+T3T4JgzeKTdjliaGNV7UwnUGmE2h26w1hs/SJR6W
	PKnTBcqKbywiW8Z7l1jjE0WnDmpj77oIARCG5TnRgIg3MVbovZgB4/jBC/7sKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732211571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Nak8CKTjQXJV4zHaV81stMRFlN2qGMBOJolHW5TWjmw=;
	b=X6LI2ZuhRRNL8RwNTZHtsUW1L8eHPM8akor7jMcS9qZxRlu911Ak2i7BN8QaaN2kCBXJlx
	AuEONgcQkdJsrMAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>, tglx@linutronix.de,
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: [PATCH v3] kernfs: Use RCU for kernfs_node::name and ::parent lookup.
Message-ID: <20241121175250.EJbI7VMb@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Instead of using kernfs_rename_lock to protect kernfs_node::name and
::parent from changing/ going away use RCU for its lifetime guarantees.

A node can be be renamed or moved and the observed ::name and ::parent
remains valid within the RCU section. kernfs_root() may dereference
kernfs_node::parent in order to obtain kernfs_root and the parent will
remain around and every node points to the same kernfs_root.

This can be used to optimize kernfs_name() to perform the lookup only
with RCU (without kernfs_rename_lock).

For a complete path, as it is done in kernfs_path_from_node(), the
kernfs_rename_lock is still required in order to obtain a stable parent
relationship while computing the relevant node depth. This must not
change while the nodes are inspected in order to build the path.
If the kernfs user never moves the nodes (changes the parent) then the
kernfs_rename_lock is not required and the RCU guarantees are
sufficient. This "restriction" can be set with
KERNFS_ROOT_INVARIANT_PARENT.

I went through all ::name and ::parent users and added the required
access for the lookup with a few extensions:
- rdtgroup_pseudo_lock_create() drops all locks and then uses the name
  later on. resctrl supports rename with different parents. Here I made
  a temporal copy of the name while it is used outside of the lock.
- kernfs_rename_ns() accepts NULL as new_parent. This simplifies
  sysfs_move_dir_ns() where it can set NULL in order to reuse the
  current name.
- kernfs_rename_ns() is only using kernfs_rename_lock if the parents are
  different. All users users use either RCU or kernfs_rwsem.
- kernfs_fop_readdir() drops kernfs_root::kernfs_rwsem while holding a
  reference to name and invoking dir_emit(). This has been changed and
  lock is held.
- kernfs_notify_workfn() access kernfs_node::name without any
  protection. Added kernfs_root::kernfs_rwsem for the iteration.
- kernfs_get_parent_dentry() acquires now kernfs_root::kernfs_rwsem
  while accessing the parent node.
- kernfs_node_dentry() acquires now kernfs_root::kernfs_rwsem while
  parent is accessed and the name looked up.

Suggested-by: Tejun Heo <tj@kernel.org>
Reported-by: syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/67251dc6.050a0220.529b6.015e.GAE@google.com/
Reported-by: Hillf Danton <hdanton@sina.com>
Closes: https://lore.kernel.org/20241102001224.2789-1-hdanton@sina.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/cpu/resctrl/internal.h    |   5 +
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  14 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  60 ++++---
 fs/kernfs/dir.c                           | 200 ++++++++++++----------
 fs/kernfs/file.c                          |   6 +-
 fs/kernfs/kernfs-internal.h               |  24 ++-
 fs/kernfs/mount.c                         |  19 +-
 fs/kernfs/symlink.c                       |  30 ++--
 fs/sysfs/dir.c                            |   2 +-
 fs/sysfs/file.c                           |  24 ++-
 include/linux/kernfs.h                    |  11 +-
 kernel/cgroup/cgroup-v1.c                 |   2 +-
 kernel/cgroup/cgroup.c                    |  17 +-
 security/selinux/hooks.c                  |   7 +-
 14 files changed, 261 insertions(+), 160 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 955999aecfca9..cc83dbc70a8ef 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -505,6 +505,11 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 
 extern struct mutex rdtgroup_mutex;
 
+static inline const char *rdt_kn_get_name(const struct kernfs_node *kn)
+{
+	return rcu_dereference_check(kn->name, lockdep_is_held(&rdtgroup_mutex));
+}
+
 extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 extern struct dentry *debugfs_resctrl;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 972e6b6b0481f..efe1fc5a6866f 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -52,7 +52,8 @@ static char *pseudo_lock_devnode(const struct device *dev, umode_t *mode)
 	rdtgrp = dev_get_drvdata(dev);
 	if (mode)
 		*mode = 0600;
-	return kasprintf(GFP_KERNEL, "pseudo_lock/%s", rdtgrp->kn->name);
+	guard(mutex)(&rdtgroup_mutex);
+	return kasprintf(GFP_KERNEL, "pseudo_lock/%s", rdt_kn_get_name(rdtgrp->kn));
 }
 
 static const struct class pseudo_lock_class = {
@@ -1301,6 +1302,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 	struct task_struct *thread;
 	unsigned int new_minor;
 	struct device *dev;
+	char *kn_name __free(kfree) = NULL;
 	int ret;
 
 	ret = pseudo_lock_region_alloc(plr);
@@ -1312,6 +1314,11 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 		ret = -EINVAL;
 		goto out_region;
 	}
+	kn_name = kstrdup(rdt_kn_get_name(rdtgrp->kn), GFP_KERNEL);
+	if (!kn_name) {
+		ret = -ENOMEM;
+		goto out_cstates;
+	}
 
 	plr->thread_done = 0;
 
@@ -1360,8 +1367,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 	mutex_unlock(&rdtgroup_mutex);
 
 	if (!IS_ERR_OR_NULL(debugfs_resctrl)) {
-		plr->debugfs_dir = debugfs_create_dir(rdtgrp->kn->name,
-						      debugfs_resctrl);
+		plr->debugfs_dir = debugfs_create_dir(kn_name, debugfs_resctrl);
 		if (!IS_ERR_OR_NULL(plr->debugfs_dir))
 			debugfs_create_file("pseudo_lock_measure", 0200,
 					    plr->debugfs_dir, rdtgrp,
@@ -1370,7 +1376,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 
 	dev = device_create(&pseudo_lock_class, NULL,
 			    MKDEV(pseudo_lock_major, new_minor),
-			    rdtgrp, "%s", rdtgrp->kn->name);
+			    rdtgrp, "%s", kn_name);
 
 	mutex_lock(&rdtgroup_mutex);
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d7163b764c626..03aafa2c9c07c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -907,14 +907,14 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
 			continue;
 
 		seq_printf(s, "res:%s%s\n", (rdtg == &rdtgroup_default) ? "/" : "",
-			   rdtg->kn->name);
+			   rdt_kn_get_name(rdtg->kn));
 		seq_puts(s, "mon:");
 		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
 				    mon.crdtgrp_list) {
 			if (!resctrl_arch_match_rmid(tsk, crg->mon.parent->closid,
 						     crg->mon.rmid))
 				continue;
-			seq_printf(s, "%s", crg->kn->name);
+			seq_printf(s, "%s", rdt_kn_get_name(crg->kn));
 			break;
 		}
 		seq_putc(s, '\n');
@@ -947,10 +947,16 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static void *rdt_get_kn_parent_priv(struct kernfs_node *kn)
+{
+	guard(rcu)();
+	return rcu_dereference(kn->parent)->priv;
+}
+
 static int rdt_num_closids_show(struct kernfs_open_file *of,
 				struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s = of->kn->parent->priv;
+	struct resctrl_schema *s = rdt_get_kn_parent_priv(of->kn);
 
 	seq_printf(seq, "%u\n", s->num_closid);
 	return 0;
@@ -959,7 +965,7 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
 static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s = of->kn->parent->priv;
+	struct resctrl_schema *s = rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%x\n", r->default_ctrl);
@@ -969,7 +975,7 @@ static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s = of->kn->parent->priv;
+	struct resctrl_schema *s = rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->cache.min_cbm_bits);
@@ -979,7 +985,7 @@ static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
 static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 				   struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s = of->kn->parent->priv;
+	struct resctrl_schema *s = rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%x\n", r->cache.shareable_bits);
@@ -1003,7 +1009,7 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			      struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s = of->kn->parent->priv;
+	struct resctrl_schema *s = rdt_get_kn_parent_priv(of->kn);
 	/*
 	 * Use unsigned long even though only 32 bits are used to ensure
 	 * test_bit() is used safely.
@@ -1085,7 +1091,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 static int rdt_min_bw_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s = of->kn->parent->priv;
+	struct resctrl_schema *s = rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->membw.min_bw);
@@ -1095,7 +1101,7 @@ static int rdt_min_bw_show(struct kernfs_open_file *of,
 static int rdt_num_rmids_show(struct kernfs_open_file *of,
 			      struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_resource *r = rdt_get_kn_parent_priv(of->kn);
 
 	seq_printf(seq, "%d\n", r->num_rmid);
 
@@ -1105,7 +1111,7 @@ static int rdt_num_rmids_show(struct kernfs_open_file *of,
 static int rdt_mon_features_show(struct kernfs_open_file *of,
 				 struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_resource *r = rdt_get_kn_parent_priv(of->kn);
 	struct mon_evt *mevt;
 
 	list_for_each_entry(mevt, &r->evt_list, list) {
@@ -1120,7 +1126,7 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 static int rdt_bw_gran_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s = of->kn->parent->priv;
+	struct resctrl_schema *s = rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->membw.bw_gran);
@@ -1130,7 +1136,7 @@ static int rdt_bw_gran_show(struct kernfs_open_file *of,
 static int rdt_delay_linear_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s = of->kn->parent->priv;
+	struct resctrl_schema *s = rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->membw.delay_linear);
@@ -1148,7 +1154,7 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
 static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
 					 struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s = of->kn->parent->priv;
+	struct resctrl_schema *s = rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r = s->res;
 
 	if (r->membw.throttle_mode == THREAD_THROTTLE_PER_THREAD)
@@ -1213,7 +1219,7 @@ static enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type)
 static int rdt_has_sparse_bitmasks_show(struct kernfs_open_file *of,
 					struct seq_file *seq, void *v)
 {
-	struct resctrl_schema *s = of->kn->parent->priv;
+	struct resctrl_schema *s = rdt_get_kn_parent_priv(of->kn);
 	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmasks);
@@ -1625,7 +1631,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 static int mbm_total_bytes_config_show(struct kernfs_open_file *of,
 				       struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_resource *r = rdt_get_kn_parent_priv(of->kn);
 
 	mbm_config_show(seq, r, QOS_L3_MBM_TOTAL_EVENT_ID);
 
@@ -1635,7 +1641,7 @@ static int mbm_total_bytes_config_show(struct kernfs_open_file *of,
 static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
 				       struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_resource *r = rdt_get_kn_parent_priv(of->kn);
 
 	mbm_config_show(seq, r, QOS_L3_MBM_LOCAL_EVENT_ID);
 
@@ -1741,7 +1747,7 @@ static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
 					    char *buf, size_t nbytes,
 					    loff_t off)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_resource *r = rdt_get_kn_parent_priv(of->kn);
 	int ret;
 
 	/* Valid input requires a trailing newline */
@@ -1767,7 +1773,7 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 					    char *buf, size_t nbytes,
 					    loff_t off)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_resource *r = rdt_get_kn_parent_priv(of->kn);
 	int ret;
 
 	/* Valid input requires a trailing newline */
@@ -2429,12 +2435,13 @@ static struct rdtgroup *kernfs_to_rdtgroup(struct kernfs_node *kn)
 		 * resource. "info" and its subdirectories don't
 		 * have rdtgroup structures, so return NULL here.
 		 */
-		if (kn == kn_info || kn->parent == kn_info)
+		if (kn == kn_info ||
+		    rcu_dereference_check(kn->parent, true) == kn_info)
 			return NULL;
 		else
 			return kn->priv;
 	} else {
-		return kn->parent->priv;
+		return rdt_get_kn_parent_priv(kn);
 	}
 }
 
@@ -3651,7 +3658,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
  */
 static bool is_mon_groups(struct kernfs_node *kn, const char *name)
 {
-	return (!strcmp(kn->name, "mon_groups") &&
+	return (!strcmp(rdt_kn_get_name(kn), "mon_groups") &&
 		strcmp(name, "mon_groups"));
 }
 
@@ -3760,7 +3767,7 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 
 static int rdtgroup_rmdir(struct kernfs_node *kn)
 {
-	struct kernfs_node *parent_kn = kn->parent;
+	struct kernfs_node *parent_kn;
 	struct rdtgroup *rdtgrp;
 	cpumask_var_t tmpmask;
 	int ret = 0;
@@ -3773,6 +3780,7 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 		ret = -EPERM;
 		goto out;
 	}
+	parent_kn = rcu_dereference_check(kn->parent, lockdep_is_held(&rdtgroup_mutex));
 
 	/*
 	 * If the rdtgroup is a ctrl_mon group and parent directory
@@ -3790,7 +3798,7 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 			ret = rdtgroup_rmdir_ctrl(rdtgrp, tmpmask);
 		}
 	} else if (rdtgrp->type == RDTMON_GROUP &&
-		 is_mon_groups(parent_kn, kn->name)) {
+		 is_mon_groups(parent_kn, rdt_kn_get_name(kn))) {
 		ret = rdtgroup_rmdir_mon(rdtgrp, tmpmask);
 	} else {
 		ret = -EPERM;
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
 
-	if (rdtgrp->type != RDTMON_GROUP || !kn->parent ||
-	    !is_mon_groups(kn->parent, kn->name)) {
+	kn_parent = rcu_dereference_check(kn->parent, lockdep_is_held(&rdtgroup_mutex));
+	if (rdtgrp->type != RDTMON_GROUP || !kn_parent ||
+	    !is_mon_groups(kn_parent, rdt_kn_get_name(kn))) {
 		rdt_last_cmd_puts("Source must be a MON group\n");
 		ret = -EPERM;
 		goto out;
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 458519e416fe7..dcd71fd31f629 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -51,22 +51,14 @@ static bool kernfs_lockdep(struct kernfs_node *kn)
 #endif
 }
 
-static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
-{
-	if (!kn)
-		return strscpy(buf, "(null)", buflen);
-
-	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
-}
-
 /* kernfs_node_depth - compute depth from @from to @to */
 static size_t kernfs_depth(struct kernfs_node *from, struct kernfs_node *to)
 {
 	size_t depth = 0;
 
-	while (to->parent && to != from) {
+	while (rcu_dereference(to->parent) && to != from) {
 		depth++;
-		to = to->parent;
+		to = rcu_dereference(to->parent);
 	}
 	return depth;
 }
@@ -84,18 +76,18 @@ static struct kernfs_node *kernfs_common_ancestor(struct kernfs_node *a,
 	db = kernfs_depth(rb->kn, b);
 
 	while (da > db) {
-		a = a->parent;
+		a = rcu_dereference(a->parent);
 		da--;
 	}
 	while (db > da) {
-		b = b->parent;
+		b = rcu_dereference(b->parent);
 		db--;
 	}
 
 	/* worst case b and a will be the same at root */
 	while (b != a) {
-		b = b->parent;
-		a = a->parent;
+		b = rcu_dereference(b->parent);
+		a = rcu_dereference(a->parent);
 	}
 
 	return a;
@@ -168,10 +160,13 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 
 	/* Calculate how many bytes we need for the rest */
 	for (i = depth_to - 1; i >= 0; i--) {
-		for (kn = kn_to, j = 0; j < i; j++)
-			kn = kn->parent;
+		const char *name;
 
-		len += scnprintf(buf + len, buflen - len, "/%s", kn->name);
+		for (kn = kn_to, j = 0; j < i; j++)
+			kn = rcu_dereference(kn->parent);
+
+		name = rcu_dereference(kn->name);
+		len += scnprintf(buf + len, buflen - len, "/%s", name);
 	}
 
 	return len;
@@ -195,13 +190,17 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
  */
 int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
 {
-	unsigned long flags;
-	int ret;
+	struct kernfs_node *kn_parent;
+	if (!kn)
+		return strscpy(buf, "(null)", buflen);
 
-	read_lock_irqsave(&kernfs_rename_lock, flags);
-	ret = kernfs_name_locked(kn, buf, buflen);
-	read_unlock_irqrestore(&kernfs_rename_lock, flags);
-	return ret;
+	guard(rcu)();
+	/*
+	 * KERNFS_ROOT_INVARIANT_PARENT is ignored here. The name is RCU freed and
+	 * the parent is either existing or not.
+	 */
+	kn_parent = rcu_dereference(kn->parent);
+	return strscpy(buf, kn_parent ? rcu_dereference(kn->name) : "/", buflen);
 }
 
 /**
@@ -223,13 +222,17 @@ int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
 int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
 			  char *buf, size_t buflen)
 {
-	unsigned long flags;
-	int ret;
+	struct kernfs_root *root;
 
-	read_lock_irqsave(&kernfs_rename_lock, flags);
-	ret = kernfs_path_from_node_locked(to, from, buf, buflen);
-	read_unlock_irqrestore(&kernfs_rename_lock, flags);
-	return ret;
+	guard(rcu)();
+	if (to) {
+		root = kernfs_root(to);
+		if (!(root->flags & KERNFS_ROOT_INVARIANT_PARENT)) {
+			guard(read_lock_irqsave)(&kernfs_rename_lock);
+			return kernfs_path_from_node_locked(to, from, buf, buflen);
+		}
+	}
+	return kernfs_path_from_node_locked(to, from, buf, buflen);
 }
 EXPORT_SYMBOL_GPL(kernfs_path_from_node);
 
@@ -295,7 +298,7 @@ struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn)
 	unsigned long flags;
 
 	read_lock_irqsave(&kernfs_rename_lock, flags);
-	parent = kn->parent;
+	parent = rcu_dereference_check(kn->parent, lockdep_is_held(&kernfs_rename_lock));
 	kernfs_get(parent);
 	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 
@@ -336,13 +339,13 @@ static int kernfs_name_compare(unsigned int hash, const char *name,
 		return -1;
 	if (ns > kn->ns)
 		return 1;
-	return strcmp(name, kn->name);
+	return strcmp(name, kernfs_rcu_get_name(kn));
 }
 
 static int kernfs_sd_compare(const struct kernfs_node *left,
 			     const struct kernfs_node *right)
 {
-	return kernfs_name_compare(left->hash, left->name, left->ns, right);
+	return kernfs_name_compare(left->hash, kernfs_rcu_get_name(left), left->ns, right);
 }
 
 /**
@@ -360,8 +363,12 @@ static int kernfs_sd_compare(const struct kernfs_node *left,
  */
 static int kernfs_link_sibling(struct kernfs_node *kn)
 {
-	struct rb_node **node = &kn->parent->dir.children.rb_node;
 	struct rb_node *parent = NULL;
+	struct kernfs_node *kn_parent;
+	struct rb_node **node;
+
+	kn_parent = kernfs_rcu_get_parent(kn);
+	node = &kn_parent->dir.children.rb_node;
 
 	while (*node) {
 		struct kernfs_node *pos;
@@ -380,13 +387,13 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
 
 	/* add new node and rebalance the tree */
 	rb_link_node(&kn->rb, parent, node);
-	rb_insert_color(&kn->rb, &kn->parent->dir.children);
+	rb_insert_color(&kn->rb, &kn_parent->dir.children);
 
 	/* successfully added, account subdir number */
 	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 	if (kernfs_type(kn) == KERNFS_DIR)
-		kn->parent->dir.subdirs++;
-	kernfs_inc_rev(kn->parent);
+		kn_parent->dir.subdirs++;
+	kernfs_inc_rev(kn_parent);
 	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
 	return 0;
@@ -407,16 +414,19 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
  */
 static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 {
+	struct kernfs_node *kn_parent;
+
 	if (RB_EMPTY_NODE(&kn->rb))
 		return false;
 
+	kn_parent = kernfs_rcu_get_parent(kn);
 	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 	if (kernfs_type(kn) == KERNFS_DIR)
-		kn->parent->dir.subdirs--;
-	kernfs_inc_rev(kn->parent);
+		kn_parent->dir.subdirs--;
+	kernfs_inc_rev(kn_parent);
 	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
-	rb_erase(&kn->rb, &kn->parent->dir.children);
+	rb_erase(&kn->rb, &kn_parent->dir.children);
 	RB_CLEAR_NODE(&kn->rb);
 	return true;
 }
@@ -533,7 +543,8 @@ static void kernfs_free_rcu(struct rcu_head *rcu)
 {
 	struct kernfs_node *kn = container_of(rcu, struct kernfs_node, rcu);
 
-	kfree_const(kn->name);
+	/* If the whole node goes away, the name can't be used outside */
+	kfree_const(rcu_dereference_check(kn->name, true));
 
 	if (kn->iattr) {
 		simple_xattrs_free(&kn->iattr->xattrs, NULL);
@@ -557,16 +568,18 @@ void kernfs_put(struct kernfs_node *kn)
 	if (!kn || !atomic_dec_and_test(&kn->count))
 		return;
 	root = kernfs_root(kn);
+	guard(rcu)();
  repeat:
 	/*
 	 * Moving/renaming is always done while holding reference.
 	 * kn->parent won't change beneath us.
 	 */
-	parent = kn->parent;
+	parent = rcu_dereference(kn->parent);
 
 	WARN_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS,
 		  "kernfs_put: %s/%s: released with incorrect active_ref %d\n",
-		  parent ? parent->name : "", kn->name, atomic_read(&kn->active));
+		  parent ? rcu_dereference(parent->name) : "",
+		  rcu_dereference(kn->name), atomic_read(&kn->active));
 
 	if (kernfs_type(kn) == KERNFS_LINK)
 		kernfs_put(kn->symlink.target_kn);
@@ -643,7 +656,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
 	RB_CLEAR_NODE(&kn->rb);
 
-	kn->name = name;
+	rcu_assign_pointer(kn->name, name);
 	kn->mode = mode;
 	kn->flags = flags;
 
@@ -701,7 +714,7 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 			       name, mode, uid, gid, flags);
 	if (kn) {
 		kernfs_get(parent);
-		kn->parent = parent;
+		rcu_assign_pointer(kn->parent, parent);
 	}
 	return kn;
 }
@@ -769,18 +782,19 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
  */
 int kernfs_add_one(struct kernfs_node *kn)
 {
-	struct kernfs_node *parent = kn->parent;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct kernfs_root *root = kernfs_root(kn);
 	struct kernfs_iattrs *ps_iattr;
+	struct kernfs_node *parent;
 	bool has_ns;
 	int ret;
 
 	down_write(&root->kernfs_rwsem);
+	parent = kernfs_rcu_get_parent(kn);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
 	if (WARN(has_ns != (bool)kn->ns, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
-		 has_ns ? "required" : "invalid", parent->name, kn->name))
+		 has_ns ? "required" : "invalid", kernfs_rcu_get_name(parent), kernfs_rcu_get_name(kn)))
 		goto out_unlock;
 
 	if (kernfs_type(parent) != KERNFS_DIR)
@@ -790,7 +804,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	if (parent->flags & (KERNFS_REMOVING | KERNFS_EMPTY_DIR))
 		goto out_unlock;
 
-	kn->hash = kernfs_name_hash(kn->name, kn->ns);
+	kn->hash = kernfs_name_hash(kernfs_rcu_get_name(kn), kn->ns);
 
 	ret = kernfs_link_sibling(kn);
 	if (ret)
@@ -846,7 +860,7 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
-		     has_ns ? "required" : "invalid", parent->name, name);
+		     has_ns ? "required" : "invalid", kernfs_rcu_get_name(parent), name);
 		return NULL;
 	}
 
@@ -1111,7 +1125,7 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 
 static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 {
-	struct kernfs_node *kn;
+	struct kernfs_node *kn, *parent;
 	struct kernfs_root *root;
 
 	if (flags & LOOKUP_RCU)
@@ -1119,8 +1133,6 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 
 	/* Negative hashed dentry? */
 	if (d_really_is_negative(dentry)) {
-		struct kernfs_node *parent;
-
 		/* If the kernfs parent node has changed discard and
 		 * proceed to ->lookup.
 		 *
@@ -1162,16 +1174,17 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	if (!kernfs_active(kn))
 		goto out_bad;
 
+	parent = kernfs_rcu_get_parent(kn);
 	/* The kernfs node has been moved? */
-	if (kernfs_dentry_node(dentry->d_parent) != kn->parent)
+	if (kernfs_dentry_node(dentry->d_parent) != parent)
 		goto out_bad;
 
 	/* The kernfs node has been renamed */
-	if (strcmp(dentry->d_name.name, kn->name) != 0)
+	if (strcmp(dentry->d_name.name, kernfs_rcu_get_name(kn)) != 0)
 		goto out_bad;
 
 	/* The kernfs node has been moved to a different namespace */
-	if (kn->parent && kernfs_ns_enabled(kn->parent) &&
+	if (parent && kernfs_ns_enabled(parent) &&
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
@@ -1364,7 +1377,7 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 		return kernfs_leftmost_descendant(rb_to_kn(rbn));
 
 	/* no sibling left, visit parent */
-	return pos->parent;
+	return kernfs_rcu_get_parent(pos);
 }
 
 static void kernfs_activate_one(struct kernfs_node *kn)
@@ -1376,7 +1389,7 @@ static void kernfs_activate_one(struct kernfs_node *kn)
 	if (kernfs_active(kn) || (kn->flags & (KERNFS_HIDDEN | KERNFS_REMOVING)))
 		return;
 
-	WARN_ON_ONCE(kn->parent && RB_EMPTY_NODE(&kn->rb));
+	WARN_ON_ONCE(kernfs_rcu_get_parent(kn) && RB_EMPTY_NODE(&kn->rb));
 	WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
 
 	atomic_sub(KN_DEACTIVATED_BIAS, &kn->active);
@@ -1446,7 +1459,7 @@ void kernfs_show(struct kernfs_node *kn, bool show)
 
 static void __kernfs_remove(struct kernfs_node *kn)
 {
-	struct kernfs_node *pos;
+	struct kernfs_node *pos, *parent;
 
 	/* Short-circuit if non-root @kn has already finished removal. */
 	if (!kn)
@@ -1458,10 +1471,10 @@ static void __kernfs_remove(struct kernfs_node *kn)
 	 * This is for kernfs_remove_self() which plays with active ref
 	 * after removal.
 	 */
-	if (kn->parent && RB_EMPTY_NODE(&kn->rb))
+	if (kernfs_rcu_get_parent(kn) && RB_EMPTY_NODE(&kn->rb))
 		return;
 
-	pr_debug("kernfs %s: removing\n", kn->name);
+	pr_debug("kernfs %s: removing\n", kernfs_rcu_get_name(kn));
 
 	/* prevent new usage by marking all nodes removing and deactivating */
 	pos = NULL;
@@ -1484,14 +1497,14 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		kernfs_get(pos);
 
 		kernfs_drain(pos);
-
+		parent = kernfs_rcu_get_parent(pos);
 		/*
 		 * kernfs_unlink_sibling() succeeds once per node.  Use it
 		 * to decide who's responsible for cleanups.
 		 */
-		if (!pos->parent || kernfs_unlink_sibling(pos)) {
+		if (!parent || kernfs_unlink_sibling(pos)) {
 			struct kernfs_iattrs *ps_iattr =
-				pos->parent ? pos->parent->iattr : NULL;
+				parent ? parent->iattr : NULL;
 
 			/* update timestamps on the parent */
 			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
@@ -1717,7 +1730,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 {
 	struct kernfs_node *old_parent;
 	struct kernfs_root *root;
-	const char *old_name = NULL;
+	const char *old_name;
 	int error;
 
 	/* can't move or rename root */
@@ -1732,9 +1745,19 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	    (new_parent->flags & KERNFS_EMPTY_DIR))
 		goto out;
 
+	old_parent = kernfs_rcu_get_parent(kn);
+	if (root->flags & KERNFS_ROOT_INVARIANT_PARENT) {
+		error = -EINVAL;
+		if (WARN_ON_ONCE(old_parent != new_parent))
+			goto out;
+	}
+
 	error = 0;
-	if ((kn->parent == new_parent) && (kn->ns == new_ns) &&
-	    (strcmp(kn->name, new_name) == 0))
+	old_name = kernfs_rcu_get_name(kn);
+	if (!new_name)
+		new_name = old_name;
+	if ((old_parent == new_parent) && (kn->ns == new_ns) &&
+	    (strcmp(old_name, new_name) == 0))
 		goto out;	/* nothing to rename */
 
 	error = -EEXIST;
@@ -1742,7 +1765,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		goto out;
 
 	/* rename kernfs_node */
-	if (strcmp(kn->name, new_name) != 0) {
+	if (strcmp(old_name, new_name) != 0) {
 		error = -ENOMEM;
 		new_name = kstrdup_const(new_name, GFP_KERNEL);
 		if (!new_name)
@@ -1755,27 +1778,32 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	 * Move to the appropriate place in the appropriate directories rbtree.
 	 */
 	kernfs_unlink_sibling(kn);
-	kernfs_get(new_parent);
 
-	/* rename_lock protects ->parent and ->name accessors */
-	write_lock_irq(&kernfs_rename_lock);
+	/* rename_lock protects ->parent accessors */
+	if (old_parent != new_parent) {
+		kernfs_get(new_parent);
+		write_lock_irq(&kernfs_rename_lock);
 
-	old_parent = kn->parent;
-	kn->parent = new_parent;
+		rcu_assign_pointer(kn->parent, new_parent);
 
-	kn->ns = new_ns;
-	if (new_name) {
-		old_name = kn->name;
-		kn->name = new_name;
+		kn->ns = new_ns;
+		if (new_name)
+			rcu_assign_pointer(kn->name, new_name);
+
+		write_unlock_irq(&kernfs_rename_lock);
+		kernfs_put(old_parent);
+	} else {
+		/* name assignment is RCU protected, parent is the same */
+		kn->ns = new_ns;
+		if (new_name)
+			rcu_assign_pointer(kn->name, new_name);
 	}
 
-	write_unlock_irq(&kernfs_rename_lock);
-
-	kn->hash = kernfs_name_hash(kn->name, kn->ns);
+	kn->hash = kernfs_name_hash(new_name ?: old_name, kn->ns);
 	kernfs_link_sibling(kn);
 
-	kernfs_put(old_parent);
-	kfree_const(old_name);
+	if (new_name && !is_kernel_rodata((unsigned long)old_name))
+		kfree_rcu_mightsleep(old_name);
 
 	error = 0;
  out:
@@ -1794,7 +1822,7 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
 {
 	if (pos) {
 		int valid = kernfs_active(pos) &&
-			pos->parent == parent && hash == pos->hash;
+			kernfs_rcu_get_parent(pos) == parent && hash == pos->hash;
 		kernfs_put(pos);
 		if (!valid)
 			pos = NULL;
@@ -1859,7 +1887,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	for (pos = kernfs_dir_pos(ns, parent, ctx->pos, pos);
 	     pos;
 	     pos = kernfs_dir_next_pos(ns, parent, ctx->pos, pos)) {
-		const char *name = pos->name;
+		const char *name = kernfs_rcu_get_name(pos);
 		unsigned int type = fs_umode_to_dtype(pos->mode);
 		int len = strlen(name);
 		ino_t ino = kernfs_ino(pos);
@@ -1868,10 +1896,10 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		up_read(&root->kernfs_rwsem);
-		if (!dir_emit(ctx, name, len, ino, type))
+		if (!dir_emit(ctx, name, len, ino, type)) {
+			up_read(&root->kernfs_rwsem);
 			return 0;
-		down_read(&root->kernfs_rwsem);
+		}
 	}
 	up_read(&root->kernfs_rwsem);
 	file->private_data = NULL;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8502ef68459b9..05f7b30283150 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -911,9 +911,11 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	/* kick fsnotify */
 
 	down_read(&root->kernfs_supers_rwsem);
+	down_read(&root->kernfs_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
 		struct inode *p_inode = NULL;
+		const char *kn_name;
 		struct inode *inode;
 		struct qstr name;
 
@@ -927,7 +929,8 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		if (!inode)
 			continue;
 
-		name = (struct qstr)QSTR_INIT(kn->name, strlen(kn->name));
+		kn_name = kernfs_rcu_get_name(kn);
+		name = (struct qstr)QSTR_INIT(kn_name, strlen(kn_name));
 		parent = kernfs_get_parent(kn);
 		if (parent) {
 			p_inode = ilookup(info->sb, kernfs_ino(parent));
@@ -948,6 +951,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	}
 
 	up_read(&root->kernfs_supers_rwsem);
+	up_read(&root->kernfs_rwsem);
 	kernfs_put(kn);
 	goto repeat;
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index b42ee6547cdc1..19a5ad269b0de 100644
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
-		kn = kn->parent;
+	guard(rcu)();
+	knp = rcu_dereference(kn->parent);
+	if (knp)
+		kn = knp;
 	return kn->dir.root;
 }
 
@@ -97,6 +100,21 @@ struct kernfs_super_info {
 };
 #define kernfs_info(SB) ((struct kernfs_super_info *)(SB->s_fs_info))
 
+static inline bool kernfs_root_is_locked(const struct kernfs_node *kn)
+{
+	return lockdep_is_held(&kernfs_root(kn)->kernfs_rwsem);
+}
+
+static inline const char *kernfs_rcu_get_name(const struct kernfs_node *kn)
+{
+	return rcu_dereference_check(kn->name, kernfs_root_is_locked(kn));
+}
+
+static inline struct kernfs_node *kernfs_rcu_get_parent(const struct kernfs_node *kn)
+{
+	return rcu_dereference_check(kn->parent, kernfs_root_is_locked(kn));
+}
+
 static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
 {
 	if (d_really_is_negative(dentry))
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 1358c21837f1a..db71faba3bb53 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -145,8 +145,10 @@ static struct dentry *kernfs_fh_to_parent(struct super_block *sb,
 static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(child);
+	struct kernfs_root *root = kernfs_root(kn);
 
-	return d_obtain_alias(kernfs_get_inode(child->d_sb, kn->parent));
+	guard(rwsem_read)(&root->kernfs_rwsem);
+	return d_obtain_alias(kernfs_get_inode(child->d_sb, kernfs_rcu_get_parent(kn)));
 }
 
 static const struct export_operations kernfs_export_ops = {
@@ -186,10 +188,10 @@ static struct kernfs_node *find_next_ancestor(struct kernfs_node *child,
 		return NULL;
 	}
 
-	while (child->parent != parent) {
-		if (!child->parent)
+	while (kernfs_rcu_get_parent(child) != parent) {
+		child = kernfs_rcu_get_parent(child);
+		if (!child)
 			return NULL;
-		child = child->parent;
 	}
 
 	return child;
@@ -207,6 +209,7 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 {
 	struct dentry *dentry;
 	struct kernfs_node *knparent;
+	struct kernfs_root *root;
 
 	BUG_ON(sb->s_op != &kernfs_sops);
 
@@ -216,6 +219,9 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 	if (!kn->parent)
 		return dentry;
 
+	root = kernfs_root(kn);
+	guard(rwsem_read)(&root->kernfs_rwsem);
+
 	knparent = find_next_ancestor(kn, NULL);
 	if (WARN_ON(!knparent)) {
 		dput(dentry);
@@ -225,6 +231,7 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 	do {
 		struct dentry *dtmp;
 		struct kernfs_node *kntmp;
+		const char *name;
 
 		if (kn == knparent)
 			return dentry;
@@ -233,8 +240,8 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 			dput(dentry);
 			return ERR_PTR(-EINVAL);
 		}
-		dtmp = lookup_positive_unlocked(kntmp->name, dentry,
-					       strlen(kntmp->name));
+		name = rcu_dereference(kntmp->name);
+		dtmp = lookup_positive_unlocked(name, dentry, strlen(name));
 		dput(dentry);
 		if (IS_ERR(dtmp))
 			return dtmp;
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 45371a70caa71..142cdf2af313b 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -62,10 +62,10 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 
 	/* go up to the root, stop at the base */
 	base = parent;
-	while (base->parent) {
-		kn = target->parent;
-		while (kn->parent && base != kn)
-			kn = kn->parent;
+	while (kernfs_rcu_get_parent(base)) {
+		kn = kernfs_rcu_get_parent(target);
+		while (kernfs_rcu_get_parent(kn) && base != kn)
+			kn = kernfs_rcu_get_parent(kn);
 
 		if (base == kn)
 			break;
@@ -75,14 +75,14 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 
 		strcpy(s, "../");
 		s += 3;
-		base = base->parent;
+		base = kernfs_rcu_get_parent(base);
 	}
 
 	/* determine end of target string for reverse fillup */
 	kn = target;
-	while (kn->parent && kn != base) {
-		len += strlen(kn->name) + 1;
-		kn = kn->parent;
+	while (kernfs_rcu_get_parent(kn) && kn != base) {
+		len += strlen(kernfs_rcu_get_name(kn)) + 1;
+		kn = kernfs_rcu_get_parent(kn);
 	}
 
 	/* check limits */
@@ -94,15 +94,16 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 
 	/* reverse fillup of target string from target to base */
 	kn = target;
-	while (kn->parent && kn != base) {
-		int slen = strlen(kn->name);
+	while (kernfs_rcu_get_parent(kn) && kn != base) {
+		const char *name = kernfs_rcu_get_name(kn);
+		int slen = strlen(name);
 
 		len -= slen;
-		memcpy(s + len, kn->name, slen);
+		memcpy(s + len, name, slen);
 		if (len)
 			s[--len] = '/';
 
-		kn = kn->parent;
+		kn = kernfs_rcu_get_parent(kn);
 	}
 
 	return 0;
@@ -111,12 +112,13 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 static int kernfs_getlink(struct inode *inode, char *path)
 {
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_node *parent = kn->parent;
+	struct kernfs_node *parent;
 	struct kernfs_node *target = kn->symlink.target_kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct kernfs_root *root = kernfs_root(kn);
 	int error;
 
 	down_read(&root->kernfs_rwsem);
+	parent = kernfs_rcu_get_parent(kn);
 	error = kernfs_get_target_path(parent, target, path);
 	up_read(&root->kernfs_rwsem);
 
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 4df2afa551dc6..94e12efd92f21 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -123,7 +123,7 @@ int sysfs_move_dir_ns(struct kobject *kobj, struct kobject *new_parent_kobj,
 	new_parent = new_parent_kobj && new_parent_kobj->sd ?
 		new_parent_kobj->sd : sysfs_root_kn;
 
-	return kernfs_rename_ns(kn, new_parent, kn->name, new_ns);
+	return kernfs_rename_ns(kn, new_parent, NULL, new_ns);
 }
 
 /**
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index d1995e2d6c943..e9bfe3e80809d 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -19,13 +19,19 @@
 
 #include "sysfs.h"
 
+static struct kobject *sysfs_file_kobj(struct kernfs_node *kn)
+{
+	guard(rcu)();
+	return rcu_dereference(kn->parent)->priv;
+}
+
 /*
  * Determine ktype->sysfs_ops for the given kernfs_node.  This function
  * must be called while holding an active reference.
  */
 static const struct sysfs_ops *sysfs_file_ops(struct kernfs_node *kn)
 {
-	struct kobject *kobj = kn->parent->priv;
+	struct kobject *kobj = sysfs_file_kobj(kn);
 
 	if (kn->flags & KERNFS_LOCKDEP)
 		lockdep_assert_held(kn);
@@ -40,7 +46,7 @@ static const struct sysfs_ops *sysfs_file_ops(struct kernfs_node *kn)
 static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
 {
 	struct kernfs_open_file *of = sf->private;
-	struct kobject *kobj = of->kn->parent->priv;
+	struct kobject *kobj = sysfs_file_kobj(of->kn);
 	const struct sysfs_ops *ops = sysfs_file_ops(of->kn);
 	ssize_t count;
 	char *buf;
@@ -78,7 +84,7 @@ static ssize_t sysfs_kf_bin_read(struct kernfs_open_file *of, char *buf,
 				 size_t count, loff_t pos)
 {
 	struct bin_attribute *battr = of->kn->priv;
-	struct kobject *kobj = of->kn->parent->priv;
+	struct kobject *kobj = sysfs_file_kobj(of->kn);
 	loff_t size = file_inode(of->file)->i_size;
 
 	if (!count)
@@ -102,7 +108,7 @@ static ssize_t sysfs_kf_read(struct kernfs_open_file *of, char *buf,
 			     size_t count, loff_t pos)
 {
 	const struct sysfs_ops *ops = sysfs_file_ops(of->kn);
-	struct kobject *kobj = of->kn->parent->priv;
+	struct kobject *kobj = sysfs_file_kobj(of->kn);
 	ssize_t len;
 
 	/*
@@ -128,7 +134,7 @@ static ssize_t sysfs_kf_write(struct kernfs_open_file *of, char *buf,
 			      size_t count, loff_t pos)
 {
 	const struct sysfs_ops *ops = sysfs_file_ops(of->kn);
-	struct kobject *kobj = of->kn->parent->priv;
+	struct kobject *kobj = sysfs_file_kobj(of->kn);
 
 	if (!count)
 		return 0;
@@ -141,7 +147,7 @@ static ssize_t sysfs_kf_bin_write(struct kernfs_open_file *of, char *buf,
 				  size_t count, loff_t pos)
 {
 	struct bin_attribute *battr = of->kn->priv;
-	struct kobject *kobj = of->kn->parent->priv;
+	struct kobject *kobj = sysfs_file_kobj(of->kn);
 	loff_t size = file_inode(of->file)->i_size;
 
 	if (size) {
@@ -162,7 +168,7 @@ static int sysfs_kf_bin_mmap(struct kernfs_open_file *of,
 			     struct vm_area_struct *vma)
 {
 	struct bin_attribute *battr = of->kn->priv;
-	struct kobject *kobj = of->kn->parent->priv;
+	struct kobject *kobj = sysfs_file_kobj(of->kn);
 
 	return battr->mmap(of->file, kobj, battr, vma);
 }
@@ -171,7 +177,7 @@ static loff_t sysfs_kf_bin_llseek(struct kernfs_open_file *of, loff_t offset,
 				  int whence)
 {
 	struct bin_attribute *battr = of->kn->priv;
-	struct kobject *kobj = of->kn->parent->priv;
+	struct kobject *kobj = sysfs_file_kobj(of->kn);
 
 	if (battr->llseek)
 		return battr->llseek(of->file, kobj, battr, offset, whence);
@@ -482,7 +488,7 @@ EXPORT_SYMBOL_GPL(sysfs_break_active_protection);
  */
 void sysfs_unbreak_active_protection(struct kernfs_node *kn)
 {
-	struct kobject *kobj = kn->parent->priv;
+	struct kobject *kobj = sysfs_file_kobj(kn);
 
 	kernfs_unbreak_active_protection(kn);
 	kernfs_put(kn);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 87c79d076d6d7..c81947f022d6f 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -147,6 +147,11 @@ enum kernfs_root_flag {
 	 * Support user xattrs to be written to nodes rooted at this root.
 	 */
 	KERNFS_ROOT_SUPPORT_USER_XATTR		= 0x0008,
+
+	/*
+	 * Renames must not change the parent node.
+	 */
+	KERNFS_ROOT_INVARIANT_PARENT		= 0x0010,
 };
 
 /* type-specific structures for kernfs_node union members */
@@ -199,8 +204,8 @@ struct kernfs_node {
 	 * never moved to a different parent, it is safe to access the
 	 * parent directly.
 	 */
-	struct kernfs_node	*parent;
-	const char		*name;
+	struct kernfs_node	__rcu *parent;
+	const char		__rcu *name;
 
 	struct rb_node		rb;
 
@@ -395,7 +400,7 @@ static inline bool kernfs_ns_enabled(struct kernfs_node *kn)
 }
 
 int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen);
-int kernfs_path_from_node(struct kernfs_node *root_kn, struct kernfs_node *kn,
+int kernfs_path_from_node(struct kernfs_node *kn_to, struct kernfs_node *kn_from,
 			  char *buf, size_t buflen);
 void pr_cont_kernfs_name(struct kernfs_node *kn);
 void pr_cont_kernfs_path(struct kernfs_node *kn);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index e28d5f0d20ed0..202e329759b12 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -844,7 +844,7 @@ static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent
 
 	if (kernfs_type(kn) != KERNFS_DIR)
 		return -ENOTDIR;
-	if (kn->parent != new_parent)
+	if (rcu_dereference_check(kn->parent, true) != new_parent)
 		return -EIO;
 
 	/*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 044c7ba1cc482..d11d05a53783c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -633,9 +633,15 @@ int cgroup_task_count(const struct cgroup *cgrp)
 	return count;
 }
 
+static struct cgroup *cg_get_parent_priv(struct kernfs_node *kn)
+{
+	/* The parent can not be changed */
+	return rcu_dereference_check(kn->parent, true)->priv;
+}
+
 struct cgroup_subsys_state *of_css(struct kernfs_open_file *of)
 {
-	struct cgroup *cgrp = of->kn->parent->priv;
+	struct cgroup *cgrp = cg_get_parent_priv(of->kn);
 	struct cftype *cft = of_cft(of);
 
 	/*
@@ -1612,7 +1618,7 @@ void cgroup_kn_unlock(struct kernfs_node *kn)
 	if (kernfs_type(kn) == KERNFS_DIR)
 		cgrp = kn->priv;
 	else
-		cgrp = kn->parent->priv;
+		cgrp = cg_get_parent_priv(kn);
 
 	cgroup_unlock();
 
@@ -1644,7 +1650,7 @@ struct cgroup *cgroup_kn_lock_live(struct kernfs_node *kn, bool drain_offline)
 	if (kernfs_type(kn) == KERNFS_DIR)
 		cgrp = kn->priv;
 	else
-		cgrp = kn->parent->priv;
+		cgrp = cg_get_parent_priv(kn);
 
 	/*
 	 * We're gonna grab cgroup_mutex which nests outside kernfs
@@ -2118,7 +2124,8 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	root->kf_root = kernfs_create_root(kf_sops,
 					   KERNFS_ROOT_CREATE_DEACTIVATED |
 					   KERNFS_ROOT_SUPPORT_EXPORTOP |
-					   KERNFS_ROOT_SUPPORT_USER_XATTR,
+					   KERNFS_ROOT_SUPPORT_USER_XATTR |
+					   KERNFS_ROOT_INVARIANT_PARENT,
 					   root_cgrp);
 	if (IS_ERR(root->kf_root)) {
 		ret = PTR_ERR(root->kf_root);
@@ -4119,7 +4126,7 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 				 size_t nbytes, loff_t off)
 {
 	struct cgroup_file_ctx *ctx = of->priv;
-	struct cgroup *cgrp = of->kn->parent->priv;
+	struct cgroup *cgrp = cg_get_parent_priv(of->kn);
 	struct cftype *cft = of_cft(of);
 	struct cgroup_subsys_state *css;
 	int ret;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fc926d3cac6e2..ae06bc0e99d23 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3582,10 +3582,13 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 		newsid = tsec->create_sid;
 	} else {
 		u16 secclass = inode_mode_to_security_class(kn->mode);
+		const char *kn_name;
 		struct qstr q;
 
-		q.name = kn->name;
-		q.hash_len = hashlen_string(kn_dir, kn->name);
+		/* kn is fresh, can't be renamed, name goes not away */
+		kn_name = rcu_dereference_check(kn->name, true);
+		q.name = kn_name;
+		q.hash_len = hashlen_string(kn_dir, kn_name);
 
 		rc = security_transition_sid(tsec->sid,
 					     parent_sid, secclass, &q,
-- 
2.45.2


