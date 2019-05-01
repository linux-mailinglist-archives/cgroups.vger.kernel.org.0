Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E83108A8
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2019 16:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfEAODC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 May 2019 10:03:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:3043 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfEAODB (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 1 May 2019 10:03:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 07:03:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,417,1549958400"; 
   d="scan'208";a="145141390"
Received: from nperf12.hd.intel.com ([10.127.88.161])
  by fmsmga008.fm.intel.com with ESMTP; 01 May 2019 07:02:59 -0700
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
Subject: [RFC PATCH 1/5] cgroup: Add cgroup_subsys per-device registration framework
Date:   Wed,  1 May 2019 10:04:34 -0400
Message-Id: <20190501140438.9506-2-brian.welty@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501140438.9506-1-brian.welty@intel.com>
References: <20190501140438.9506-1-brian.welty@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In containerized or virtualized environments, there is desire to have
controls in place for resources that can be consumed by users of a GPU
device.  For this purpose, we extend control groups with a mechanism
for device drivers to register with cgroup subsystems.
Device drivers (GPU or other) are then able to reuse the existing cgroup
controls, instead of inventing similar ones.

A new framework is proposed to allow devices to register with existing
cgroup controllers, which creates per-device cgroup_subsys_state within
the cgroup.  This gives device drivers their own private cgroup controls
(such as memory limits or other parameters) to be applied to device
resources instead of host system resources.

It is exposed in cgroup filesystem as:
  mount/<cgroup_name>/<subsys_name>.devices/<dev_name>/
such as (for example):
  mount/<cgroup_name>/memory.devices/<dev_name>/memory.max
  mount/<cgroup_name>/memory.devices/<dev_name>/memory.current
  mount/<cgroup_name>/cpu.devices/<dev_name>/cpu.stat

The creation of above files is implemented in css_populate_dir() for
cgroup subsystems that have enabled per-device support.
Above files are created either at time of cgroup creation (for known
registered devices) or at the time of device driver registration of the
device, during cgroup_register_device.  cgroup_device_unregister will
remove files from all current cgroups.

Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org
Cc: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Brian Welty <brian.welty@intel.com>
---
 include/linux/cgroup-defs.h |  28 ++++
 include/linux/cgroup.h      |   3 +
 kernel/cgroup/cgroup.c      | 270 ++++++++++++++++++++++++++++++++++--
 3 files changed, 289 insertions(+), 12 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1c70803e9f77..aeaab420e349 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -162,6 +162,17 @@ struct cgroup_subsys_state {
 	struct work_struct destroy_work;
 	struct rcu_work destroy_rwork;
 
+	/*
+	 * Per-device state for devices registered with our subsys.
+	 * @device_css_idr stores pointer to per-device cgroup_subsys_state,
+	 * created when devices are associated with this css.
+	 * @device_kn is for creating .devices sub-directory within this cgroup
+	 * or for the per-device sub-directory (subsys.devices/<dev_name>).
+	 */
+	struct device *device;
+	struct idr device_css_idr;
+	struct kernfs_node *device_kn;
+
 	/*
 	 * PI: the parent css.	Placed here for cache proximity to following
 	 * fields of the containing structure.
@@ -589,6 +600,9 @@ struct cftype {
  */
 struct cgroup_subsys {
 	struct cgroup_subsys_state *(*css_alloc)(struct cgroup_subsys_state *parent_css);
+	struct cgroup_subsys_state *(*device_css_alloc)(struct device *device,
+							struct cgroup_subsys_state *cgroup_css,
+							struct cgroup_subsys_state *parent_device_css);
 	int (*css_online)(struct cgroup_subsys_state *css);
 	void (*css_offline)(struct cgroup_subsys_state *css);
 	void (*css_released)(struct cgroup_subsys_state *css);
@@ -636,6 +650,13 @@ struct cgroup_subsys {
 	 */
 	bool threaded:1;
 
+	/*
+	 * If %true, the controller supports device drivers to register
+	 * with this controller for cloning the cgroup functionality
+	 * into per-device cgroup state under <cgroup-name>.dev/<dev_name>/.
+	 */
+	bool allow_devices:1;
+
 	/*
 	 * If %false, this subsystem is properly hierarchical -
 	 * configuration, resource accounting and restriction on a parent
@@ -664,6 +685,13 @@ struct cgroup_subsys {
 	/* idr for css->id */
 	struct idr css_idr;
 
+	/*
+	 * IDR of registered devices, allows subsys_state to have state
+	 * for each device. Exposed as per-device entries in filesystem,
+	 * under <subsys_name>.device/<dev_name>/.
+	 */
+	struct idr device_idr;
+
 	/*
 	 * List of cftypes.  Each entry is the first entry of an array
 	 * terminated by zero length name.
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 81f58b4a5418..3531bf948703 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -116,6 +116,9 @@ int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry);
 int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 		     struct pid *pid, struct task_struct *tsk);
 
+int cgroup_device_register(struct cgroup_subsys *ss, struct device *dev,
+			   unsigned long *dev_id);
+void cgroup_device_unregister(struct cgroup_subsys *ss, unsigned long dev_id);
 void cgroup_fork(struct task_struct *p);
 extern int cgroup_can_fork(struct task_struct *p);
 extern void cgroup_cancel_fork(struct task_struct *p);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3f2b4bde0f9c..9b035e728941 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -598,6 +598,8 @@ struct cgroup_subsys_state *of_css(struct kernfs_open_file *of)
 	struct cgroup *cgrp = of->kn->parent->priv;
 	struct cftype *cft = of_cft(of);
 
+	/* FIXME this needs updating to lookup device-specific CSS */
+
 	/*
 	 * This is open and unprotected implementation of cgroup_css().
 	 * seq_css() is only called from a kernfs file operation which has
@@ -1583,14 +1585,15 @@ struct cgroup *cgroup_kn_lock_live(struct kernfs_node *kn, bool drain_offline)
 	return NULL;
 }
 
-static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
+static void cgroup_rm_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
+			   const struct cftype *cft)
 {
 	char name[CGROUP_FILE_NAME_MAX];
+	struct kernfs_node *dest_kn;
 
 	lockdep_assert_held(&cgroup_mutex);
 
 	if (cft->file_offset) {
-		struct cgroup_subsys_state *css = cgroup_css(cgrp, cft->ss);
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
 		spin_lock_irq(&cgroup_file_kn_lock);
@@ -1600,6 +1603,7 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
 		del_timer_sync(&cfile->notify_timer);
 	}
 
+	dest_kn = (css->device) ? css->device_kn : cgrp->kn;
 	kernfs_remove_by_name(cgrp->kn, cgroup_file_name(cgrp, cft, name));
 }
 
@@ -1630,10 +1634,49 @@ static void css_clear_dir(struct cgroup_subsys_state *css)
 	}
 }
 
+static int cgroup_device_mkdir(struct cgroup_subsys_state *css)
+{
+	struct cgroup_subsys_state *device_css;
+	struct cgroup *cgrp = css->cgroup;
+	char name[CGROUP_FILE_NAME_MAX];
+	struct kernfs_node *kn;
+	int ret, dev_id;
+
+	/* create subsys.device only if enabled in subsys and non-root cgroup */
+	if (!css->ss->allow_devices || !cgroup_parent(cgrp))
+		return 0;
+
+	ret = strlcpy(name, css->ss->name, CGROUP_FILE_NAME_MAX);
+	ret += strlcat(name, ".device", CGROUP_FILE_NAME_MAX);
+	/* treat as non-error if truncation due to subsys name */
+	if (WARN_ON_ONCE(ret >= CGROUP_FILE_NAME_MAX))
+		return 0;
+
+	kn = kernfs_create_dir(cgrp->kn, name, cgrp->kn->mode, cgrp);
+	if (IS_ERR(kn))
+		return PTR_ERR(kn);
+	css->device_kn = kn;
+
+	/* create subdirectory per each registered device */
+	idr_for_each_entry(&css->device_css_idr, device_css, dev_id) {
+		/* FIXME: prefix dev_name with bus_name for uniqueness? */
+		kn = kernfs_create_dir(css->device_kn,
+				       dev_name(device_css->device),
+				       cgrp->kn->mode, cgrp);
+		if (IS_ERR(kn))
+			return PTR_ERR(kn);
+		/* FIXME: kernfs_get needed here? */
+		device_css->device_kn = kn;
+	}
+
+	return 0;
+}
+
 /**
  * css_populate_dir - create subsys files in a cgroup directory
  * @css: target css
  *
+ * Creates per-device directories if enabled in subsys.
  * On failure, no file is added.
  */
 static int css_populate_dir(struct cgroup_subsys_state *css)
@@ -1655,6 +1698,10 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
 		if (ret < 0)
 			return ret;
 	} else {
+		ret = cgroup_device_mkdir(css);
+		if (ret < 0)
+			return ret;
+
 		list_for_each_entry(cfts, &css->ss->cfts, node) {
 			ret = cgroup_addrm_files(css, cgrp, cfts, true);
 			if (ret < 0) {
@@ -1673,6 +1720,7 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
 			break;
 		cgroup_addrm_files(css, cgrp, cfts, false);
 	}
+	/* FIXME: per-device files will be removed by kernfs_destroy_root? */
 	return ret;
 }
 
@@ -3665,14 +3713,15 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 			   struct cftype *cft)
 {
 	char name[CGROUP_FILE_NAME_MAX];
-	struct kernfs_node *kn;
+	struct kernfs_node *kn, *dest_kn;
 	struct lock_class_key *key = NULL;
 	int ret;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	key = &cft->lockdep_key;
 #endif
-	kn = __kernfs_create_file(cgrp->kn, cgroup_file_name(cgrp, cft, name),
+	dest_kn = (css->device) ? css->device_kn : cgrp->kn;
+	kn = __kernfs_create_file(dest_kn, cgroup_file_name(cgrp, cft, name),
 				  cgroup_file_mode(cft),
 				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 				  0, cft->kf_ops, cft,
@@ -3709,15 +3758,13 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
  * Depending on @is_add, add or remove files defined by @cfts on @cgrp.
  * For removals, this function never fails.
  */
-static int cgroup_addrm_files(struct cgroup_subsys_state *css,
-			      struct cgroup *cgrp, struct cftype cfts[],
-			      bool is_add)
+static int __cgroup_addrm_files(struct cgroup_subsys_state *css,
+				struct cgroup *cgrp, struct cftype cfts[],
+				bool is_add)
 {
 	struct cftype *cft, *cft_end = NULL;
 	int ret = 0;
 
-	lockdep_assert_held(&cgroup_mutex);
-
 restart:
 	for (cft = cfts; cft != cft_end && cft->name[0] != '\0'; cft++) {
 		/* does cft->flags tell us to skip this file on @cgrp? */
@@ -3741,12 +3788,43 @@ static int cgroup_addrm_files(struct cgroup_subsys_state *css,
 				goto restart;
 			}
 		} else {
-			cgroup_rm_file(cgrp, cft);
+			cgroup_rm_file(css, cgrp, cft);
 		}
 	}
 	return ret;
 }
 
+static int cgroup_addrm_files(struct cgroup_subsys_state *css,
+			      struct cgroup *cgrp, struct cftype cfts[],
+			      bool is_add)
+{
+	struct cgroup_subsys_state *device_css, *device_css_end = NULL;
+	int dev_id, ret, err = 0;
+
+	lockdep_assert_held(&cgroup_mutex);
+restart:
+	ret = __cgroup_addrm_files(css, cgrp, cfts, is_add);
+	if (ret)
+		return ret;
+
+	/* repeat addrm for each device */
+	idr_for_each_entry(&css->device_css_idr, device_css, dev_id) {
+		if (device_css == device_css_end)
+			break;
+		ret = __cgroup_addrm_files(device_css, cgrp, cfts, is_add);
+		if (ret && !is_add) {
+			return ret;
+		} else if (ret) {
+			is_add = false;
+			device_css_end = device_css;
+			err = ret;
+			goto restart;
+		}
+	}
+
+	return err;
+}
+
 static int cgroup_apply_cftypes(struct cftype *cfts, bool is_add)
 {
 	struct cgroup_subsys *ss = cfts[0].ss;
@@ -4711,9 +4789,14 @@ static void css_free_rwork_fn(struct work_struct *work)
 
 	if (ss) {
 		/* css free path */
-		struct cgroup_subsys_state *parent = css->parent;
-		int id = css->id;
+		struct cgroup_subsys_state *device_css, *parent = css->parent;
+		int dev_id, id = css->id;
 
+		idr_for_each_entry(&css->device_css_idr, device_css, dev_id) {
+			css_put(device_css->parent);
+			ss->css_free(device_css);
+		}
+		idr_destroy(&css->device_css_idr);
 		ss->css_free(css);
 		cgroup_idr_remove(&ss->css_idr, id);
 		cgroup_put(cgrp);
@@ -4833,6 +4916,7 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 	INIT_LIST_HEAD(&css->rstat_css_node);
 	css->serial_nr = css_serial_nr_next++;
 	atomic_set(&css->online_cnt, 0);
+	idr_init(&css->device_css_idr);
 
 	if (cgroup_parent(cgrp)) {
 		css->parent = cgroup_css(cgroup_parent(cgrp), ss);
@@ -4885,6 +4969,79 @@ static void offline_css(struct cgroup_subsys_state *css)
 	wake_up_all(&css->cgroup->offline_waitq);
 }
 
+/*
+ * Associates a device with a css.
+ * Create a new device-specific css and insert into @css->device_css_idr.
+ * Acquires a references on @css, which is released when the device is
+ * dissociated with this css.
+ */
+static int cgroup_add_device(struct cgroup_subsys_state *css,
+			     struct device *dev, int dev_id)
+{
+	struct cgroup_subsys *ss = css->ss;
+	struct cgroup_subsys_state *dev_css, *dev_parent_css;
+	int err;
+
+	lockdep_assert_held(&cgroup_mutex);
+
+	/* don't add devices at root cgroup level */
+	if (!css->parent)
+		return -EINVAL;
+
+	dev_parent_css = idr_find(&css->parent->device_css_idr, dev_id);
+	dev_css = ss->device_css_alloc(dev, css, dev_parent_css);
+	if (IS_ERR_OR_NULL(dev_css)) {
+		if (!dev_css)
+			return -ENOMEM;
+		if (IS_ERR(dev_css))
+			return PTR_ERR(dev_css);
+	}
+
+	/* store per-device css pointer in the cgroup's css */
+	err = idr_alloc(&css->device_css_idr, dev_css, dev_id,
+			dev_id + 1, GFP_KERNEL);
+	if (err < 0) {
+		ss->css_free(dev_css);
+		return err;
+	}
+
+	dev_css->device = dev;
+	dev_css->parent = dev_parent_css;
+	/*
+	 * subsys per-device support is allowed to access cgroup subsys_state
+	 * using cgroup.self.  Increment reference on css so it remains valid
+	 * as long as device is associated with it.
+	 */
+	dev_css->cgroup = css->cgroup;
+	dev_css->ss = css->ss;
+	css_get(css);
+
+	return 0;
+}
+
+/*
+ * For a new cgroup css, create device-specific css for each device which
+ * which has registered itself with the subsys.
+ */
+static int cgroup_add_devices(struct cgroup_subsys_state *css)
+{
+	struct device *dev;
+	int dev_id, err = 0;
+
+	/* ignore adding devices for root cgroups */
+	if (!css->parent)
+		return 0;
+
+	/* create per-device css for each associated device */
+	idr_for_each_entry(&css->ss->device_idr, dev, dev_id) {
+		err = cgroup_add_device(css, dev, dev_id);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
 /**
  * css_create - create a cgroup_subsys_state
  * @cgrp: the cgroup new css will be associated with
@@ -4921,6 +5078,10 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 		goto err_free_css;
 	css->id = err;
 
+	err = cgroup_add_devices(css);
+	if (err)
+		goto err_free_css;
+
 	/* @css is ready to be brought online now, make it visible */
 	list_add_tail_rcu(&css->sibling, &parent_css->children);
 	cgroup_idr_replace(&ss->css_idr, css, css->id);
@@ -5337,6 +5498,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 	mutex_lock(&cgroup_mutex);
 
 	idr_init(&ss->css_idr);
+	idr_init(&ss->device_idr);
 	INIT_LIST_HEAD(&ss->cfts);
 
 	/* Create the root cgroup state for this subsystem */
@@ -5637,6 +5799,90 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 	return retval;
 }
 
+void cgroup_device_unregister(struct cgroup_subsys *ss, unsigned long dev_id)
+{
+	struct cgroup_subsys_state *css, *device_css;
+	int css_id;
+
+	if (!ss->allow_devices)
+		return;
+
+	mutex_lock(&cgroup_mutex);
+	idr_for_each_entry(&ss->css_idr, css, css_id) {
+		WARN_ON(css->device);
+		if (!css->parent || css->device)
+			continue;
+		device_css = idr_remove(&css->device_css_idr, dev_id);
+		if (device_css) {
+			/* FIXME kernfs_get/put needed to make safe? */
+			if (device_css->device_kn)
+				kernfs_remove(device_css->device_kn);
+			css_put(device_css->parent);
+			ss->css_free(device_css);
+		}
+	}
+	idr_remove(&ss->device_idr, dev_id);
+	mutex_unlock(&cgroup_mutex);
+}
+
+/**
+ * cgroup_device_register - associate a struct device with @ss
+ * @ss: the subsystem of interest
+ * @dev: the device of interest
+ * @dev_id: index into @ss idr returned
+ *
+ * Insert @dev into set of devices to be associated with this subsystem.
+ * As cgroups are created, subdirectories <subsys_name>.<device>/<dev-name/
+ * will be created within the cgroup's filesystem.  Device drivers can then
+ * have this subsystem's controls applied to per-device resources by use of
+ * a private cgroup_subsys_state.
+ */
+int cgroup_device_register(struct cgroup_subsys *ss, struct device *dev,
+			   unsigned long *dev_id)
+{
+	struct cgroup_subsys_state *css;
+	int css_id, id, err = 0;
+
+	if (!ss->allow_devices)
+		return -EACCES;
+
+	mutex_lock(&cgroup_mutex);
+
+	id = idr_alloc_cyclic(&ss->device_idr, dev, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		mutex_unlock(&cgroup_mutex);
+		return id;
+	}
+
+	idr_for_each_entry(&ss->css_idr, css, css_id) {
+		WARN_ON(css->device);
+		if (!css->parent || css->device)
+			continue;
+		err = cgroup_add_device(css, dev, id);
+		if (err)
+			break;
+
+		if (css_visible(css)) {
+			/* FIXME - something more lightweight can be done? */
+			css_clear_dir(css);
+			/* FIXME kernfs_get/put needed to make safe? */
+			kernfs_remove(css->device_kn);
+			err = css_populate_dir(css);
+			if (err)
+				/* FIXME handle error case */
+				err = 0;
+			else
+				kernfs_activate(css->cgroup->kn);
+		}
+	}
+
+	if (!err)
+		*dev_id = id;
+	mutex_unlock(&cgroup_mutex);
+
+	return err;
+}
+
 /**
  * cgroup_fork - initialize cgroup related fields during copy_process()
  * @child: pointer to task_struct of forking parent process.
-- 
2.21.0

