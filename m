Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8E9D108AA
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2019 16:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfEAODD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 May 2019 10:03:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:3043 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfEAODD (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 1 May 2019 10:03:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 07:03:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,417,1549958400"; 
   d="scan'208";a="145141398"
Received: from nperf12.hd.intel.com ([10.127.88.161])
  by fmsmga008.fm.intel.com with ESMTP; 01 May 2019 07:03:01 -0700
From:   Brian Welty <brian.welty@intel.com>
To:     cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        ChunMing Zhou <David1.Zhou@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Subject: [RFC PATCH 2/5] cgroup: Change kernfs_node for directories to store cgroup_subsys_state
Date:   Wed,  1 May 2019 10:04:35 -0400
Message-Id: <20190501140438.9506-3-brian.welty@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501140438.9506-1-brian.welty@intel.com>
References: <20190501140438.9506-1-brian.welty@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Change the kernfs_node.priv to store the cgroup_subsys_state (CSS) pointer
for directories, instead of storing cgroup pointer.  This is done in order
to support files within the cgroup associated with devices.  We require
of_css() to return the device-specific CSS pointer for these files.

Cc: cgroups@vger.kernel.org
Signed-off-by: Brian Welty <brian.welty@intel.com>
---
 kernel/cgroup/cgroup-v1.c | 10 ++++----
 kernel/cgroup/cgroup.c    | 48 +++++++++++++++++----------------------
 2 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index c126b34fd4ff..4fa56cc2b99c 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -723,6 +723,7 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry)
 {
 	struct kernfs_node *kn = kernfs_node_from_dentry(dentry);
+	struct cgroup_subsys_state *css;
 	struct cgroup *cgrp;
 	struct css_task_iter it;
 	struct task_struct *tsk;
@@ -740,12 +741,13 @@ int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry)
 	 * @kn->priv is RCU safe.  Let's do the RCU dancing.
 	 */
 	rcu_read_lock();
