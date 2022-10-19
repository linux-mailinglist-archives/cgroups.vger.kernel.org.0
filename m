Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1C604EC7
	for <lists+cgroups@lfdr.de>; Wed, 19 Oct 2022 19:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiJSRd7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Oct 2022 13:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiJSRdq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Oct 2022 13:33:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22321D3A5C;
        Wed, 19 Oct 2022 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666200818; x=1697736818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d4D/BlXX4NlKxFrkTxlp93219A7CroFmytaEV3UfKfI=;
  b=ardjVYFgNejJcnFCwUkXk2WXx/ZzzFLgnF16WncmTCwYKJDH1GkqsQE5
   OsUe4puFBqER4FYvPq21yMhiIa6JYmQZb2YGNGMMw/Jl3TTGHQUzmrm4o
   mtKhgcAuzroqgY94qmZhoYeedxNlyBh9qVeroQk5hzxlXyP9yvucrVVdH
   67V1ASBVaeCLWKLFJLzcRiiRTcyjOj0wvhEYyzyDZaz2Q4tLTomJnVat5
   ZJ1D19TsTLtin9qOTX8IS/vYjAminhSoO1390xSmorlJLPidDt0v+AYHk
   1PZSK4LI7/jdYYamYBQpHdS/BXHgUIlQ8UEfPtAMPNEdqoAq1S0t8FhBB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="306474378"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="306474378"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:33:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607204741"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607204741"
Received: from mjmcener-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.213.233.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:33:33 -0700
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [RFC 05/17] drm: Connect priority updates to drm core
Date:   Wed, 19 Oct 2022 18:32:42 +0100
Message-Id: <20221019173254.3361334-6-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com>
References: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

On priority updates, drm cgroup controller is made walk all the processes
belonging to the group being updated, and notifies the drm core of them
via a new helper.

DRM core itself stores the current effective drm cgroup priority in
struct drm_file, while individual drivers can also register an optional
hook to be called at the same time, via struct drm_cgroup_ops which can be
provided as part of struct drm_driver used at driver registration time.

DRM cgroup controller on the other hand exports a new helper which the drm
core uses at client registration time in order to query to current drm
cgroup effective priority.

This establishes a two way communication channel between the drm cgroup
controller and the drm core and hence drm core module now has to be built
into the kernel.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  2 +
 drivers/gpu/drm/Kconfig                 |  1 +
 drivers/gpu/drm/drm_cgroup.c            | 56 +++++++++++++++++
 drivers/gpu/drm/drm_file.c              |  4 ++
 include/drm/drm_clients.h               |  3 +
 include/drm/drm_drv.h                   | 47 ++++++++++++++
 include/drm/drm_file.h                  | 10 +++
 include/linux/cgroup_drm.h              |  4 ++
 init/Kconfig                            |  1 +
 kernel/cgroup/drm.c                     | 82 ++++++++++++++++++++++++-
 10 files changed, 209 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0a6d97c83ea4..1f3cca4e2572 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2444,6 +2444,8 @@ DRM static priority interface files
 	One of:
 	 1) And integer representing the minimum number of discrete priority
 	    levels for the whole group.
+	    Optionally followed by an asterisk ('*') indicating some DRM clients
+	    in the group support more than the minimum number.
 	 2) '0'- indicating one or more DRM clients in the group has no support
 	    for static priority control.
 	 3) 'n/a' - when there are no DRM clients in the configured group.
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 34f5a092c99e..8f3c169ced10 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -7,6 +7,7 @@
 #
 menuconfig DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
+	default y if CGROUP_DRM=y
 	depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
 	select DRM_NOMODESET
 	select DRM_PANEL_ORIENTATION_QUIRKS
diff --git a/drivers/gpu/drm/drm_cgroup.c b/drivers/gpu/drm/drm_cgroup.c
index 9e9caeb0aa87..0fbb88f08cef 100644
--- a/drivers/gpu/drm/drm_cgroup.c
+++ b/drivers/gpu/drm/drm_cgroup.c
@@ -65,3 +65,59 @@ int drm_clients_open(struct drm_file *file_priv)
 
 	return 0;
 }
