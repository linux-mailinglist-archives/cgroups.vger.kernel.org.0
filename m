Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D22A622FD3
	for <lists+cgroups@lfdr.de>; Wed,  9 Nov 2022 17:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiKIQM0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Nov 2022 11:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiKIQMT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Nov 2022 11:12:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599D2220FA;
        Wed,  9 Nov 2022 08:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668010337; x=1699546337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DOi4RMupNEjpYyK4WovQ8kG/iXKjxHECtSroc0kXvAE=;
  b=CtuIL09I139syLEmVYuiqfQuO8R7ReTxij1KU7fqkZ2DseuIKLe+IXHU
   RH44Ltk2t0Y6ZGQS+cxmIXC6pn4DMkoK9QX5YVJlzCvDUs7F19ePIEJGF
   soGT3OyZ4zreF1ODbOEPJ63dsKtYMiwkk7/GCCHUtxkY9hf57JPDOx4K/
   ifbiMGTNI9nOLbP6GfUEHDu87A76he+uL6ZVPEvMsvWX+a34l1wuULZuu
   X/HXlXZwr7E3PEg4hDw8IBVFarQvkIs8uwuKhoxrxe5RLwwOSzGOP4AZr
   rUZdc+6dNOsV1Lz9YBqYkhkUSMyqEN7DCCilJJgZa6MrKYByZ31c4x8w0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312181345"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="312181345"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="811684480"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="811684480"
Received: from smurnane-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.196.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:13 -0800
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
Subject: [RFC 05/13] drm/cgroup: Track clients per owning process
Date:   Wed,  9 Nov 2022 16:11:33 +0000
Message-Id: <20221109161141.2987173-6-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
References: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

To enable propagation of settings from the cgroup drm controller to drm we
need to start tracking which processes own which drm clients.

Implement that by tracking the struct pid pointer of the owning process in
a new XArray, pointing to a structure containing a list of associated
struct drm_file pointers.

Clients are added and removed under the filelist mutex and RCU list
operations are used below it to allow for lockless lookup.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/Makefile     |   1 +
 drivers/gpu/drm/drm_cgroup.c | 123 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_file.c   |  21 ++++--
 include/drm/drm_clients.h    |  44 +++++++++++++
 include/drm/drm_file.h       |   4 ++
 5 files changed, 189 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_cgroup.c
 create mode 100644 include/drm/drm_clients.h

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index c44a54cadb61..4495dda2a720 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -59,6 +59,7 @@ drm-$(CONFIG_DRM_LEGACY) += \
 	drm_scatter.o \
 	drm_vm.o
 drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
+drm-$(CONFIG_CGROUP_DRM) += drm_cgroup.o
 drm-$(CONFIG_COMPAT) += drm_ioc32.o
 drm-$(CONFIG_DRM_PANEL) += drm_panel.o
 drm-$(CONFIG_OF) += drm_of.o
diff --git a/drivers/gpu/drm/drm_cgroup.c b/drivers/gpu/drm/drm_cgroup.c
new file mode 100644
index 000000000000..56aa8303974a
--- /dev/null
+++ b/drivers/gpu/drm/drm_cgroup.c
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2022 Intel Corporation
+ */
+
+#include <drm/drm_drv.h>
+#include <drm/drm_clients.h>
+
+static DEFINE_XARRAY(drm_pid_clients);
+
+static void
+__del_clients(struct drm_pid_clients *clients,
+	      struct drm_file *file_priv,
+	      unsigned long pid)
+{
+	list_del_rcu(&file_priv->clink);
+	if (atomic_dec_and_test(&clients->num)) {
+		xa_erase(&drm_pid_clients, pid);
+		kfree_rcu(clients, rcu);
+	}
+}
+
+void drm_clients_close(struct drm_file *file_priv)
+{
+	struct drm_device *dev = file_priv->minor->dev;
+	struct drm_pid_clients *clients;
+	struct pid *pid;
+
+	lockdep_assert_held(&dev->filelist_mutex);
+
+	pid = rcu_access_pointer(file_priv->pid);
+	clients = xa_load(&drm_pid_clients, (unsigned long)pid);
+	if (WARN_ON_ONCE(!clients))
+		return;
+
+	__del_clients(clients, file_priv, (unsigned long)pid);
+}
+
+static struct drm_pid_clients *__alloc_clients(void)
+{
+	struct drm_pid_clients *clients;
+
+	clients = kmalloc(sizeof(*clients), GFP_KERNEL);
+	if (clients) {
+		atomic_set(&clients->num, 0);
+		INIT_LIST_HEAD(&clients->file_list);
+		init_rcu_head(&clients->rcu);
+	}
+
+	return clients;
+}
+
+int drm_clients_open(struct drm_file *file_priv)
+{
+	struct drm_device *dev = file_priv->minor->dev;
+	struct drm_pid_clients *clients;
+	bool new_client = false;
+	unsigned long pid;
+
+	lockdep_assert_held(&dev->filelist_mutex);
+
+	pid = (unsigned long)rcu_access_pointer(file_priv->pid);
+	clients = xa_load(&drm_pid_clients, pid);
+	if (!clients) {
+		clients = __alloc_clients();
+		if (!clients)
+			return -ENOMEM;
+		new_client = true;
+	}
+	atomic_inc(&clients->num);
+	list_add_tail_rcu(&file_priv->clink, &clients->file_list);
+	if (new_client) {
+		void *xret;
+
+		xret = xa_store(&drm_pid_clients, pid, clients, GFP_KERNEL);
+		if (xa_err(xret)) {
+			list_del_init(&file_priv->clink);
+			kfree(clients);
+			return PTR_ERR(clients);
+		}
+	}
+
+	return 0;
+}
+
+void
+drm_clients_migrate(struct drm_file *file_priv,
+		    unsigned long old,
+		    unsigned long new)
+{
+	struct drm_device *dev = file_priv->minor->dev;
+	struct drm_pid_clients *existing_clients;
+	struct drm_pid_clients *clients;
+
+	lockdep_assert_held(&dev->filelist_mutex);
+
+	existing_clients = xa_load(&drm_pid_clients, new);
+	clients = xa_load(&drm_pid_clients, old);
+
+	if (WARN_ON_ONCE(!clients))
+		return;
+	else if (WARN_ON_ONCE(clients == existing_clients))
+		return;
+
+	__del_clients(clients, file_priv, old);
+
+	if (!existing_clients) {
+		void *xret;
+
+		clients = __alloc_clients();
+		if (WARN_ON(!clients))
+			return;
+
+		xret = xa_store(&drm_pid_clients, new, clients, GFP_KERNEL);
+		if (WARN_ON(xa_err(xret)))
+			return;
+	} else {
+		clients = existing_clients;
+	}
+
+	atomic_inc(&clients->num);
+	list_add_tail_rcu(&file_priv->clink, &clients->file_list);
+}
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 4f5cff5c0bea..16ca5b88f414 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 
 #include <drm/drm_client.h>