-	cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
-	if (!cgrp || cgroup_is_dead(cgrp)) {
+	css = rcu_dereference(*(void __rcu __force **)&kn->priv);
+	if (!css || cgroup_is_dead(css->cgroup)) {
 		rcu_read_unlock();
 		mutex_unlock(&cgroup_mutex);
 		return -ENOENT;
 	}
+	cgrp = css->cgroup;
 	rcu_read_unlock();
 
 	css_task_iter_start(&cgrp->self, 0, &it);
@@ -851,7 +853,7 @@ void cgroup1_release_agent(struct work_struct *work)
 static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent,
 			  const char *new_name_str)
 {
-	struct cgroup *cgrp = kn->priv;
+	struct cgroup_subsys_state *css = kn->priv;
 	int ret;
 
 	if (kernfs_type(kn) != KERNFS_DIR)
@@ -871,7 +873,7 @@ static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent
 
 	ret = kernfs_rename(kn, new_parent, new_name_str);
 	if (!ret)
-		TRACE_CGROUP_PATH(rename, cgrp);
+		TRACE_CGROUP_PATH(rename, css->cgroup);
 
 	mutex_unlock(&cgroup_mutex);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9b035e728941..1fe4fee502ea 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -595,12 +595,13 @@ static void cgroup_get_live(struct cgroup *cgrp)
 
 struct cgroup_subsys_state *of_css(struct kernfs_open_file *of)
 {
-	struct cgroup *cgrp = of->kn->parent->priv;
+	struct cgroup_subsys_state *css = of->kn->parent->priv;
 	struct cftype *cft = of_cft(of);
 
-	/* FIXME this needs updating to lookup device-specific CSS */
-
 	/*
+	 * If the cft specifies a subsys and this is not a device file,
+	 * then lookup the css, otherwise it is already correct.
+	 *
 	 * This is open and unprotected implementation of cgroup_css().
 	 * seq_css() is only called from a kernfs file operation which has
 	 * an active reference on the file.  Because all the subsystem
@@ -608,10 +609,9 @@ struct cgroup_subsys_state *of_css(struct kernfs_open_file *of)
 	 * the matching css from the cgroup's subsys table is guaranteed to
 	 * be and stay valid until the enclosing operation is complete.
 	 */
-	if (cft->ss)
-		return rcu_dereference_raw(cgrp->subsys[cft->ss->id]);
-	else
-		return &cgrp->self;
+	if (cft->ss && !css->device)
+		css = rcu_dereference_raw(css->cgroup->subsys[cft->ss->id]);
+	return css;
 }
 EXPORT_SYMBOL_GPL(of_css);
 
@@ -1524,12 +1524,14 @@ static u16 cgroup_calc_subtree_ss_mask(u16 subtree_control, u16 this_ss_mask)
  */
 void cgroup_kn_unlock(struct kernfs_node *kn)
 {
+	struct cgroup_subsys_state *css;
 	struct cgroup *cgrp;
 
 	if (kernfs_type(kn) == KERNFS_DIR)
-		cgrp = kn->priv;
+		css = kn->priv;
 	else
-		cgrp = kn->parent->priv;
+		css = kn->parent->priv;
+	cgrp = css->cgroup;
 
 	mutex_unlock(&cgroup_mutex);
 
@@ -1556,12 +1558,14 @@ void cgroup_kn_unlock(struct kernfs_node *kn)
  */
 struct cgroup *cgroup_kn_lock_live(struct kernfs_node *kn, bool drain_offline)
 {
+	struct cgroup_subsys_state *css;
 	struct cgroup *cgrp;
 
 	if (kernfs_type(kn) == KERNFS_DIR)
-		cgrp = kn->priv;
+		css = kn->priv;
 	else
-		cgrp = kn->parent->priv;
+		css = kn->parent->priv;
+	cgrp = css->cgroup;
 
 	/*
 	 * We're gonna grab cgroup_mutex which nests outside kernfs
@@ -1652,7 +1656,7 @@ static int cgroup_device_mkdir(struct cgroup_subsys_state *css)
 	if (WARN_ON_ONCE(ret >= CGROUP_FILE_NAME_MAX))
 		return 0;
 
-	kn = kernfs_create_dir(cgrp->kn, name, cgrp->kn->mode, cgrp);
+	kn = kernfs_create_dir(cgrp->kn, name, cgrp->kn->mode, css);
 	if (IS_ERR(kn))
 		return PTR_ERR(kn);
 	css->device_kn = kn;
@@ -1662,7 +1666,7 @@ static int cgroup_device_mkdir(struct cgroup_subsys_state *css)
 		/* FIXME: prefix dev_name with bus_name for uniqueness? */
 		kn = kernfs_create_dir(css->device_kn,
 				       dev_name(device_css->device),
-				       cgrp->kn->mode, cgrp);
+				       cgrp->kn->mode, device_css);
 		if (IS_ERR(kn))
 			return PTR_ERR(kn);
 		/* FIXME: kernfs_get needed here? */
@@ -2025,7 +2029,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	root->kf_root = kernfs_create_root(kf_sops,
 					   KERNFS_ROOT_CREATE_DEACTIVATED |
 					   KERNFS_ROOT_SUPPORT_EXPORTOP,
-					   root_cgrp);
+					   &root_cgrp->self);
 	if (IS_ERR(root->kf_root)) {
 		ret = PTR_ERR(root->kf_root);
 		goto exit_root_id;
@@ -3579,9 +3583,9 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 				 size_t nbytes, loff_t off)
 {
 	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
-	struct cgroup *cgrp = of->kn->parent->priv;
+	struct cgroup_subsys_state *css = of_css(of);
 	struct cftype *cft = of->kn->priv;
-	struct cgroup_subsys_state *css;
+	struct cgroup *cgrp = css->cgroup;
 	int ret;
 
 	/*
@@ -3598,16 +3602,6 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 	if (cft->write)
 		return cft->write(of, buf, nbytes, off);
 
-	/*
-	 * kernfs guarantees that a file isn't deleted with operations in
-	 * flight, which means that the matching css is and stays alive and
-	 * doesn't need to be pinned.  The RCU locking is not necessary
-	 * either.  It's just for the convenience of using cgroup_css().
-	 */
-	rcu_read_lock();
-	css = cgroup_css(cgrp, cft->ss);
-	rcu_read_unlock();
-
 	if (cft->write_u64) {
 		unsigned long long v;
 		ret = kstrtoull(buf, 0, &v);
@@ -5262,7 +5256,7 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 	}
 
 	/* create the directory */
-	kn = kernfs_create_dir(parent->kn, name, mode, cgrp);
+	kn = kernfs_create_dir(parent->kn, name, mode, &cgrp->self);
 	if (IS_ERR(kn)) {
 		ret = PTR_ERR(kn);
 		goto out_destroy;
-- 
2.21.0

