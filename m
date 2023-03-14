Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CC76B97B1
	for <lists+cgroups@lfdr.de>; Tue, 14 Mar 2023 15:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCNOUW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 10:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCNOTy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 10:19:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865F6BDCE;
        Tue, 14 Mar 2023 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678803579; x=1710339579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=raKUxSv4ojFNFa7oNu8geuj7x2x6g9Q1/OIQOduxzss=;
  b=lJZRhVbSWbUp74XRygoicxcDUULcrQA3Hvzs9aqWjWX5iiRvNnmVishw
   wv6IGpY2wFPIRyTUiSfCYNAf9VpsyTQ7ObYqcyIG5+76kfxJUdnhNcD2B
   aaI9tBFWigluoks0M3oDORJO/VYNqLOukbUw3N3O7d8J+2OI/XQe9fiGV
   8aO7o/Jn6oNj5o3iyRFuuVz6wGUp2U8txcu38xiqw0olxc0qeyp31xzcP
   4G3aJYiI68wPTHhk0BOz+NXfXfIDgpxAWyjZ4KufYH2UJS2Gd1my5gLFM
   ylVtGr87emT59lENRxvnuFWIucgfAlD+Bopo8cQnfd9wkLCybHYcEsA+h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321284751"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="321284751"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 07:19:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="656363242"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="656363242"
Received: from mjtillin-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.236.227])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 07:19:29 -0700
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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
Subject: [RFC 04/10] drm/cgroup: Track DRM clients per cgroup
Date:   Tue, 14 Mar 2023 14:18:58 +0000
Message-Id: <20230314141904.1210824-5-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314141904.1210824-1-tvrtko.ursulin@linux.intel.com>
References: <20230314141904.1210824-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

To enable propagation of settings from the cgroup DRM controller to DRM
and vice-versa, we need to start tracking to which cgroups DRM clients
belong.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/drm_file.c |  6 ++++
 include/drm/drm_file.h     |  6 ++++
 include/linux/cgroup_drm.h | 20 ++++++++++++
 kernel/cgroup/drm.c        | 62 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index f2f8175ece15..f6bad820b7ee 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -32,6 +32,7 @@
  */
 
 #include <linux/anon_inodes.h>
+#include <linux/cgroup_drm.h>
 #include <linux/dma-fence.h>
 #include <linux/file.h>
 #include <linux/module.h>
@@ -300,6 +301,8 @@ static void drm_close_helper(struct file *filp)
 	list_del(&file_priv->lhead);
 	mutex_unlock(&dev->filelist_mutex);
 
+	drmcgroup_client_close(file_priv);
+
 	drm_file_free(file_priv);
 }
 
@@ -363,6 +366,8 @@ int drm_open_helper(struct file *filp, struct drm_minor *minor)
 	list_add(&priv->lhead, &dev->filelist);
 	mutex_unlock(&dev->filelist_mutex);
 
+	drmcgroup_client_open(priv);
+
 #ifdef CONFIG_DRM_LEGACY
 #ifdef __alpha__
 	/*
@@ -529,6 +534,7 @@ void drm_file_update_pid(struct drm_file *filp)
 	mutex_unlock(&dev->filelist_mutex);
 
 	if (pid != old) {
+		drmcgroup_client_migrate(filp);
 		get_pid(pid);
 		synchronize_rcu();
 		put_pid(old);
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 27d545131d4a..e3e0de0a8ec4 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -30,6 +30,7 @@
 #ifndef _DRM_FILE_H_
 #define _DRM_FILE_H_
 
+#include <linux/cgroup.h>
 #include <linux/types.h>
 #include <linux/completion.h>
 #include <linux/idr.h>
@@ -279,6 +280,11 @@ struct drm_file {
 	/** @minor: &struct drm_minor for this file. */
 	struct drm_minor *minor;
 
