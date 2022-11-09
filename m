Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEB9622FED
	for <lists+cgroups@lfdr.de>; Wed,  9 Nov 2022 17:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiKIQN2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Nov 2022 11:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiKIQMw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Nov 2022 11:12:52 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32489252A4;
        Wed,  9 Nov 2022 08:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668010363; x=1699546363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a7D9TOFF4QZXnog+7lQ4amXbM/ZFMku48rQ12ekKnqE=;
  b=Y9/O9zHEv0YDnZiVgHF+fitrsC+2nBK4bcbXZLcNlMRatha3B9RR4JhX
   mjz3H3c87B4ybfRbKLEo57QwKeL0ORdK0bRiNbj3rRt0gZnKwEHdcxoRG
   bpHJEtCTu7u+nbhweFAL0vkmZpb9FDx7ESfcSMSsduoDebwE6sDAevGrK
   25k4btrvz6q/MGeXZpOizCB8dJTn8uE7BejzRL8g4Fmk9ZA4S/j1i9yWl
   2p8/P6YM9ruI0BAGGAISs+7imyMlRLkUOOZKeZ5Flf30jdWkzbOIF7MbX
   rJK8iRqdpRzUWM0o+SqoBAC2PBVujxY2hIRKKtHXTh/+6PBX261klMBOg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312181477"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="312181477"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="811684604"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="811684604"
Received: from smurnane-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.196.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:38 -0800
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
Subject: [RFC 12/13] drm/i915: Wire up with drm controller GPU time query
Date:   Wed,  9 Nov 2022 16:11:40 +0000
Message-Id: <20221109161141.2987173-13-tvrtko.ursulin@linux.intel.com>
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

Implement the drm_cgroup_ops->active_time_us callback.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/i915/i915_driver.c     | 10 ++++
 drivers/gpu/drm/i915/i915_drm_client.c | 76 ++++++++++++++++++++++----
 drivers/gpu/drm/i915/i915_drm_client.h |  2 +
 3 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index c3d43f9b1e45..96a7da5258c4 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1894,6 +1894,12 @@ static const struct drm_ioctl_desc i915_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(I915_GEM_VM_DESTROY, i915_gem_vm_destroy_ioctl, DRM_RENDER_ALLOW),
 };
 
+#ifdef CONFIG_CGROUP_DRM
+static const struct drm_cgroup_ops i915_drm_cgroup_ops = {
+	.active_time_us = i915_drm_cgroup_get_active_time_us,
+};
+#endif
+
 /*
  * Interface history:
  *
@@ -1922,6 +1928,10 @@ static const struct drm_driver i915_drm_driver = {
 	.lastclose = i915_driver_lastclose,
 	.postclose = i915_driver_postclose,
 
+#ifdef CONFIG_CGROUP_DRM
+	.cg_ops = &i915_drm_cgroup_ops,
+#endif
+
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_import = i915_gem_prime_import,
diff --git a/drivers/gpu/drm/i915/i915_drm_client.c b/drivers/gpu/drm/i915/i915_drm_client.c
index b09d1d386574..c9754cb0277f 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.c
+++ b/drivers/gpu/drm/i915/i915_drm_client.c
@@ -75,7 +75,7 @@ void i915_drm_clients_fini(struct i915_drm_clients *clients)
 	xa_destroy(&clients->xarray);
 }
 
-#ifdef CONFIG_PROC_FS
+#if defined(CONFIG_PROC_FS) || defined(CONFIG_CGROUP_DRM)
 static const char * const uabi_class_names[] = {
 	[I915_ENGINE_CLASS_RENDER] = "render",
 	[I915_ENGINE_CLASS_COPY] = "copy",
@@ -100,22 +100,78 @@ static u64 busy_add(struct i915_gem_context *ctx, unsigned int class)
 	return total;
 }
 
-static void
-show_client_class(struct seq_file *m,
-		  struct i915_drm_client *client,
-		  unsigned int class)
+static u64 get_class_active_ns(struct i915_drm_client *client,
+			       unsigned int class,
+			       unsigned int *capacity)
 {
-	const struct list_head *list = &client->ctx_list;
-	u64 total = atomic64_read(&client->past_runtime[class]);
-	const unsigned int capacity =
-		client->clients->i915->engine_uabi_class_count[class];
 	struct i915_gem_context *ctx;
+	u64 total;
+
+	*capacity =
+	    client->clients->i915->engine_uabi_class_count[class];
+	if (!*capacity)
+		return 0;
+
+	total = atomic64_read(&client->past_runtime[class]);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(ctx, list, client_link)
+	list_for_each_entry_rcu(ctx, &client->ctx_list, client_link)
 		total += busy_add(ctx, class);
 	rcu_read_unlock();
 
+	return total;
+}
+#endif
+
+#ifdef CONFIG_CGROUP_DRM
+static bool supports_stats(struct drm_i915_private *i915)
+{
+	if (GRAPHICS_VER(i915) < 8)
+		return false;
+
+	/* temporary... */
+	if (intel_uc_uses_guc_submission(&to_gt(i915)->uc))
+		return false;
+
+	return true;
+}
+
+u64 i915_drm_cgroup_get_active_time_us(struct drm_file *file)
+{
+	struct drm_i915_file_private *fpriv = file->driver_priv;
+	struct i915_drm_client *client = fpriv->client;
+	unsigned int i;
+	u64 busy = 0;
+
+	if (!supports_stats(client->clients->i915))
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(uabi_class_names); i++) {
+		unsigned int capacity;
+		u64 b;
+
+		b = get_class_active_ns(client, i, &capacity);
+		if (capacity) {
+			b = DIV_ROUND_UP_ULL(b, capacity * 1000);
+			busy += b;
+		}
+	}
+
+	return busy;
+}
+#endif
+
+#ifdef CONFIG_PROC_FS
+static void
+show_client_class(struct seq_file *m,
+		  struct i915_drm_client *client,
+		  unsigned int class)
+{
+	unsigned int capacity;
+	u64 total;
+
+	total = get_class_active_ns(client, class, &capacity);
+
 	if (capacity)
 		seq_printf(m, "drm-engine-%s:\t%llu ns\n",
 			   uabi_class_names[class], total);
diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i915/i915_drm_client.h
index 69496af996d9..c8439eaa89be 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.h
+++ b/drivers/gpu/drm/i915/i915_drm_client.h
@@ -65,4 +65,6 @@ void i915_drm_client_fdinfo(struct seq_file *m, struct file *f);
 
 void i915_drm_clients_fini(struct i915_drm_clients *clients);
 
+u64 i915_drm_cgroup_get_active_time_us(struct drm_file *file);
+
 #endif /* !__I915_DRM_CLIENT_H__ */
-- 
2.34.1

