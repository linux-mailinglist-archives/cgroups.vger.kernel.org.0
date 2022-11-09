Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA3A622FE0
	for <lists+cgroups@lfdr.de>; Wed,  9 Nov 2022 17:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiKIQMx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Nov 2022 11:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiKIQMZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Nov 2022 11:12:25 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4808210FE6;
        Wed,  9 Nov 2022 08:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668010344; x=1699546344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+tkTnG1kbfQkuQWu7X2WwiAikHzraT6aROxd5PKF3OE=;
  b=KkXfG5UOC8FnwK3BUSvUAUaauAYhy9JDQd9nHEuvFTisnIwGpW5diy49
   +s1YSZrd1qsSFXiTzjn3KbD1rEaLolOLaa8FBegD3HslpvvI9Sh6aY8d0
   VOV9iW7CgBoJXRmJb6DcyOMRNWXrC0zPwm6XfCLbNyEg9yx5Qo8TDVdn/
   94WtnDDLyTvrEOwcUXrlfSBLbNY7/p8ArfPwQSM1OlmnrmEfolMovKDrJ
   kRhiAkpOHGzjteP/oieVOeHSRPqdefHjHSadXw/2sFjhgTx6VGlwwO33u
   BWWvJUwGcx3w5wiLKg16oW1QT3E5LEp4zkeBODYjAqn6K5J0KmZ+dXN+1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312181384"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="312181384"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="811684529"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="811684529"
Received: from smurnane-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.196.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:20 -0800
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
Subject: [RFC 07/13] drm/cgroup: Add ability to query drm cgroup GPU time
Date:   Wed,  9 Nov 2022 16:11:35 +0000
Message-Id: <20221109161141.2987173-8-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
References: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
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

Add a driver callback and core helper which allow querying the time spent
on GPUs for processes belonging to a group.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/drm_cgroup.c | 24 ++++++++++++++++++++++++
 include/drm/drm_clients.h    |  2 ++
 include/drm/drm_drv.h        | 28 ++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/drm_cgroup.c b/drivers/gpu/drm/drm_cgroup.c
index 94e6f39b90c7..06810b4c3ff1 100644
--- a/drivers/gpu/drm/drm_cgroup.c
+++ b/drivers/gpu/drm/drm_cgroup.c
@@ -128,3 +128,27 @@ drm_clients_migrate(struct drm_file *file_priv,
 	atomic_inc(&clients->num);
 	list_add_tail_rcu(&file_priv->clink, &clients->file_list);
 }
+
+u64 drm_pid_get_active_time_us(struct pid *pid)
+{
+	struct drm_pid_clients *clients;
+	u64 total = 0;
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
+			if (cg_ops && cg_ops->active_time_us)
+				total += cg_ops->active_time_us(fpriv);
+		}
+	}
+	rcu_read_unlock();
+
+	return total;
+}
+EXPORT_SYMBOL_GPL(drm_pid_get_active_time_us);
diff --git a/include/drm/drm_clients.h b/include/drm/drm_clients.h
index fbb8cffdf7a9..b9b8009c28a6 100644
--- a/include/drm/drm_clients.h
+++ b/include/drm/drm_clients.h
@@ -41,4 +41,6 @@ drm_clients_migrate(struct drm_file *file_priv,
 }
 #endif
 
+u64 drm_pid_get_active_time_us(struct pid *pid);
+
 #endif
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index f6159acb8856..c09fe9bd517f 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -148,6 +148,24 @@ enum drm_driver_feature {
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
+	 * @active_time_us:
+	 *
+	 * Optional callback for reporting the GPU time consumed by this client.
+	 *
+	 * Used by the DRM core when queried by the DRM cgroup controller.
+	 */
+	u64 (*active_time_us) (struct drm_file *);
+};
+
 /**
  * struct drm_driver - DRM driver structure
  *
@@ -459,6 +477,16 @@ struct drm_driver {
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
-- 
2.34.1