+#if IS_ENABLED(CONFIG_CGROUP_DRM)
+	struct cgroup_subsys_state *__css;
+	struct list_head clink;
+#endif
+
 	/**
 	 * @object_idr:
 	 *
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 8ef66a47619f..176431842d8e 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -6,4 +6,24 @@
 #ifndef _CGROUP_DRM_H
 #define _CGROUP_DRM_H
 
+#include <drm/drm_file.h>
+
+#if IS_ENABLED(CONFIG_CGROUP_DRM)
+void drmcgroup_client_open(struct drm_file *file_priv);
+void drmcgroup_client_close(struct drm_file *file_priv);
+void drmcgroup_client_migrate(struct drm_file *file_priv);
+#else
+static inline void drmcgroup_client_open(struct drm_file *file_priv)
+{
+}
+
+static inline void drmcgroup_client_close(struct drm_file *file_priv)
+{
+}
+
+static void drmcgroup_client_migrate(struct drm_file *file_priv)
+{
+}
+#endif
+
 #endif	/* _CGROUP_DRM_H */
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 02c8eaa633d3..d702be1b441f 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -5,17 +5,25 @@
 
 #include <linux/cgroup.h>
 #include <linux/cgroup_drm.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 
 struct drm_cgroup_state {
 	struct cgroup_subsys_state css;
+
+	struct list_head clients;
 };
 
 struct drm_root_cgroup_state {
 	struct drm_cgroup_state drmcs;
 };
 
-static struct drm_root_cgroup_state root_drmcs;
+static struct drm_root_cgroup_state root_drmcs = {
+	.drmcs.clients = LIST_HEAD_INIT(root_drmcs.drmcs.clients),
+};
+
+static DEFINE_MUTEX(drmcg_mutex);
 
 static inline struct drm_cgroup_state *
 css_to_drmcs(struct cgroup_subsys_state *css)
@@ -42,11 +50,63 @@ drmcs_alloc(struct cgroup_subsys_state *parent_css)
 		drmcs = kzalloc(sizeof(*drmcs), GFP_KERNEL);
 		if (!drmcs)
 			return ERR_PTR(-ENOMEM);
+
+		INIT_LIST_HEAD(&drmcs->clients);
 	}
 
 	return &drmcs->css;
 }
 
+void drmcgroup_client_open(struct drm_file *file_priv)
+{
+	struct drm_cgroup_state *drmcs;
+
+	drmcs = css_to_drmcs(task_get_css(current, drm_cgrp_id));
+
+	mutex_lock(&drmcg_mutex);
+	file_priv->__css = &drmcs->css; /* Keeps the reference. */
+	list_add_tail(&file_priv->clink, &drmcs->clients);
+	mutex_unlock(&drmcg_mutex);
+}
+EXPORT_SYMBOL_GPL(drmcgroup_client_open);
+
+void drmcgroup_client_close(struct drm_file *file_priv)
+{
+	struct drm_cgroup_state *drmcs;
+
+	drmcs = css_to_drmcs(file_priv->__css);
+
+	mutex_lock(&drmcg_mutex);
+	list_del(&file_priv->clink);
+	file_priv->__css = NULL;
+	mutex_unlock(&drmcg_mutex);
+
+	css_put(&drmcs->css);
+}
+EXPORT_SYMBOL_GPL(drmcgroup_client_close);
+
+void drmcgroup_client_migrate(struct drm_file *file_priv)
+{
+	struct drm_cgroup_state *src, *dst;
+	struct cgroup_subsys_state *old;
+
+	mutex_lock(&drmcg_mutex);
+
+	old = file_priv->__css;
+	src = css_to_drmcs(old);
+	dst = css_to_drmcs(task_get_css(current, drm_cgrp_id));
+
+	if (src != dst) {
+		file_priv->__css = &dst->css; /* Keeps the reference. */
+		list_move_tail(&file_priv->clink, &dst->clients);
+	}
+
+	mutex_unlock(&drmcg_mutex);
+
+	css_put(old);
+}
+EXPORT_SYMBOL_GPL(drmcgroup_client_migrate);
+
 struct cftype files[] = {
 	{ } /* Zero entry terminates. */
 };
-- 
2.37.2