+
+unsigned int drm_pid_priority_levels(struct pid *pid, bool *non_uniform)
+{
+	unsigned int min_levels = UINT_MAX;
+	struct drm_pid_clients *clients;
+
+	*non_uniform = false;
+
+	rcu_read_lock();
+	clients = xa_load(&drm_pid_clients, (unsigned long)pid);
+	if (clients) {
+		struct drm_file *fpriv;
+
+		list_for_each_entry_rcu(fpriv, &clients->file_list, clink) {
+			const struct drm_cgroup_ops *cg_ops =
+				fpriv->minor->dev->driver->cg_ops;
+			unsigned int l;
+
+			if (cg_ops && cg_ops->priority_levels)
+				l = cg_ops->priority_levels(fpriv);
+			else
+				l = 0;
+
+			if (min_levels != UINT_MAX && l != min_levels)
+				*non_uniform = true;
+			if (l < min_levels)
+				min_levels = l;
+		}
+	}
+	rcu_read_unlock();
+
+	return min_levels;
+}
+EXPORT_SYMBOL_GPL(drm_pid_priority_levels);
+
+void drm_pid_update_priority(struct pid *pid, int priority)
+{
+	struct drm_pid_clients *clients;
+
+	rcu_read_lock();
+	clients = xa_load(&drm_pid_clients, (unsigned long)pid);
+	if (clients) {
+		struct drm_file *fpriv;
+
+		list_for_each_entry_rcu(fpriv, &clients->file_list, clink) {
+			const struct drm_cgroup_ops *cg_ops =
+				fpriv->minor->dev->driver->cg_ops;
+
+			fpriv->drm_cgroup_priority = priority;
+			if (cg_ops && cg_ops->update_priority)
+				cg_ops->update_priority(fpriv, priority);
+		}
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(drm_pid_update_priority);
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index ce58d5c513db..38eb6003e74d 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -32,6 +32,7 @@
  */
 
 #include <linux/anon_inodes.h>
+#include <linux/cgroup_drm.h>
 #include <linux/dma-fence.h>
 #include <linux/file.h>
 #include <linux/module.h>
@@ -359,6 +360,9 @@ static int drm_open_helper(struct file *filp, struct drm_minor *minor)
 	filp->f_mode |= FMODE_UNSIGNED_OFFSET;
 	priv->filp = filp;
 
+	priv->drm_cgroup_priority =
+		drmcgroup_lookup_effective_priority(current);
+
 	mutex_lock(&dev->filelist_mutex);
 	ret = drm_clients_open(priv);
 	if (ret)
diff --git a/include/drm/drm_clients.h b/include/drm/drm_clients.h
index 4ae553a03d1e..10d21138f7af 100644
--- a/include/drm/drm_clients.h
+++ b/include/drm/drm_clients.h
@@ -28,4 +28,7 @@ static inline int drm_clients_open(struct drm_file *file_priv)
 }
 #endif
 
+unsigned int drm_pid_priority_levels(struct pid *pid, bool *non_uniform);
+void drm_pid_update_priority(struct pid *pid, int priority);
+
 #endif
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index f6159acb8856..2371d73e12cf 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -148,6 +148,43 @@ enum drm_driver_feature {
 	DRIVER_KMS_LEGACY_CONTEXT	= BIT(31),
 };
 
+/**
+ * struct drm_cgroup_ops
+ *
+ * This structure contains a number of callbacks that drivers can provide if
+ * they are able to support one or more of the functionalities implemented by
+ * the DRM cgroup controller.
+ */
+struct drm_cgroup_ops {
+	/**
+	 * @priority_levels:
+	 *
+	 * Returns the discrete number of priority levels supported by the DRM
+	 * driver owning this client.
+	 *
+	 * The value is used by the DRM core when informing the DRM cgroup
+	 * controller on the scheduling priority capability of a group of
+	 * clients.
+	 *
+	 * If the callback is not implemented no support for scheduling priority
+	 * is assumed and reported as such.
+	 */
+	unsigned int (*priority_levels) (struct drm_file *);
+
+	/**
+	 * @update_priority:
+	 *
+	 * Optional callback used by the DRM core for informing individual
+	 * drivers of DRM cgroup priority changes.
+	 *
+	 * If not implemented drivers are still able to access the most recent
+	 * priority via the drm_file->drm_cgroup_priority field. Therefore the
+	 * main purpose of the callback is for drivers which are able to adjust
+	 * priorities of already running workloads.
+	 */
+	void (*update_priority) (struct drm_file *, int priority);
+};
+
 /**
  * struct drm_driver - DRM driver structure
  *
@@ -459,6 +496,16 @@ struct drm_driver {
 	 */
 	const struct file_operations *fops;
 
+#ifdef CONFIG_CGROUP_DRM
+	/**
+	 * @cg_ops:
+	 *
+	 * Optional pointer to driver callbacks facilitating integration with
+	 * the DRM cgroup controller.
+	 */
+	const struct drm_cgroup_ops *cg_ops;
+#endif
+
 #ifdef CONFIG_DRM_LEGACY
 	/* Everything below here is for legacy driver, never use! */
 	/* private: */
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 0965eb111f24..a4360e28e2db 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -223,6 +223,16 @@ struct drm_file {
 	 */
 	bool is_master;
 
+#ifdef CONFIG_CGROUP_DRM
+	/**
+	 * @drm_cgroup_priority:
+	 *
+	 * Last known DRM cgroup priority is stored here by the DRM code when
+	 * informed of changes by the cgroup controller.
+	 */
+	int drm_cgroup_priority;
+#endif
+
 	/**
 	 * @master:
 	 *
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index a59792ccb550..66063b4708e8 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -6,8 +6,12 @@
 #ifndef _CGROUP_DRM_H
 #define _CGROUP_DRM_H
 
+struct task_struct;
+
 #define DRM_CGROUP_PRIORITY_MIN	(-10000)
 #define DRM_CGROUP_PRIORITY_DEF	(0)
 #define DRM_CGROUP_PRIORITY_MAX	(10000)
 
+int drmcgroup_lookup_effective_priority(struct task_struct *task);
+
 #endif	/* _CGROUP_DRM_H */
diff --git a/init/Kconfig b/init/Kconfig
index 6dd7faca7749..cfc7a1f2634c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1089,6 +1089,7 @@ config CGROUP_RDMA
 
 config CGROUP_DRM
 	bool "DRM controller"
+	select DRM
 	help
 	  Provides the DRM subsystem controller.
 
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 2350e1f8a48a..01954c3a2087 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -10,6 +10,8 @@
 #include <linux/mutex.h>
 #include <linux/sched.h>
 
+#include <drm/drm_clients.h>
+
 struct drm_cgroup_state {
 	struct cgroup_subsys_state css;
 
@@ -25,9 +27,52 @@ css_to_drmcs(struct cgroup_subsys_state *css)
 	return container_of(css, struct drm_cgroup_state, css);
 }
 
+static inline struct drm_cgroup_state *get_task_drmcs(struct task_struct *task)
+{
+	return css_to_drmcs(task_get_css(task, drm_cgrp_id));
+}
+
+int drmcgroup_lookup_effective_priority(struct task_struct *task)
+{
+	struct drm_cgroup_state *drmcs = get_task_drmcs(task);
+	int prio = drmcs->effective_priority;
+
+	css_put(&drmcs->css);
+
+	return prio;
+}
+EXPORT_SYMBOL_GPL(drmcgroup_lookup_effective_priority);
+
 static int drmcs_show_priority_levels(struct seq_file *sf, void *v)
 {
-	seq_printf(sf, "%u\n", 0);
+	struct cgroup *cgrp = seq_css(sf)->cgroup;
+	unsigned int min_levels = UINT_MAX;
+	bool non_uniform = false;
+	struct task_struct *task;
+	struct css_task_iter it;
+
+	css_task_iter_start(&cgrp->self,
+			    CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
+	while ((task = css_task_iter_next(&it))) {
+		unsigned int l;
+		bool nu;
+
+		/* Ignore kernel threads here. */
+		if (task->flags & PF_KTHREAD)
+			continue;
+
+		l = drm_pid_priority_levels(task_pid(task), &nu);
+		if (nu || (min_levels != UINT_MAX && l != min_levels))
+			non_uniform = true;
+		if (l < min_levels)
+			min_levels = l;
+	}
+	css_task_iter_end(&it);
+
+	if (min_levels != UINT_MAX)
+		seq_printf(sf, "%u%s\n", min_levels, non_uniform ? "*" : "");
+	else
+		seq_puts(sf, "n/a\n");
 
 	return 0;
 }
@@ -49,6 +94,24 @@ drmcs_read_priority(struct cgroup_subsys_state *css, struct cftype *cft)
 	return drmcs->priority;
 }
 
+static void update_drm_priority(struct drm_cgroup_state *drmcs)
+{
+	struct cgroup *cgrp = drmcs->css.cgroup;
+	struct task_struct *task;
+	struct css_task_iter it;
+
+	css_task_iter_start(&cgrp->self,
+			    CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
+	while ((task = css_task_iter_next(&it))) {
+		/* Ignore kernel threads here. */
+		if (task->flags & PF_KTHREAD)
+			continue;
+		drm_pid_update_priority(task_pid(task),
+					drmcs->effective_priority);
+	}
+	css_task_iter_end(&it);
+}
+
 static void update_priority(struct drm_cgroup_state *drmcs, int priority)
 {
 	struct cgroup_subsys_state *node;
@@ -74,6 +137,8 @@ static void update_priority(struct drm_cgroup_state *drmcs, int priority)
 			clamp(pprio + dnode->priority,
 			      DRM_CGROUP_PRIORITY_MIN,
 			      DRM_CGROUP_PRIORITY_MAX);
+
+		update_drm_priority(dnode);
 	}
 	rcu_read_unlock();
 }
@@ -114,6 +179,20 @@ static void drmcs_free(struct cgroup_subsys_state *css)
 	kfree(css_to_drmcs(css));
 }
 
+static void drmcs_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *css;
+	struct task_struct *task;
+
+	/*
+	 * As processes are assigned to groups we need to notify them of the
+	 * current priority.
+	 */
+	cgroup_taskset_for_each(task, css, tset)
+		drm_pid_update_priority(task_pid(task),
+					css_to_drmcs(css)->effective_priority);
+}
+
 static struct drm_cgroup_state root_drmcs = {
 	.priority = DRM_CGROUP_PRIORITY_DEF,
 	.effective_priority = DRM_CGROUP_PRIORITY_DEF,
@@ -158,6 +237,7 @@ struct cgroup_subsys drm_cgrp_subsys = {
 	.css_alloc	= drmcs_alloc,
 	.css_free	= drmcs_free,
 	.css_online	= drmcs_online,
+	.attach		= drmcs_attach,
 	.early_init	= false,
 	.legacy_cftypes	= files,
 	.dfl_cftypes	= files,
-- 
2.34.1

