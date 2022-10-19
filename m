Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD517604EE2
	for <lists+cgroups@lfdr.de>; Wed, 19 Oct 2022 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiJSRel (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Oct 2022 13:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiJSReU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Oct 2022 13:34:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94851C25F1;
        Wed, 19 Oct 2022 10:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666200858; x=1697736858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oo5u0fET53D72nvRAabovnCgKyLAZjX42LHHrPrrjv8=;
  b=K8Qm5BGDs9mFL6w5gMvb5T/N5v+NwR+fhsZKoIWRO0XxP8a0obb9A3TU
   KLyt+RdvpyHHUOKBPa9oq0TLvRRWv/uq+4UrfoYLnO5nPMr4ud6dT1XTX
   eQflU6/b/7fRjzR7xn0g3jNVrwHUC9+V0Xxc78+FPnwaStt+Q6KPeVh5M
   MyRwUegJ+UxoPH5i3qhcsAQBUZxvRwxdu2aHW9D5yDt2ziuBqbjKf/AMs
   KGGkVjI1SxMl83hdRPuyHq4pjfDlHF6mj+vwfCZyRZbiG+iRiMITWLeBp
   JLJrZw8D2C97jnPzZbnanGvNUOQ8qv2yM2SpevEnoyA6IzBaLf9iBPS0p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="306474610"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="306474610"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:34:13 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607204926"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607204926"
Received: from mjmcener-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.213.233.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:34:10 -0700
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
Subject: [RFC 16/17] drm/i915: Wire up with drm controller GPU time query
Date:   Wed, 19 Oct 2022 18:32:53 +0100
Message-Id: <20221019173254.3361334-17-tvrtko.ursulin@linux.intel.com>
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

Implement the drm_cgroup_ops->active_time_us callback.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/i915/i915_driver.c     |   1 +
 drivers/gpu/drm/i915/i915_drm_client.c | 106 +++++++++++++++++++------
 drivers/gpu/drm/i915/i915_drm_client.h |   2 +
 3 files changed, 83 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 7912782b87cc..b949fd715202 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1896,6 +1896,7 @@ static const struct drm_ioctl_desc i915_ioctls[] = {
 #ifdef CONFIG_CGROUP_DRM
 static const struct drm_cgroup_ops i915_drm_cgroup_ops = {
 	.priority_levels = i915_drm_priority_levels,
+	.active_time_us = i915_drm_cgroup_get_active_time_us,
 };
 #endif
 
diff --git a/drivers/gpu/drm/i915/i915_drm_client.c b/drivers/gpu/drm/i915/i915_drm_client.c
index 61a3cdaa7b16..8527fe80d449 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.c
+++ b/drivers/gpu/drm/i915/i915_drm_client.c
@@ -75,23 +75,7 @@ void i915_drm_clients_fini(struct i915_drm_clients *clients)
 	xa_destroy(&clients->xarray);
 }
 
-#ifdef CONFIG_CGROUP_DRM
-unsigned int i915_drm_priority_levels(struct drm_file *file)
-{
-	struct drm_i915_file_private *fpriv = file->driver_priv;
-	struct i915_drm_client *client = fpriv->client;
-	struct drm_i915_private *i915 = client->clients->i915;
-
-	if (GRAPHICS_VER(i915) < 8)
-		return 0;
-	else if (intel_uc_uses_guc_submission(&to_gt(i915)->uc))
-		return 3;
-	else
-		return 2047;
-}
-#endif
-
-#ifdef CONFIG_PROC_FS
+#if defined(CONFIG_PROC_FS) || defined(CONFIG_CGROUP_DRM)
 static const char * const uabi_class_names[] = {
 	[I915_ENGINE_CLASS_RENDER] = "render",
 	[I915_ENGINE_CLASS_COPY] = "copy",
@@ -116,22 +100,92 @@ static u64 busy_add(struct i915_gem_context *ctx, unsigned int class)
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
+unsigned int i915_drm_priority_levels(struct drm_file *file)
+{
+	struct drm_i915_file_private *fpriv = file->driver_priv;
+	struct i915_drm_client *client = fpriv->client;
+	struct drm_i915_private *i915 = client->clients->i915;
+
+	if (GRAPHICS_VER(i915) < 8)
+		return 0;
+	else if (intel_uc_uses_guc_submission(&to_gt(i915)->uc))
+		return 3;
+	else
+		return 2047;
+}
+
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
index bd5925241007..99b8ae01c183 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.h
+++ b/drivers/gpu/drm/i915/i915_drm_client.h
@@ -69,4 +69,6 @@ void i915_drm_clients_fini(struct i915_drm_clients *clients);
 
 unsigned int i915_drm_priority_levels(struct drm_file *file);
 
+u64 i915_drm_cgroup_get_active_time_us(struct drm_file *file);
+
 #endif /* !__I915_DRM_CLIENT_H__ */
-- 
2.34.1