+#include <drm/drm_clients.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
 #include <drm/drm_print.h>
@@ -298,6 +299,7 @@ static void drm_close_helper(struct file *filp)
 
 	mutex_lock(&dev->filelist_mutex);
 	list_del(&file_priv->lhead);
+	drm_clients_close(file_priv);
 	mutex_unlock(&dev->filelist_mutex);
 
 	drm_file_free(file_priv);
@@ -349,10 +351,8 @@ static int drm_open_helper(struct file *filp, struct drm_minor *minor)
 
 	if (drm_is_primary_client(priv)) {
 		ret = drm_master_open(priv);
-		if (ret) {
-			drm_file_free(priv);
-			return ret;
-		}
+		if (ret)
+			goto err_free;
 	}
 
 	filp->private_data = priv;
@@ -360,6 +360,9 @@ static int drm_open_helper(struct file *filp, struct drm_minor *minor)
 	priv->filp = filp;
 
 	mutex_lock(&dev->filelist_mutex);
+	ret = drm_clients_open(priv);
+	if (ret)
+		goto err_unlock;
 	list_add(&priv->lhead, &dev->filelist);
 	mutex_unlock(&dev->filelist_mutex);
 
@@ -387,6 +390,13 @@ static int drm_open_helper(struct file *filp, struct drm_minor *minor)
 #endif
 
 	return 0;
+
+err_unlock:
+	mutex_unlock(&dev->filelist_mutex);
+err_free:
+	drm_file_free(priv);
+
+	return ret;
 }
 
 /**
@@ -523,6 +533,9 @@ void drm_file_update_pid(struct drm_file *filp)
 	dev = filp->minor->dev;
 	mutex_lock(&dev->filelist_mutex);
 	old = rcu_replace_pointer(filp->pid, pid, 1);
+	if (pid != old)
+		drm_clients_migrate(filp,
+				    (unsigned long)old, (unsigned long)pid);
 	mutex_unlock(&dev->filelist_mutex);
 
 	if (pid != old) {
diff --git a/include/drm/drm_clients.h b/include/drm/drm_clients.h
new file mode 100644
index 000000000000..fbb8cffdf7a9
--- /dev/null
+++ b/include/drm/drm_clients.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2022 Intel Corporation
+ */
+
+#ifndef _DRM_CLIENTS_H_
+#define _DRM_CLIENTS_H_
+
+#include <drm/drm_file.h>
+
+struct drm_pid_clients {
+	atomic_t num;
+	struct list_head file_list;
+	struct rcu_head rcu;
+};
+
+#if IS_ENABLED(CONFIG_CGROUP_DRM)
+void drm_clients_close(struct drm_file *file_priv);
+int drm_clients_open(struct drm_file *file_priv);
+
+void
+drm_clients_migrate(struct drm_file *file_priv,
+		    unsigned long old,
+		    unsigned long new);
+#else
+static inline void drm_clients_close(struct drm_file *file_priv)
+{
+}
+
+static inline int drm_clients_open(struct drm_file *file_priv)
+{
+	return 0;
+}
+
+static void
+drm_clients_migrate(struct drm_file *file_priv,
+		    unsigned long old,
+		    unsigned long new)
+{
+
+}
+#endif
+
+#endif
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index b8be69b551af..ad20aaad40f5 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -275,6 +275,10 @@ struct drm_file {
 	/** @minor: &struct drm_minor for this file. */
 	struct drm_minor *minor;
 
+#if IS_ENABLED(CONFIG_CGROUP_DRM)
+	struct list_head clink;
+#endif
+
 	/**
 	 * @object_idr:
 	 *
-- 
2.34.1

